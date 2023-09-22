import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';
import 'oriented_size_box.dart';

class File {
  final String fileTitle;
  final Uri fileUrl;

  const File({
    required this.fileTitle,
    required this.fileUrl,
  });
}

class FileListButtons extends StatelessWidget {
  final List<File> files;

  const FileListButtons({
    Key? key,
    required this.files,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      width: double.infinity,
      child: ToggleButtons(
        direction: Axis.vertical,
        onPressed: (int index) {
          launchUrl(files[index].fileUrl);
        },
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        selectedBorderColor: Colors.red[700],
        selectedColor: Colors.white,
        fillColor: Colors.red,
        color: Colors.red[400],
        isSelected: files.map((e) => true).toList(),
        children: files.map((e) => PaddedText(text: e.fileTitle)).toList(),
      ),
    );
  }
}

class PaddedText extends StatelessWidget {
  final String text;

  const PaddedText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(text),
    );
  }
}

class ColonneLinks extends StatefulWidget {
  final double fraction;
  final Size size;

  const ColonneLinks({
    Key? key,
    required this.fraction,
    required this.size,
  }) : super(key: key);

  @override
  State<ColonneLinks> createState() => _ColonneLinksState();
}

class _ColonneLinksState extends State<ColonneLinks> {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<File>> getFiles(String folderName) async {
    final Reference folderRef = storage.ref().child(folderName);
    final ListResult result = await folderRef.listAll();
    var futures = result.items.map((Reference ref) async {
      var fileUrl = await ref.getDownloadURL();
      return File(
        fileTitle: ref.name.replaceAll("_", " ").toUpperCase(),
        fileUrl: Uri.parse(fileUrl),
      );
    }).toList();
    return Future.wait(futures);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = getMDTheme(context, Colors.black).h1;
    return OrientedSizedBox(
      size: widget.size,
      fraction: widget.fraction,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(children: [
          Text(
            "Documents",
            style: titleStyle,
          ),
          FutureBuilder(
            future: getFiles("documents"),
            builder:
                (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return const Text(
                        "Erreur lors de la récupération des documents");
                  } else if (snapshot.hasData) {
                    List<File> files = snapshot.data ?? [];
                    if (files.isEmpty) {
                      return const Text(
                          "Vous retrouverez l'ensemble des documents à cet endroit");
                    } else {
                      return FileListButtons(files: files);
                    }
                  }
                  break;
                default:
                  return const Text(
                      "En attente de données..."); // Ajoutez une valeur par défaut ici
              }
              return const SizedBox(); // Une valeur de retour par défaut si aucun cas n'est atteint
            },
          ),
          Text(
            "Ceinture Noire",
            style: titleStyle,
          ),
          FutureBuilder(
            future: getFiles("ceinture_noire"),
            builder:
                (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
              if (snapshot.hasData) {
                List<File> files = snapshot.data ?? [];
                if (files.isEmpty) {
                  return const Text(
                      "Vous retrouverez l'ensemble des documents sur le passage de la ceinture noire à cet endroit");
                } else {
                  return FileListButtons(files: files);
                }
              } else if (snapshot.hasError) {
                return const Text(
                    "Erreur lors de la récupération des documents");
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          Text(
            "Compétitions",
            style: titleStyle,
          ),
          FutureBuilder(
            future: getFiles("competitions"),
            builder:
                (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
              if (snapshot.hasData) {
                List<File> files = snapshot.data ?? [];
                if (files.isEmpty) {
                  return const Text(
                      "Vous retrouverez toutes les convocations pour les compétitions à cet endroit");
                } else {
                  return FileListButtons(files: files);
                }
              } else if (snapshot.hasError) {
                return const Text(
                    "Erreur lors de la récupération des compétitions");
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ]),
      )),
    );
  }
}
