import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangatek/Scraper/Scraper.dart';
import 'package:mangatek/main.dart';

import '../Database/dataBase.dart';
import '../Model/Manga.dart';

class MangaPage extends StatefulWidget {

  Manga manga;

  MangaPage({required this.manga});

  @override
  _ManagaPageState createState() => _ManagaPageState();


}

class _ManagaPageState extends State<MangaPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [

          IconButton(
              onPressed: () async => await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage())),
              icon:  Icon(Icons.arrow_back))
        ],


        title: Text( "MangaTek"),
      ),
      body : Column(
        children: [
          Text(widget.manga.name),
          Text(widget.manga.popularity.toString()),
          Row(
            children: List<Icon>.generate(widget.manga.popularity, (index) =>  Icon( Icons.star , color: Colors.yellow ))
                + List<Icon>.generate(5 - widget.manga.popularity, (index) =>  Icon(Icons.star)),
          ),

          Text(widget.manga.volume.toString()),
          FutureBuilder<String>(
              future:
              Scraper.getInstance().getNbVolume(widget.manga.name),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}'));
                } else {
                  String x = snapshot.data ?? "";
                  return Text(x);
                }
              }
          ),

          ElevatedButton(
            onPressed: () async {
              myData.deletManga(widget.manga);

              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>  HomePage()),
              );

            }, child: const Text('Delete'),
          )


        ],
      ),
    );
  }


}