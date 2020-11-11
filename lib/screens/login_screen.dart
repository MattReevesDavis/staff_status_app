import 'package:acstaffstatus/providers/core_data_provider.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:acstaffstatus/widgets/login_form.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final coreDataConnection = Provider.of<CoreDataProvider>(context, listen: false);

    var size = MediaQuery.of(context).size;

    double _returnMargin(width) {
      double marginValue;

      if (width > 600) {
        //tablet
        marginValue = width * 0.175;
      } else if (width < 600 && width > 400) {
        //large phone
        marginValue = width * 0.075;
      } else {
        //small phone
        marginValue = width * 0.025;
      }

      return marginValue;
    }

    return Scaffold(
      backgroundColor: coreDataConnection.themeIndicator == 'L' ? Colors.white : kAppDarkColour,
      body: Container(
        margin: EdgeInsets.only(left: _returnMargin(size.width), right: _returnMargin(size.width)),
        child: Center(
          child: SingleChildScrollView(
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
