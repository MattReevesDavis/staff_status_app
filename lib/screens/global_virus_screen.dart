import 'package:acstaffstatus/providers/virus_data_provider.dart';
import 'package:acstaffstatus/widgets/global_pie_chart.dart';
import 'package:acstaffstatus/widgets/global_virus_stats_cards.dart';
import 'package:acstaffstatus/widgets/responsive_safe_area.dart';
import 'package:acstaffstatus/widgets/virus_info_banner.dart';
import 'package:acstaffstatus/widgets/virus_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalVirusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalVirusData = Provider.of<VirusDataProvider>(context).globalVirusData;
    final size = MediaQuery.of(context).size;

    double _returnPadding(width) {
      double paddingValue;

      if (width > 600) {
        //tablet
        paddingValue = width * 0.15;
      } else if (width < 600 && width > 400) {
        //large phone
        paddingValue = width * 0.05;
      } else {
        //small phone
        paddingValue = width * 0.025;
      }

      return paddingValue;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          VirusSliverAppBar(
            title: 'Global COVID-19 Stats',
            image: Image.asset(
              'assets/images/world_map_dark.png',
              fit: BoxFit.cover,
              color: Color(0xFF000000).withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.025, left: size.width * 0.05, right: size.width * 0.05),
                  child: VirusInfoBanner(notice: 'Global stats update every 30 minutes'),
                ),
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.035, left: size.width * 0.05, right: size.width * 0.05),
                  child: GlobalVirusStatsCards(),
                ),
                Container(
                  padding: EdgeInsets.all(_returnPadding(size.width)),
                  child: GlobalPieChart(globalVirusData: globalVirusData),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
