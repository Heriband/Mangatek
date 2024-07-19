import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangatek/Pages/MangaFrame.dart';
import 'package:mangatek/Model/Manga.dart';

import '../Database/dataBase.dart';
import '../main.dart';

const String DATABASENAME = "MangatekDataBase.db";
const String MANGATABLE = "MangaTable";
const String COLUMNID = "id";

class Biblio extends StatefulWidget {
  @override
  BiblioState createState() => BiblioState();
}

class BiblioState extends State<Biblio> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Manga>>(
        future: myData.getMangas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final mangas = snapshot.data ?? [];
            if (true)
              mangas.sort((a, b) => a.name.compareTo(b.name));
            else
              mangas.sort((a, b) => b.popularity.compareTo(a.popularity));
            return GridView.extent(
              childAspectRatio: 0.61,
              padding: EdgeInsets.all(1.0),
              maxCrossAxisExtent: 250, //largeur max
              children: List<MangaFrame>.generate(
                  mangas.length, (index) => MangaFrame(manga: mangas[index])),
            );
          }
        });
  }
}
