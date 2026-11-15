# Distribute Cue through TestFlight

Cue is an iPhone-only app with bundle identifier `com.slpcc63.cue`, listed in
App Store Connect as "Cue by SLPCC63" (home-screen name: Cue). The Xcode project
uses automatic signing for team `76GL5MBUM8` (the same team as Prism), declares
that the app does not use non-exempt encryption, and keeps the version/build
identity in the committed project settings (`MARKETING_VERSION`,
`CURRENT_PROJECT_VERSION` in `Cue.xcodeproj`).

## Prerequisites

1. Apple Developer Program membership is active for team `76GL5MBUM8`.
2. Xcode is signed in to an Apple Account with access to that team and permission
   to upload builds.
3. App Store Connect contains an iOS app named "Cue by SLPCC63" whose bundle ID is
   exactly `com.slpcc63.cue`. Do not change the bundle ID to work around a
   missing record.
4. The repository is clean and the intended version/build number is committed.
   Never reuse an uploaded build number (see NEVER-DO.md).

## Archive and validate distribution signing

Use a new absolute output path outside the repository. The script refuses an
existing path or a dirty checkout, archives the Release configuration, and lets
Xcode create or refresh the team's distribution certificate and App Store
provisioning profile.

```sh
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer \
  ./Scripts/archive-testflight.sh --output /private/tmp/cue-testflight-0.0.1-1
```

A successful export produces `export/Cue.ipa` next to the signed
`Cue.xcarchive`. This checks the local archive and export only; it does not mean
Apple has received or processed the build.

## Upload

Use a different, new output path and explicitly add `--upload`:

```sh
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer \
  ./Scripts/archive-testflight.sh \
  --output /private/tmp/cue-testflight-0.0.1-1-upload \
  --upload
```

After Xcode reports a successful upload, App Store Connect must still finish
processing the build. In App Store Connect, open Cue by SLPCC63 > TestFlight,
resolve any export-compliance or beta-information prompt, add the build to the
Owner Testing internal group, and invite Shannon. The release is verified only
after the processed build is visible and Cue installs from the TestFlight app.

If Apple rejects a reused build number, increment `CURRENT_PROJECT_VERSION`
(both Debug and Release), commit it, and archive again. Do not overwrite or
relabel a previously uploaded build.
