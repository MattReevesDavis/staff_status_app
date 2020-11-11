import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:acstaffstatus/screens/login_screen.dart';
import 'package:acstaffstatus/screens/register_screen.dart';
import 'package:acstaffstatus/screens/dashboard_screen.dart';
import 'package:acstaffstatus/screens/virus_screen.dart';
import 'package:acstaffstatus/screens/notices_screen.dart';

import 'package:acstaffstatus/providers/core_data_provider.dart';
import 'package:acstaffstatus/providers/user_data_provider.dart';
import 'package:acstaffstatus/providers/staff_data_provider.dart';
import 'package:acstaffstatus/providers/status_data_provider.dart';
import 'package:acstaffstatus/providers/virus_data_provider.dart';

import 'package:acstaffstatus/utils/constants.dart';

void main() => runApp(AgriChainStaffStatusApp());

class AgriChainStaffStatusApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CoreDataProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserDataProvider(),
        ),
        ChangeNotifierProvider.value(
          value: StaffDataProvider(),
        ),
        ChangeNotifierProvider.value(
          value: StatusDataProvider(),
        ),
        ChangeNotifierProvider.value(
          value: VirusDataProvider(),
        ),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatefulWidget {
  @override
  _MaterialAppWithThemeState createState() => _MaterialAppWithThemeState();
}

class _MaterialAppWithThemeState extends State<MaterialAppWithTheme> {
  Future<CoreData> coreData;

  @override
  void didChangeDependencies() {
    coreData = _getCoreData();

    super.didChangeDependencies();
  }

  Future<CoreData> _getCoreData() async {
    return await Provider.of<CoreDataProvider>(context).getCoreData();
  }

  @override
  Widget build(BuildContext context) {
    final coreDataConnection = Provider.of<CoreDataProvider>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder<CoreData>(
      future: coreData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: coreDataConnection.themeData,
            home: snapshot.data.firstLogin == 'Y' ? RegisterScreen() : LoginScreen(),
            routes: {
              LoginScreen.routeName: (context) => LoginScreen(),
              RegisterScreen.routeName: (context) => RegisterScreen(),
              DashboardScreen.routeName: (context) => DashboardScreen(),
              VirusScreen.routeName: (context) => VirusScreen(),
              NoticesScreen.routeName: (context) => NoticesScreen(),
            },
          );
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: kAppGreenColour,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        }
      },
    );
  }
}
