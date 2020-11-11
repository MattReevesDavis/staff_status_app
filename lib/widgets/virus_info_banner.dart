import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/material.dart';

class VirusInfoBanner extends StatelessWidget {
  final String notice;

  VirusInfoBanner({this.notice});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Colors.black,
//      color: kAppBlueColour,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(size.height * 0.025),
          height: size.height * 0.08,
          child: FittedBox(
            child: Text(
              notice,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
