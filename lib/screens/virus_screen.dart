import 'package:acstaffstatus/screens/dashboard_screen.dart';
import 'package:acstaffstatus/screens/south_african_virus_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'global_virus_screen.dart';

class VirusScreen extends StatefulWidget {
  static const routeName = '/virus';

  @override
  _VirusScreenState createState() => _VirusScreenState();
}

class _VirusScreenState extends State<VirusScreen> {
  int _index = 0;

  void _currentIndex(index) {
    setState(() {
      _index = index;
    });
  }

  final _screens = [
    SouthAfricanVirusScreen(),
    GlobalVirusScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double _getIconSize() {
      double iconSize;

      if (size.width > 600) {
        //tablet
        iconSize = size.height * 0.03;
      } else if (size.width < 600 && size.width > 400) {
        //large phone
        iconSize = size.height * 0.03;
      } else {
        //small phone
        iconSize = size.height * 0.02;
      }

      return iconSize;
    }

    double _getFontSize() {
      double fontSize;

      if (size.width > 600) {
        //tablet
        fontSize = size.height * 0.0175;
      } else if (size.width < 600 && size.width > 400) {
        //large phone
        fontSize = size.height * 0.015;
      } else {
        //small phone
        fontSize = size.height * 0.015;
      }

      return fontSize;
    }

    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
                size: _getIconSize(),
              ),
              title: Text(
                'South Africa',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: _getFontSize(),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.globeAfrica,
                size: _getIconSize(),
              ),
              title: Text(
                'Global',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: _getFontSize(),
                ),
              ),
            ),
          ],
          onTap: (index) {
            _currentIndex(index);
          }),
    );
  }
}
