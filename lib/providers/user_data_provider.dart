import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserData {
  final int id;
  final String name;
  final String email;
  final String jobTitle;
  final String initials;
  final String deviceNumber;
  final String theme;
  final String permissionCode;
  final String permission;
  String statusCode;
  String status;

  UserData({
    this.id,
    this.name,
    this.email,
    this.jobTitle,
    this.initials,
    this.deviceNumber,
    this.theme,
    this.permissionCode,
    this.permission,
    this.statusCode,
    this.status,
  });
}

class UserDataProvider with ChangeNotifier {
  UserData userData;
  String _userFirstName = '';
  String _userInitials = '';
  String _userStatus = '';

  ///Register user
  Future<String> registerUser(String email, String password, String deviceNumber) async {
    Map<String, String> body = {"email_address": email, "password": password, "device_imei": deviceNumber};

    http.Response response = await http.post('${kApiUrl}user/register-user', headers: kPostHeaders, body: body);

    var data = jsonDecode(response.body);

    return data;
  }

  ///user login
  Future<String> authenticateUser(String deviceNumber, String password) async {
    Map<String, String> body = {"device_imei": deviceNumber, "password": password};

    http.Response response = await http.post('${kApiUrl}user/authenticate-user', headers: kPostHeaders, body: body);

    var data = jsonDecode(response.body);

    return data;
  }

  ///Get user data
  Future<UserData> getUserData(String deviceNumber) async {
    Map<String, String> body = {"device_imei": deviceNumber};

    http.Response userDataResponse = await http.post('${kApiUrl}user/get-user-data', headers: kPostHeaders, body: body);

    var userDataJson = jsonDecode(userDataResponse.body)['user_data'];

    if (userDataJson == 'fail') {
      userData = UserData(
        id: 0,
        name: 'Name Not Found',
        email: 'null',
        jobTitle: 'null',
        initials: 'null',
        deviceNumber: 'null',
        theme: 'null',
        permissionCode: "0",
        permission: 'null',
        statusCode: "0",
        status: 'null',
      );
    } else {
      var split = userDataJson['name'].toString().split(' ');
      _userFirstName = split[0];
      _userInitials = userDataJson['initials'];
      _userStatus = userDataJson['status'];

      userData = UserData(
        id: userDataJson['id'],
        name: userDataJson['name'],
        email: userDataJson['email_address'],
        jobTitle: userDataJson['job_title'],
        initials: userDataJson['initials'],
        deviceNumber: userDataJson['device_imei'],
        theme: userDataJson['theme'],
        permissionCode: userDataJson['permission'],
        permission: userDataJson['permission_description'],
        statusCode: userDataJson['status'],
        status: userDataJson['status_description'],
      );
    }

    return userData;
  }

  String get userFirstName => _userFirstName;

  String get userInitials => _userInitials;

  UserData get user => userData;

  updateUserStatus(int statusCode, String status) {
    userData.statusCode = statusCode.toString();
    userData.status = status;
    notifyListeners();
  }
}
