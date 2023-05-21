import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
// data
  Map<String, double> dawaDataMap = {
    "Pesticide": 160,
    "Insectside": 80,
    "Fertelizer": 22,
  };

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1.0),
      const Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  Map<String, double> plantsDataMap = {
    "Maize": 160,
    "Sorghum": 80,
    "Wheat": 50,
    "Potatoes": 22,
    "Tomatoes": 10,
    "Rice": 3,
    "Mangoes": 1
  };

  List<Color> plantsColorList = [
    const Color.fromARGB(255, 59, 33, 64),
    const Color.fromARGB(255, 11, 130, 75),
    const Color.fromARGB(255, 13, 118, 216),
    const Color.fromARGB(255, 209, 216, 13),
    const Color.fromARGB(255, 216, 13, 114),
    const Color.fromARGB(255, 216, 131, 13),
    const Color.fromARGB(255, 216, 13, 13),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organix Agrovet Data Analytics'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 26),
                const Text(
                  'MOST POPULAR MEDICINE TYPES PIE CHART',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 36),
                PieChart(
                  // Pass in the data for
                  // the pie chart
                  dataMap: dawaDataMap,
                  // Set the colors for the
                  // pie chart segments
                  colorList: colorList,
                  // Set the radius of the pie chart
                  chartRadius: MediaQuery.of(context).size.width / 2.5,
                  ringStrokeWidth: 24,
                  // Set the animation duration of the pie chart
                  animationDuration: const Duration(seconds: 3),
                  // Set the options for the chart values (e.g. show percentages, etc.)
                  chartValuesOptions: const ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesOutside: true,
                      showChartValuesInPercentage: true,
                      showChartValueBackground: false),
                  // Set the options for the legend of the pie chart
                  legendOptions: const LegendOptions(
                      showLegends: true,
                      legendShape: BoxShape.rectangle,
                      legendTextStyle: TextStyle(fontSize: 15),
                      legendPosition: LegendPosition.bottom,
                      showLegendsInRow: true),

                  gradientList: gradientList,
                ),
                const SizedBox(
                  height: 60,
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey[300],
                ),
                const SizedBox(
                  height: 35,
                ),
                const SizedBox(
                  height: 60,
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey[300],
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  'MOST POPULAR TREATED PLANTS PIE CHART ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 36),
                PieChart(
                  // Pass in the data for
                  // the pie chart
                  dataMap: plantsDataMap,
                  // Set the colors for the
                  // pie chart segments
                  colorList: plantsColorList,
                  // Set the radius of the pie chart
                  chartRadius: MediaQuery.of(context).size.width / 2.5,
                  ringStrokeWidth: 24,
                  // Set the animation duration of the pie chart
                  animationDuration: const Duration(seconds: 3),
                  // Set the options for the chart values (e.g. show percentages, etc.)
                  chartValuesOptions: const ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesOutside: true,
                      showChartValuesInPercentage: true,
                      showChartValueBackground: false),
                  // Set the options for the legend of the pie chart
                  legendOptions: const LegendOptions(
                      showLegends: true,
                      legendShape: BoxShape.rectangle,
                      legendTextStyle: TextStyle(fontSize: 15),
                      legendPosition: LegendPosition.bottom,
                      showLegendsInRow: true),

                  gradientList: gradientList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
