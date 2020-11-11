import 'package:acstaffstatus/providers/virus_data_provider.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:acstaffstatus/widgets/responsive_safe_area.dart';
import 'package:acstaffstatus/widgets/south_african_pie_chart.dart';
import 'package:acstaffstatus/widgets/south_african_virus_stats_cards.dart';
import 'package:acstaffstatus/widgets/virus_info_banner.dart';
import 'package:acstaffstatus/widgets/virus_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_screen.dart';

class SouthAfricanVirusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final southAfricanVirusData = Provider.of<VirusDataProvider>(context, listen: false).southAfricanVirusData;
    final size = MediaQuery.of(context).size;

    double _returnPadding() {
      double paddingValue;

      if (size.width > 600) {
        //tablet
        paddingValue = size.width * 0.15;
      } else if (size.width < 600 && size.width > 400) {
        //large phone
        paddingValue = size.width * 0.05;
      } else {
        //small phone
        paddingValue = size.width * 0.025;
      }

      return paddingValue;
    }

    SliverChildListDelegate _getSliverList() {
      if (southAfricanVirusData.length < 2) {
        return SliverChildListDelegate(
          [
            Container(
              padding: EdgeInsets.only(top: size.height * 0.025, left: size.width * 0.05, right: size.width * 0.05),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Unable to retrieve virus data.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: kAppRedColour,
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return SliverChildListDelegate(
          [
            Container(
              padding: EdgeInsets.only(top: size.height * 0.025, left: size.width * 0.05, right: size.width * 0.05),
              child: VirusInfoBanner(notice: 'New SA stats available at midnight'),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.035, left: size.width * 0.05, right: size.width * 0.05),
              child: SouthAfricanVirusStatsCards(),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.035, horizontal: _returnPadding()),
              child: SouthAfricanPieChart(southAfricanVirusData: southAfricanVirusData),
            ),
          ],
        );
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          VirusSliverAppBar(
            title: 'SA COVID-19 Stats',
            image: Image.asset(
              'assets/images/sa_flag_xl.png',
              fit: BoxFit.cover,
              color: Color(0xFF000000).withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          SliverList(
            delegate: _getSliverList(),
          ),
        ],
      ),
    );
  }
}
