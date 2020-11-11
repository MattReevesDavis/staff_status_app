import 'dart:convert';

import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class VirusData {
  final String country;
  final int confirmed;
  final int deaths;
  final int recovered;
  final int active;
  final String date;

  VirusData({
    this.country,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.date,
  });

  factory VirusData.fromJson(Map<String, dynamic> json) {
    return VirusData(
      country: json['Country'],
      confirmed: json['Confirmed'],
      deaths: json['Deaths'],
      recovered: json['Recovered'],
      active: json['Active'],
      date: json['Date'],
    );
  }
}

class VirusDataGlobal {
  final int newConfirmed;
  final int totalConfirmed;
  final int newRecovered;
  final int totalRecovered;
  final int newDeaths;
  final int totalDeaths;
  final String date;

  VirusDataGlobal({
    this.newConfirmed,
    this.totalConfirmed,
    this.newRecovered,
    this.totalRecovered,
    this.newDeaths,
    this.totalDeaths,
    this.date,
  });
}

class VirusDataProvider with ChangeNotifier {
  List<VirusData> _southAfricanVirusData;
  VirusDataGlobal _globalVirusData;

  ///get covid details south africa
  Future<List<VirusData>> getVirusDataSouthAfrica() async {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dayBeforeYesterday = today.subtract(Duration(days: 2));
    DateFormat format = DateFormat('yyyy-MM-dd');

    String yesterdayFormatted = format.format(yesterday);
    String dayBeforeYesterdayFormatted = format.format(dayBeforeYesterday);

    http.Response response =
        await http.get(kVirusApiUrlSouthAfrica + '?from=' + dayBeforeYesterdayFormatted + 'T00:00:00Z&to=' + yesterdayFormatted + 'T00:00:00Z');

    List virusDataJson = jsonDecode(response.body);

    _southAfricanVirusData = virusDataJson.map((i) => new VirusData.fromJson(i)).toList();

    return _southAfricanVirusData;
  }

  ///get covid details global
  Future<VirusDataGlobal> getVirusDataGlobal() async {
    DateTime today = DateTime.now();
    DateFormat format = DateFormat('yyyy-MM-dd');
    String todayFormatted = format.format(today);

    http.Response response = await http.get(kVirusApiUrlGlobal);

    var virusDataJson = jsonDecode(response.body)['Global'];

    _globalVirusData = VirusDataGlobal(
      newConfirmed: virusDataJson['NewConfirmed'],
      totalConfirmed: virusDataJson['TotalConfirmed'],
      newRecovered: virusDataJson['NewRecovered'],
      totalRecovered: virusDataJson['TotalRecovered'],
      newDeaths: virusDataJson['NewDeaths'],
      totalDeaths: virusDataJson['TotalDeaths'],
      date: todayFormatted,
    );

    return _globalVirusData;
  }

  List<VirusData> get southAfricanVirusData => _southAfricanVirusData;

  VirusDataGlobal get globalVirusData => _globalVirusData;
}
