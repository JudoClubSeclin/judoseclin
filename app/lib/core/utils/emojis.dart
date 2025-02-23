import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class EmojiUtils {
  static final Map<String, pw.MemoryImage> _emojiCache = {};
  static final List<String> _emojiNames = [
    "personne",
    "adresse",
    "calandrier",
    "categorie",
    "ceinture",
    "certificate",
    "email",
    "facture",
    "images",
    "licence",
    "phone",
    "sante",
    "tuteur",
    "discipline",
  ];

  /// Charge toutes les images en mémoire une seule fois
  static Future<void> preloadEmojis() async {
    for (String name in _emojiNames) {
      final ByteData data = await rootBundle.load("assets/emojis/$name.png");
      _emojiCache[name] = pw.MemoryImage(data.buffer.asUint8List());
    }
  }

  /// Retourne un emoji déjà chargé, ou `null` si l'emoji n'existe pas
  static pw.MemoryImage? pdfEmoji(String value) {
    return _emojiCache[value];
  }

  /// Génération dynamique des getters
  static Map<String, pw.MemoryImage?> get allEmojis => {
    for (var name in _emojiNames) name: _emojiCache[name],
  };
}
