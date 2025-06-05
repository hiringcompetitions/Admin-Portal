import 'package:flutter/material.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/pie_chart_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomPieChart extends StatefulWidget {
  final String oppId;
  const CustomPieChart({Key? key, required this.oppId}) : super(key: key);

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  late TooltipBehavior _tooltipBehavior;
  late SelectionBehavior _selectionBehavior;

  final List<Color> colorList = [
    Color(0xFF3366CC), // Blue
    Color(0xFFDC3912), // Red
    Color(0xFFFF9900), // Orange
    Color(0xFF109618), // Green
    Color(0xFF990099), // Purple
    Color(0xFF0099C6), // Cyan
    Color(0xFFDD4477), // Pink
    Color(0xFF66AA00), // Lime Green
  ];

  @override
  void initState() {
    super.initState();

    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y',
      canShowMarker: true,
      tooltipPosition: TooltipPosition.pointer,
    );

    _selectionBehavior = SelectionBehavior(
      enable: true,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PieChartProvider>(context, listen: false)
          .loadBranchCounts(widget.oppId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<PieChartProvider>(context);

    if (provider.isLoading) {   
      return Container(
          height: 500,
          width: size.width * 0.5,
          child: Center(child: CircularProgressIndicator()));
    }

    List<ChartData> chartData = [];
    provider.branchCounts.forEach((branch, count) {
      chartData.add(ChartData(branch, count.toDouble()));
    });
    if (chartData.isEmpty) {
      return Container(
        height: 500,
        width: size.width * 0.5,
        child: Center(
          child: Text(
            "No Applications Yet",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      );
    }

    return Container(
      height: 500,
      width: size.width * 0.5,
      child: Center(
        child: Container(
          height: 400,
          width: size.width * 0.3,
          child:SfCircularChart(
                  title: ChartTitle(text: 'Department-wise Student Count'),
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      position: LegendPosition.right,
                      textStyle: Theme.of(context).textTheme.headlineMedium),
                  tooltipBehavior: _tooltipBehavior,
                  series: <PieSeries<ChartData, String>>[
                    PieSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData d, _) => d.label,
                      yValueMapper: (ChartData d, _) => d.value,
                      pointColorMapper: (_, index) => colorList[index],
                      dataLabelSettings: DataLabelSettings(
                          showZeroValue: false,
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.inside,
                          textStyle: Theme.of(context).textTheme.titleSmall),
                      enableTooltip: true,
                      selectionBehavior: _selectionBehavior,
                      explode: true,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class ChartData {
  final String label;
  final double value;
  ChartData(this.label, this.value);
}
