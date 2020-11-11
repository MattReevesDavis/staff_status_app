import 'package:acstaffstatus/providers/core_data_provider.dart';
import 'package:acstaffstatus/providers/virus_data_provider.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';

class SouthAfricanVirusStatsCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coreDataConnection = Provider.of<CoreDataProvider>(context, listen: false);
    List<VirusData> southAfricanVirusData = Provider.of<VirusDataProvider>(context).southAfricanVirusData;

    final size = MediaQuery.of(context).size;
    final differenceConfirmed = southAfricanVirusData[1].confirmed - southAfricanVirusData[0].confirmed;
    final differenceRecovered = southAfricanVirusData[1].recovered - southAfricanVirusData[0].recovered;
    final differenceDeaths = southAfricanVirusData[1].deaths - southAfricanVirusData[0].deaths;

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
                      southAfricanVirusData[0].date.substring(0, 10) ?? 'Date',
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
                          formatNumber(southAfricanVirusData[0].confirmed.toDouble()) ?? '0',
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
                          formatNumber(southAfricanVirusData[0].recovered.toDouble()) ?? '0',
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
                          formatNumber(southAfricanVirusData[0].deaths.toDouble()) ?? '0',
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
                        southAfricanVirusData[1].date.substring(0, 10) ?? 'Date',
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
                          child: RichText(
                            text: TextSpan(
                              text: formatNumber(southAfricanVirusData[1].confirmed.toDouble()) ?? '0',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: coreDataConnection.themeIndicator == 'L' ? Colors.black : Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' (+$differenceConfirmed)',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: kAppGreenColour,
                                  ),
                                ),
                              ],
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
                          child: RichText(
                            text: TextSpan(
                              text: formatNumber(southAfricanVirusData[1].recovered.toDouble()) ?? '0',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: coreDataConnection.themeIndicator == 'L' ? Colors.black : Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' (+$differenceRecovered)',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: kAppBlueColour,
                                  ),
                                ),
                              ],
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
                          child: RichText(
                            text: TextSpan(
                              text: formatNumber(southAfricanVirusData[1].deaths.toDouble()) ?? '0',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: coreDataConnection.themeIndicator == 'L' ? Colors.black : Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' (+$differenceDeaths)',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: kAppRedColour,
                                  ),
                                ),
                              ],
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
