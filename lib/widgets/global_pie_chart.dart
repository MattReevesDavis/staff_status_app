import 'package:acstaffstatus/providers/virus_data_provider.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:acstaffstatus/widgets/pie_chart_legend.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GlobalPieChart extends StatefulWidget {
  final VirusDataGlobal globalVirusData;

  GlobalPieChart({this.globalVirusData});

  @override
  _GlobalPieChartState createState() => _GlobalPieChartState();
}

class _GlobalPieChartState extends State<GlobalPieChart> {
  List<PieChartSectionData> _sections = List<PieChartSectionData>();

  List<PieChartSectionData> _generatePieChartSectionData(size) {
    double activePercentage =
        ((widget.globalVirusData.totalConfirmed - widget.globalVirusData.totalRecovered) / widget.globalVirusData.totalConfirmed) * 100;
    double recoveredPercentage = (widget.globalVirusData.totalRecovered / widget.globalVirusData.totalConfirmed) * 100;
    double deathsPercentage = (widget.globalVirusData.totalDeaths / widget.globalVirusData.totalConfirmed) * 100;

    PieChartSectionData _item1 = PieChartSectionData(
      color: kAppGreenColour,
      value: activePercentage,
      title: activePercentage.round().toString() + '%',
      titleStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: size.height * 0.02,
      ),
    );

    PieChartSectionData _item2 = PieChartSectionData(
      color: kAppBlueColour,
      value: recoveredPercentage,
      title: recoveredPercentage.round().toString() + '%',
      titleStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: size.height * 0.02,
      ),
    );

    PieChartSectionData _item3 = PieChartSectionData(
      color: kAppRedColour,
      value: deathsPercentage,
      title: deathsPercentage.round().toString() + '%',
      titleStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: size.height * 0.02,
      ),
    );

    setState(() {
      _sections = [_item1, _item2, _item3];
    });

    return _sections;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.035,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Global COVID-19 Stats ' + widget.globalVirusData.date,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.025),
          PieChart(
            PieChartData(
              sections: _generatePieChartSectionData(size),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
            ),
          ),
          SizedBox(height: size.height * 0.025),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PieChartLegend(label: 'Active', color: kAppGreenColour),
              PieChartLegend(label: 'Recovered', color: kAppBlueColour),
              PieChartLegend(label: 'Deaths', color: kAppRedColour),
            ],
          ),
        ],
      ),
    );
  }
}
