import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const Color scaffoldColor = Color(0xFFF6F8FA);
const Color cardColor = Colors.white;
const Color primaryColor = Colors.orangeAccent;

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;
  int touched2Index = -1;

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 50.0 : 40.0;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.blue,
              value: 40,
              title: '40%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: Colors.red,
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          case 2:
            return PieChartSectionData(
              color: Colors.purple,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          case 3:
            return PieChartSectionData(
              color: Colors.green,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          default:
            throw Error();
        }
      },
    );
  }

  final data = [
    {
      "value": 80,
      "title": "40%",
    },
    {
      "value": 60,
      "title": "30%",
    },
    {
      "value": 30,
      "title": "15%",
    },
    {
      "value": 30,
      "title": "15%",
    },
  ];

  List<PieChartSectionData> showing2Sections() {
    return List.generate(
      data.length,
      (i) {
        final isTouched = i == touched2Index;
        final fontSize = isTouched ? 22.0 : 16.0;
        final radius = isTouched ? 50.0 : 40.0;

        return PieChartSectionData(
          color: i == 0
              ? Colors.blue
              : i == 1
                  ? Colors.red
                  : i == 2
                      ? Colors.purple
                      : Colors.green,
          value: data[i]["value"] as double,
          title: data[i]["title"] as String,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("$touchedIndex");
    return Container(
      height: 90 * 4,
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                sectionsSpace: 5,
                centerSpaceRadius: 90,
                sections: showingSections(),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touched2Index = -1;
                            return;
                          }
                          touched2Index = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sectionsSpace: 5,
                    centerSpaceRadius: 90,
                    sections: showing2Sections(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    touched2Index < 0
                        ? const SizedBox.shrink()
                        : Text(
                            '${data[touched2Index]["value"]} tickets (${data[touched2Index]["title"]})'),
                    const Text("Total 200 tickets"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
