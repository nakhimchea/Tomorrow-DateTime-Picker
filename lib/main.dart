import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'search_result.dart';
import 'tomorrow_date_picker.dart';

const Color scaffoldColor = Color(0xFFF6F8FA);

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
    debugPrint(
        "Date > ${dateTime != null ? DateFormat('d/M/y').format(dateTime!) : 'NULL'}");
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
          ],
        ),
      ),
    );
  }
}
