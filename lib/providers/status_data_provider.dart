import 'dart:async';
import 'dart:convert';

import 'package:acstaffstatus/providers/core_data_provider.dart';
import 'package:acstaffstatus/providers/staff_data_provider.dart';
import 'package:acstaffstatus/providers/user_data_provider.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StatusData {
  final int id;
  final String description;

  StatusData({this.id, this.description});

  factory StatusData.fromJson(Map<String, dynamic> json) {
    return StatusData(
      id: json['id'],
      description: json['description'],
    );
  }
}

class StatusDataProvider with ChangeNotifier {
  ///properties
  List<StatusData> statusData;

  ///get staff data
  Future<List<StatusData>> getStatusData() async {
    http.Response response = await http.get('${kApiUrl}status/get-status-data');

    List jsonResponse = jsonDecode(response.body)['status_data'];

    statusData = jsonResponse.map((i) => new StatusData.fromJson(i)).toList();

    return statusData;
  }

  ///modal bottom sheet
  getStatusBottomSheet(BuildContext context, String indicator) {
    Future<List<StatusData>> future = getStatusData();
    final coreDataConnection = Provider.of<CoreDataProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return FutureBuilder<List<StatusData>>(
          future: future,
          builder: (buildContext, snapshot) {
            if (snapshot.hasData) {
              return Container(
//                height: MediaQuery.of(context).size.height * 0.4,
                color: Color(0xFF737373),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                  ),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (buildContext, index) {
                      return Container(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
                        child: GestureDetector(
                          child: Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(12.0),
                            shadowColor: Colors.black,
                            child: Container(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.03,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    snapshot.data[index].description,
                                    style: TextStyle(
                                      color: kAppRedColour,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            ///create connection to the staff data provider
                            final staffDataConnection = Provider.of<StaffDataProvider>(context, listen: false);

                            ///create connection to user data provider
                            final userDataConnection = Provider.of<UserDataProvider>(context, listen: false);

                            ///get user id
                            int staffId;

                            if (indicator == 'user') {
                              ///change the status of the user
                              userDataConnection.updateUserStatus(snapshot.data[index].id, snapshot.data[index].description);

                              ///set the staffId
                              staffId = userDataConnection.user.id;

                              ///change the status in the staff card
                              staffDataConnection.changeStatus(staffId, snapshot.data[index].id, snapshot.data[index].description);
                            } else {
                              ///this means the change is coming from a staff card
                              ///get staff id
                              staffId = staffDataConnection.staffId;

                              ///change the status in the staff card
                              staffDataConnection.changeStatus(staffId, snapshot.data[index].id, snapshot.data[index].description);
                            }

                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "${snapshot.error}",
                  textDirection: TextDirection.ltr,
                ),
              );
            }
            return Container(
              color: coreDataConnection.themeIndicator == 'L' ? Colors.white : kAppDarkColour,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: kAppGreenColour,
                  valueColor: coreDataConnection.themeIndicator == 'L'
                      ? AlwaysStoppedAnimation<Color>(Colors.white)
                      : AlwaysStoppedAnimation<Color>(kAppDarkColour),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
