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
const Color cardColor = Colors.white;
const Color primaryColor = Colors.orangeAccent;

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
  static const List<String> _statuses = [
    'PENDING',
    'PROCESSING',
    'SUCCESS',
    'FAIL'
  ];
  String _status = _statuses.first;

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     "Date > ${dateTime != null ? DateFormat('d/M/y').format(dateTime!) : 'NULL'}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldColor,
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(kHPadding),
                // padding: const EdgeInsets.all(kHPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHPadding,
                        vertical: kVPadding,
                      ),
                      decoration: const BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            primaryColor,
                            cardColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text("Task Bar"),
                    ),
                    TextButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (dialogContext) => TomorrowDatePicker(
                          startDateTime: dateTime,
                          onChanged: (dt) => setState(() => dateTime = dt),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
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
                        MaterialPageRoute(
                            builder: (context) => const SearchResult()),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        alignment: Alignment.center,
                        child: const Text("Ticket Result Screen"),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const TicketDashboard())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        alignment: Alignment.center,
                        child: const Text("Web Ticket Dashboard"),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                            padding: const EdgeInsets.only(
                                left: 1, top: 1, bottom: 1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kHPadding,
                              ),
                              decoration: BoxDecoration(
                                color: _status == 'PENDING'
                                    ? Colors.grey
                                    : _status == 'PROCESSING'
                                        ? Colors.yellow
                                        : _status == 'SUCCESS'
                                            ? Colors.green
                                            : _status == 'FAIL'
                                                ? Colors.red
                                                : scaffoldColor,
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(buttonCorner),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _status,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 1, right: 1, bottom: 1),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(buttonCorner + 1)),
                          ),
                          height: buttonHeight,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(buttonCorner)),
                            ),
                            child: PopupMenuButton<String>(
                              elevation: 0,
                              tooltip: 'Status',
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.circular(buttonCorner),
                              ),
                              splashRadius: 1,
                              initialValue: _status,
                              onSelected: (String? value) =>
                                  setState(() => _status = value!),
                              padding: EdgeInsets.zero,
                              // isExpanded: true,
                              icon: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                  size: 28,
                                ),
                              ),
                              color: Colors.transparent,
                              itemBuilder: (context) => _statuses
                                  .map<PopupMenuItem<String>>((String value) {
                                final Color color = value == 'PENDING'
                                    ? Colors.grey
                                    : value == 'PROCESSING'
                                        ? Colors.yellow
                                        : value == 'SUCCESS'
                                            ? Colors.green
                                            : value == 'FAIL'
                                                ? Colors.red
                                                : scaffoldColor;
                                return PopupMenuItem<String>(
                                  value: value,
                                  padding: EdgeInsets.zero,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: kHPadding,
                                    ),
                                    tileColor: color,
                                    title: Text(
                                      value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // CircularPercentIndicator(radius: 100),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: kHPadding,
                  right: kHPadding,
                  bottom: kHPadding,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHPadding,
                        vertical: kVPadding,
                      ),
                      decoration: const BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            primaryColor,
                            cardColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text("Task Bar"),
                    ),
                    const PieChartWidget()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
