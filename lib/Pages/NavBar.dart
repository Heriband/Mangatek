

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangatek/Pages/Biblio.dart';

import 'AddMangaPage.dart';

List<String> labels = ["Biblio","Info"];

class NavBar extends StatefulWidget {

  @override
  State<NavBar> createState() => _NavBarState();

  NavBar updateIndex(int newIndex) {
    _NavBarState().updateIndex(newIndex);
    return this;
  }

}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void updateIndex(int newIndex){
    _selectedIndex = newIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = <Widget>[
       Biblio(),
      AddMangaPage(),
    ];

    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Biblio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Infos',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }

}