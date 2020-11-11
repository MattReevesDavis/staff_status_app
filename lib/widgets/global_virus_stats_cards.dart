import 'package:acstaffstatus/providers/virus_data_provider.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';

class GlobalVirusStatsCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalVirusData = Provider.of<VirusDataProvider>(context, listen: false).globalVirusData;

    final size = MediaQuery.of(context).size;

    String formatNumber(number) {
      FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: number,
        settings: MoneyFormatterSettings(
          thousandSeparator: ' ',
        ),
      );

      return fmf.output.withoutFractionDigits.toString();
    }

    return Column(
      children: <Widget>[
        Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(12.0),
          shadowColor: Colors.black,
          child: Container(
            padding: EdgeInsets.all(size.height * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: size.height * 0.045,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      globalVirusData.date.substring(0, 10) + ' New' ?? 'Date',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                Row(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.035,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Confirmed: ',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: kAppGreenColour,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.035,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          formatNumber(globalVirusData.newConfirmed.toDouble()) ?? '0',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.035,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Recovered: ',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: kAppBlueColour,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.035,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          formatNumber(globalVirusData.newRecovered.toDouble()) ?? '0',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.035,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Deaths: ',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: kAppRedColour,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.035,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          formatNumber(globalVirusData.newDeaths.toDouble()) ?? '0',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(12.0),
            shadowColor: Colors.black,
            child: Container(
              padding: EdgeInsets.all(size.height * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: size.height * 0.045,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        globalVirusData.date.substring(0, 10) + ' Total' ?? 'Date',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Row(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.035,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Confirmed: ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: kAppGreenColour,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.035,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            formatNumber(globalVirusData.totalConfirmed.toDouble()) ?? '0',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.035,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Recovered: ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: kAppBlueColour,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.035,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            formatNumber(globalVirusData.totalRecovered.toDouble()) ?? '0',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.035,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Deaths: ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: kAppRedColour,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.035,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            formatNumber(globalVirusData.totalDeaths.toDouble()) ?? '0',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
