import 'package:flutter/material.dart';

class PieChartLegend extends StatelessWidget {
  final String label;
  final Color color;

  PieChartLegend({this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: <Widget>[
        Container(
          height: size.height * 0.05,
          width: size.width * 0.05,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.025),
        FittedBox(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.02,
            ),
          ),
        ),
      ],
    );
  }
}
