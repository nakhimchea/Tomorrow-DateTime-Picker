import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'pie_chart_widget.dart';
import 'search_result.dart';
import 'ticket_dashboard.dart';
import 'tomorrow_date_picker.dart';

const Color scaffoldColor = Color(0xFFF6F8FA);
const double kHPadding = 16;
const double kVPadding = 10;
const double buttonCorner = 10;
const double buttonHeight = 45;

void main() {
  initializeDateFormatting('km');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     "Date > ${dateTime != null ? DateFormat('d/M/y').format(dateTime!) : 'NULL'}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (dialogContext) => TomorrowDatePicker(
                  startDateTime: dateTime,
                  onChanged: (dt) => setState(() => dateTime = dt),
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  dateTime == null
                      ? "Date Picker"
                      : DateFormat('d/M/y').format(dateTime!),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchResult()),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                alignment: Alignment.center,
                child: const Text("Ticket Result Screen"),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TicketDashboard())),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                alignment: Alignment.center,
                child: const Text("Web Ticket Dashboard"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: buttonHeight,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(buttonCorner + 1),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 1, top: 1, bottom: 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHPadding,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(buttonCorner),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "PROCESSING",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: buttonHeight,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(buttonCorner + 1),
                    ),
                  ),
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kVPadding / 2,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(buttonCorner),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            const PieChartWidget(),
            // CircularPercentIndicator(radius: 100),
          ],
        ),
      ),
    );
  }
}
