import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:acstaffstatus/widgets/registration_form.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double _returnPadding(width) {
      double paddingValue;

      if (width > 600) {
        //tablet
        paddingValue = width * 0.175;
      } else if (width < 600 && width > 400) {
        //large phone
        paddingValue = width * 0.075;
      } else {
        //small phone
        paddingValue = width * 0.025;
      }

      return paddingValue;
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: _returnPadding(size.width), right: _returnPadding(size.width)),
            child: RegistrationForm(),
          ),
        ),
      ),
    );
  }
}
