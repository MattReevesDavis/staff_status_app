import 'package:acstaffstatus/providers/user_data_provider.dart';
import 'package:acstaffstatus/screens/login_screen.dart';
import 'package:acstaffstatus/screens/virus_screen.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataProvider>(context).userData;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Container(
              height: MediaQuery.of(context).size.height * 0.025,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  userData.name,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            accountEmail: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                userData.email,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    userData.initials,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: kAppGreenColour,
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.virus,
              size: 30.0,
              color: kAppGreenColour,
            ),
            title: Text(
              'COVID-19 Update',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, VirusScreen.routeName);
            },
          ),
//          ListTile(
//            leading: Icon(
//              FontAwesomeIcons.infoCircle,
//              size: 30.0,
//              color: kAppGreenColour,
//            ),
//            title: Text(
//              'Notices',
//              style: TextStyle(
//                fontFamily: 'Montserrat',
//                fontWeight: FontWeight.w500,
//                fontSize: MediaQuery.of(context).size.height * 0.02,
//              ),
//            ),
//            onTap: () {
//              Navigator.pop(context);
//              Navigator.pushReplacementNamed(context, VirusScreen.routeName);
//            },
//          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.signOutAlt,
              size: 30.0,
              color: kAppRedColour,
            ),
            title: Text(
              'Log Out',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
