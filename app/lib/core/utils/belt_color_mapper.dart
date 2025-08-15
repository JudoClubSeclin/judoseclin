const Map<String, String> beltColorsEnter = {
  'white': 'blanc',
  'whirt-yellow': 'blanc-jaune',
  'yellow': 'jaune',
  'yellow-orange': 'jaune-orange',
  'orange': 'orange',
  'orange-green': 'orange-vert',
  'green': 'vert',
  'blue': 'bleu',
  'brown': 'marron',
  'black': 'noir',
};

final Map<String, String> beltColorsFrToEn = {
  for (var entry in beltColorsEnter.entries) entry.value: entry.key
};

String beltEnToFr(String en) => beltColorsEnter[en.toLowerCase()] ?? en;
String beltFrToEn(String fr) => beltColorsFrToEn[fr.toLowerCase()] ?? fr;

/// Liste ordonnée de ceintures pour comparaison logique (niveau croissant)
const List<String> beltOrder = [
  'white',
  'whirt-yellow',
  'yellow',
  'yellow-orange',
  'orange',
  'orange-green',
  'green',
  'blue',
  'brown',
  'black',
];
