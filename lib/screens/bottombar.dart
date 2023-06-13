import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:inote/screens/home.dart';

import 'createnote.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildPageContent(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 0, 23, 91),
        color: Colors.white,
        height: 50,
        items: <Widget>[
          Icon(Icons.note_alt_rounded,
              size: 30, color: Color.fromARGB(255, 0, 23, 91)),
          Icon(
            Icons.create,
            size: 30,
            color: Color.fromARGB(255, 0, 23, 91),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildPageContent() {
    if (_selectedIndex == 0) {
      return Center(
        child: Home(),
      );
    } else {
      return Center(
        child: CreateNote(),
      );
    }
  }
}
