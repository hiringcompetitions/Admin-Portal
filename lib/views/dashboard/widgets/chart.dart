import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 6,
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: CustomColors().secondaryText));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const months = [
                  "Jan",
                  "Feb",
                  "March",
                  "Apr",
                  "May",
                  "Jun",
                  "Jul",
                  "Aug",
                  "Sep",
                  "Oct",
                  "Nov",
                  "Dec"
                ];

                return Text(months[value.toInt()],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: CustomColors().secondaryText));
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                Colors.white,
                CustomColors().primary,
                CustomColors().primary,
                CustomColors().primary,
                CustomColors().primary,
                CustomColors().primary,
                Colors.white,
              ]
            ),
            color: CustomColors().primary,
            barWidth: 2.5,
            dotData: FlDotData(
              show: false
            ),
            belowBarData: BarAreaData(
              show: false,
            ),
            spots: [
              FlSpot(0, 3),
              FlSpot(1, 1),
              FlSpot(2, 4),
              FlSpot(3, 2),
              FlSpot(4, 5),
              FlSpot(5, 1.5),
              FlSpot(6, 4),
            ],
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> indicators) {
            return indicators.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: CustomColors().primary,
                  strokeWidth: 2
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 5,
                      color: Colors.deepPurple,
                      strokeWidth: 4,
                      strokeColor: Colors.white,
                    );
                  },
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipColor: (LineBarSpot touchedSpot) => Colors.white,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                return LineTooltipItem(
                  '${touchedSpot.y}',
                  TextStyle(
                    color: CustomColors().primary, // Text color inside tooltip
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );;
  }
}