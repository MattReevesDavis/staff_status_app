import 'dart:async';
import 'dart:core';

import 'package:acstaffstatus/providers/staff_data_provider.dart';
import 'package:acstaffstatus/widgets/app_drawer.dart';
import 'package:acstaffstatus/widgets/staff_sliver_list.dart';
import 'package:acstaffstatus/widgets/user_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Timer _timer;

  @override
  void initState() {
    ///call the get updated staff data method after a delay of 5 seconds
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      Provider.of<StaffDataProvider>(context, listen: false).getUpdatedStaffData();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          UserSliverAppBar(),
          StaffSliverList(),
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
