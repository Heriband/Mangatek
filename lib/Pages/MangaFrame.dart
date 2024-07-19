import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:mangatek/Model/Manga.dart';

import 'MangaPage.dart';
import '../Scraper/Scraper.dart';

String URL = "https://www.nautiljon.com";

class MangaFrame extends StatefulWidget {
  Manga manga;

  MangaFrame({required this.manga});

  @override
  MangaFrameState createState() => MangaFrameState();
}

class MangaFrameState extends State<MangaFrame> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Scraper.getInstance().getNbVolume(widget.manga.name);
    return FutureBuilder<String>(
        future: Scraper.getInstance().getPathImage(widget.manga.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            String x = snapshot.data ?? "";
            return Container(
              height: 400,
              /*decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),*/
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async => {
                      await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  MangaPage(manga: widget.manga)))
                    },
                    child: Image(
                      image: NetworkImage(x) ,
                      height: 260,
                    ),
                  ),

                  /*onPressed: () async {
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MangaPage()),
                      );
                    },*/
                  SizedBox(height: 5),
                  Text(
                    widget.manga.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                      decoration: TextDecoration.overline,
                    ),
                  ),
                  SizedBox(height: 5),

                  //Text(widget.manga.volume.toString()),
                ],
              ),
            );
          }
        });
  }
}
