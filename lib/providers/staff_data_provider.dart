import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class StaffData {
  final int id;
  final String name;
  final String jobTitle;
  final String initials;
  final String levelCode;
  final String level;
  String statusCode;
  String status;

  StaffData({
    this.id,
    this.name,
    this.jobTitle,
    this.initials,
    this.levelCode,
    this.level,
    this.statusCode,
    this.status,
  });

  factory StaffData.fromJson(Map<String, dynamic> json) {
    return StaffData(
      id: json['id'],
      name: json['name'],
      jobTitle: json['job_title'],
      initials: json['initials'],
      levelCode: json['level'],
      level: json['level_description'],
      statusCode: json['status'],
      status: json['status_description'],
    );
  }
}

class StaffDataProvider with ChangeNotifier {
  ///properties
  List<StaffData> staffData;
  int _staffId;

  ///get staff data
  Future<List<StaffData>> getStaffData() async {
    http.Response response = await http.get('${kApiUrl}staff/get-staff-data');

    List jsonResponse = jsonDecode(response.body)['staff_data'];

    staffData = jsonResponse.map((i) => new StaffData.fromJson(i)).toList();

    return staffData;
  }

  ///set the staff id
  setStaffId(int id) {
    _staffId = id;
  }

  List<StaffData> get staff => staffData;

  int get staffId => _staffId;

  ///notify listeners that status has changed
  changeStatus(int id, int statusCode, String status) async {
    ///TODO: - update status code on server
    Map<String, String> body = {"staff_id": id.toString(), "status_code": statusCode.toString()};

    await http.post('${kApiUrl}status/update-status', headers: kPostHeaders, body: body);

    final staffItem = staffData.firstWhere((item) => item.id == id);

    staffItem.statusCode = statusCode.toString();
    staffItem.status = status;
    notifyListeners();
  }

  ///get updated staff data periodically
  getUpdatedStaffData() async {
    http.Response response = await http.get('${kApiUrl}staff/get-updated-staff-data');

    List jsonResponse = jsonDecode(response.body)['staff_data'];

    staffData = jsonResponse.map((i) => new StaffData.fromJson(i)).toList();

    notifyListeners();
  }
}
