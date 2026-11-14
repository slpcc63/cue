import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View } from 'react-native';
import { SafeAreaProvider, SafeAreaView } from 'react-native-safe-area-context';

// Phase 0 placeholder. In M1 this card is filled by the decision engine:
// one recommendation, plus a "Why?" that shows the beliefs behind it.
export default function App() {
  return (
    <SafeAreaProvider>
    <SafeAreaView style={styles.screen}>
      <Text style={styles.brand}>Cue</Text>
      <View style={styles.card}>
        <Text style={styles.label}>NEXT</Text>
        <Text style={styles.action}>Nothing to do yet.</Text>
        <Text style={styles.detail}>
          This is Phase 0. In M1, this card will tell you when to leave for your next shift.
        </Text>
      </View>
      <StatusBar style="dark" />
    </SafeAreaView>
    </SafeAreaProvider>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: '#F7F5F2',
    paddingHorizontal: 24,
  },
  brand: {
    marginTop: 24,
    fontSize: 28,
    fontWeight: '700',
    color: '#1F1D1A',
  },
  card: {
    marginTop: 32,
    padding: 24,
    borderRadius: 20,
    backgroundColor: '#FFFFFF',
    shadowColor: '#000',
    shadowOpacity: 0.06,
    shadowRadius: 12,
    shadowOffset: { width: 0, height: 4 },
  },
  label: {
    fontSize: 12,
    letterSpacing: 1.5,
    fontWeight: '600',
    color: '#8A847C',
  },
  action: {
    marginTop: 8,
    fontSize: 24,
    fontWeight: '600',
    color: '#1F1D1A',
  },
  detail: {
    marginTop: 12,
    fontSize: 15,
    lineHeight: 21,
    color: '#5C574F',
  },
});
