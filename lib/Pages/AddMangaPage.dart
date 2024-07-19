import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangatek/main.dart';

import '../Database/dataBase.dart';
import '../Model/Manga.dart';
import 'NavBar.dart';


final TextEditingController nameController = TextEditingController();
final TextEditingController volumeController = TextEditingController();
final TextEditingController popularityController = TextEditingController();

class AddMangaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(height: 10),
        TextField(
          controller: nameController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Manga Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 15),
        TextField(
          controller: volumeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Manga Volume Own',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 15),
        TextField(
          controller: popularityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Popularity 0 - 5',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            Manga manga = Manga(name: nameController.text, volume: int.parse(volumeController.text), popularity: int.parse(popularityController.text));
            myData.insertManga(manga);

            nameController.clear();
            volumeController.clear();
            popularityController.clear();

            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>  HomePage()),
            );

          }, child: const Text('Add'),
        )

      ],
  

    );
  }
  
}