import 'package:acstaffstatus/providers/core_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:acstaffstatus/widgets/custom_flexible_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coreDataConnection = Provider.of<CoreDataProvider>(context);

    final size = MediaQuery.of(context).size;

    double _getIconSize() {
      double iconSize;

      if (size.width > 600) {
        //tablet
        iconSize = size.height * 0.03;
      } else if (size.width < 600 && size.width > 400) {
        //large phone
        iconSize = size.height * 0.025;
      } else {
        //small phone
        iconSize = size.height * 0.02;
      }

      return iconSize;
    }

    return SliverAppBar(
      pinned: true,
      title: Center(
        child: Container(
          height: size.height * 0.035,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'AgriChain',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          FontAwesomeIcons.bars,
          size: _getIconSize(),
          color: Colors.white,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(
              coreDataConnection.themeIndicator == 'L' ? FontAwesomeIcons.moon : FontAwesomeIcons.solidMoon,
              color: Colors.white,
              size: _getIconSize(),
            ),
            onPressed: () async {
              await coreDataConnection.updateTheme();
              await coreDataConnection.getCoreData();

              coreDataConnection.changeTheme();
            },
          ),
        ),
      ],
      expandedHeight: MediaQuery.of(context).size.height * 0.35,
      flexibleSpace: FlexibleSpaceBar(
        background: CustomFlexibleTitle(),
      ),
    );
  }
}
