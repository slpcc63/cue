#!/bin/sh
set -eu

usage() {
    cat <<'EOF'
Usage: Scripts/archive-testflight.sh --output /absolute/directory [--upload]

Creates a clean, signed Release archive and App Store Connect export for Cue.
The output directory must not already exist and must be outside the repository.
Add --upload to send the validated archive to App Store Connect/TestFlight.

The script uses Cue's committed automatic-signing settings and permits Xcode to
create or refresh the team's distribution certificate and provisioning profile.
It never changes the source checkout, version, build number, or bundle identifier.
EOF
}

OUTPUT=
UPLOAD=0
while [ "$#" -gt 0 ]; do
    case "$1" in
        --output)
            [ "$#" -ge 2 ] || { usage >&2; exit 2; }
            OUTPUT=$2
            shift 2
            ;;
        --upload)
            UPLOAD=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            usage >&2
            exit 2
            ;;
    esac
done

[ -n "$OUTPUT" ] || { usage >&2; exit 2; }
case "$OUTPUT" in
    /*) ;;
    *) printf '%s\n' 'ERROR: --output must be an absolute path.' >&2; exit 2 ;;
esac

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
case "$OUTPUT/" in
    "$ROOT"/*)
        printf '%s\n' 'ERROR: --output must be outside the repository.' >&2
        exit 2
        ;;
esac
[ ! -e "$OUTPUT" ] || { printf '%s\n' 'ERROR: output path already exists.' >&2; exit 2; }
[ -z "$(git -C "$ROOT" status --porcelain=v1 --untracked-files=all)" ] || {
    printf '%s\n' 'ERROR: repository must be clean before creating a release archive.' >&2
    exit 4
}

DEVELOPER_DIR=${DEVELOPER_DIR:-/Applications/Xcode.app/Contents/Developer}
[ -x "$DEVELOPER_DIR/usr/bin/xcodebuild" ] || {
    printf '%s\n' 'ERROR: full Xcode is required. Set DEVELOPER_DIR if it is elsewhere.' >&2
    exit 3
}
export DEVELOPER_DIR

mkdir -m 700 "$OUTPUT"
ARCHIVE="$OUTPUT/Cue.xcarchive"
DERIVED="$OUTPUT/DerivedData"
EXPORT="$OUTPUT/export"
OPTIONS="$OUTPUT/ExportOptions.plist"
DESTINATION=export
[ "$UPLOAD" -eq 0 ] || DESTINATION=upload

cat > "$OPTIONS" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>destination</key>
    <string>$DESTINATION</string>
    <key>manageAppVersionAndBuildNumber</key>
    <false/>
    <key>method</key>
    <string>app-store-connect</string>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>teamID</key>
    <string>76GL5MBUM8</string>
    <key>uploadSymbols</key>
    <true/>
</dict>
</plist>
EOF

xcodebuild \
    -project "$ROOT/Cue.xcodeproj" \
    -scheme Cue \
    -configuration Release \
    -destination 'generic/platform=iOS' \
    -archivePath "$ARCHIVE" \
    -derivedDataPath "$DERIVED" \
    -allowProvisioningUpdates \
    archive

xcodebuild \
    -exportArchive \
    -archivePath "$ARCHIVE" \
    -exportOptionsPlist "$OPTIONS" \
    -exportPath "$EXPORT" \
    -allowProvisioningUpdates

printf '%s\n' "Cue TestFlight release output: $OUTPUT"
if [ "$UPLOAD" -eq 1 ]; then
    printf '%s\n' 'Upload completed; verify processing and tester availability in App Store Connect.'
else
    printf '%s\n' 'Export completed; rerun with a new output path and --upload to deliver to App Store Connect.'
fi
