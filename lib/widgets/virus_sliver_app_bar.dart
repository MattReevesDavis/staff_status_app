import 'package:acstaffstatus/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class VirusSliverAppBar extends StatelessWidget {
  final String title;
  final Image image;

  VirusSliverAppBar({
    @required this.title,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      pinned: true,
      expandedHeight: size.height * 0.35,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          height: size.height * 0.03,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        background: image,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 30.0,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
        },
      ),
    );
  }
}
