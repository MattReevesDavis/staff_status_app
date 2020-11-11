import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:acstaffstatus/utils/constants.dart';

class CoreData {
  final int id;
  final String deviceNumber;
  final String firstLogin;
  String theme;

  CoreData({
    this.id,
    this.deviceNumber,
    this.firstLogin,
    this.theme,
  });
}

class CoreDataProvider with ChangeNotifier {
  String _deviceNumber;
  CoreData coreData;
  ThemeData _themeData;
  String _themeIndicator;

  ///Get device number
  Future<CoreData> getCoreData() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      _deviceNumber = iosDeviceInfo.identifierForVendor;
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      _deviceNumber = androidDeviceInfo.androidId;
    }

    Map<String, String> body = {'device_imei': _deviceNumber};

    http.Response coreDataResponse = await http.post('${kApiUrl}core/get-core-data', headers: kPostHeaders, body: body);

    var coreDataJson = jsonDecode(coreDataResponse.body)['core_data'];

    if (coreDataJson == 'fail') {
      ///this will return the very first time the user runs the application
      ///once the user has registered their device number, email address and password, they will actually HAVE core data
      ///at this point in the application, they don't have any identifiable core data
      coreData = CoreData(
        id: 0,
        deviceNumber: 'null',
        firstLogin: 'Y',
        theme: 'L',
      );
    } else {
      coreData = CoreData(
        id: coreDataJson['id'],
        deviceNumber: coreDataJson['device_imei'],
        firstLogin: coreDataJson['firstLogin'],
        theme: coreDataJson['theme'],
      );
    }

    setTheme(coreData.theme);

    return coreData;
  }

  String get deviceNumber => _deviceNumber;

  CoreData get core => coreData;

  ///Let's start by creating a custom colour generator so we can use any hex code colour with our themes
  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) {
    return max(0, min((value + ((255 - value) * factor)).round(), 255));
  }

  Color tintColor(Color color, double factor) {
    return Color.fromRGBO(tintValue(color.red, factor), tintValue(color.green, factor), tintValue(color.blue, factor), 1);
  }

  int shadeValue(int value, double factor) {
    return max(0, min(value - (value * factor).round(), 255));
  }

  Color shadeColor(Color color, double factor) {
    return Color.fromRGBO(shadeValue(color.red, factor), shadeValue(color.green, factor), shadeValue(color.blue, factor), 1);
  }

  ///Theme objects
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0xFF8dc64b),
    accentColor: Color(0xFF444546),
    primaryIconTheme: IconThemeData(color: Color(0xFF444546)),
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xFF8dc64b),
    accentColor: Color(0xFF8dc64b),
    primaryIconTheme: IconThemeData(color: Color(0xFF444546)),
  );

  void setTheme(String theme) {
    if (theme == 'L') {
      _themeData = lightTheme;
      _themeIndicator = 'L';
    } else {
      _themeData = darkTheme;
      _themeIndicator = 'D';
    }
  }

  ThemeData get themeData => _themeData;

  String get themeIndicator => _themeIndicator;

  ///TODO: - implement theme changer
  void changeTheme() async {
    String theme;

    if (_themeData == lightTheme) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }

    notifyListeners();
  }

  Future<void> updateTheme() async {
    Map<String, String> body = {"device_imei": _deviceNumber};

    await http.post('${kApiUrl}core/update-theme', headers: kPostHeaders, body: body);
  }
}
