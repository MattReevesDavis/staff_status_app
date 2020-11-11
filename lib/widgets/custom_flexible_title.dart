import 'package:acstaffstatus/providers/status_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:acstaffstatus/providers/user_data_provider.dart';
import 'package:acstaffstatus/utils/constants.dart';

class CustomFlexibleTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserDataProvider>(context).user;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.075,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    user.name,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    user.jobTitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Status: ',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          user.status,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: kAppRedColour,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: kAppBlueColour,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Provider.of<StatusDataProvider>(context, listen: false).getStatusBottomSheet(context, 'user');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
