import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Pages/NavBar.dart';
import 'Database/dataBase.dart';

final dataBase myData = dataBase();

void main() {
  runApp(
    MaterialApp(
        title: 'Mangatek',
        home: SafeArea(
          child: HomePage(),
        ),
        theme: ThemeData(
          primarySwatch: Colors.amber,
        )),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: myData.isDatabaseOpen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: Colors.amber,
              size: 200,
            ),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Settings"),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Deconnexion"),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      print("Settings menu is selected.");
                    } else if (value == 1) {
                      print("Log out");
                    }
                  },
                ),
              ],
              title: Text("MangaTek"),
            ),
            body: NavBar(), // Assurez-vous que NavBar() est défini ailleurs dans votre code
          );
        } else {
          return Center(
            child: Text("La base de données n'est pas ouverte."),
          );
        }
      },
    );
  }
}