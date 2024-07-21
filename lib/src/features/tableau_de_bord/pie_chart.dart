import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
class PieChartPage extends StatelessWidget {
const PieChartPage( {super.key});
  @override
  Widget build(BuildContext context) {
   return
       PieChart(
           swapAnimationDuration : const Duration (milliseconds: 750),
           swapAnimationCurve:  Curves.easeInOutQuint,
           PieChartData( sections: [
            PieChartSectionData(
              value: 20,
                  color:Colors.blue
            ),
             PieChartSectionData(
                 value: 200,
                 color:Colors.red
             ),
             PieChartSectionData(
                 value: 20,
                 color:Colors.green
             ),
           ])

       );

  }
}

