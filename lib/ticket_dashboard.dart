import 'package:flutter/material.dart';
import 'package:widgets/search_result.dart';

const Color scaffoldBackgroundColor = Colors.grey;
const Color cardColor = Colors.white;
const Color primaryColor = Colors.orangeAccent;

class TicketDashboard extends StatefulWidget {
  const TicketDashboard({Key? key}) : super(key: key);

  @override
  State<TicketDashboard> createState() => _TicketDashboardState();
}

class _TicketDashboardState extends State<TicketDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //MOCKUPS
  final List<Map<String, dynamic>> tickets = [
    {
      'userId': 'userId0',
      'type': 'report_issue',
      'status': 'PENDING',
      'data': {
        'name': 'Pu Ki',
        'receiver': 'Ban Du',
        'created_date': '1699253560008',
        'resolved_date': '',
        'amount': 15.25,
        'fee': 0,
      },
    },
    {
      'userId': 'userId1',
      'type': 'report_issue',
      'status': 'PENDING',
      'data': {
        'name': 'Ping Ping',
        'receiver': 'Du Du',
        'created_date': '1699253960008',
        'resolved_date': '',
        'amount': 0.25,
        'fee': 0.01,
      },
    },
    {
      'userId': 'userId2',
      'type': 'report_issue',
      'status': 'PENDING',
      'data': {
        'name': 'Jing Gu',
        'receiver': 'Bing Bu',
        'created_date': '1699254560008',
        'resolved_date': '',
        'amount': 158.25,
        'fee': 0.25,
      },
    },
    {
      'userId': 'userId4',
      'type': 'report_issue',
      'status': 'SUCCESS',
      'data': {
        'name': 'Pu Ki',
        'receiver': 'BangGu',
        'created_date': '1699263540008',
        'resolved_date': '1699363540008',
        'amount': 15.25,
        'fee': 0,
      },
    },
    {
      'userId': 'userId5',
      'type': 'report_issue',
      'status': 'FAIL',
      'data': {
        'name': 'Pin Du',
        'receiver': 'Bo Bo',
        'created_date': '1699353960008',
        'resolved_date': '1699373960008',
        'amount': 0.25,
        'fee': 0.01,
      },
    },
    {
      'userId': 'userId6',
      'type': 'report_issue',
      'status': 'PROCESSING',
      'data': {
        'name': 'Ting Gu',
        'receiver': 'Ringo',
        'created_date': '1699254560008',
        'resolved_date': '',
        'amount': 158.25,
        'fee': 0.25,
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const Chat(),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: ProcessingTickets(
                    processingMap: tickets
                        .where((element) =>
                            element['status'] != "SUCCESS" &&
                            element['status'] != "FAIL")
                        .toList(),
                  ),
                ),
                Expanded(
                  child: ProcessedTickets(
                    processedMap: tickets
                        .where((element) =>
                            element['status'] == "SUCCESS" ||
                            element['status'] == "FAIL")
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Reports(tickets: tickets),
                Container(
                  margin: const EdgeInsets.only(
                    left: kHPadding,
                    right: kHPadding,
                    bottom: kHPadding,
                  ),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kHPadding,
                      vertical: kVPadding,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Aa',
                        hintStyle: TextStyle(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProcessingTickets extends StatefulWidget {
  final List<Map<String, dynamic>> processingMap;
  const ProcessingTickets({Key? key, required this.processingMap})
      : super(key: key);

  @override
  State<ProcessingTickets> createState() => _ProcessingTicketsState();
}

class _ProcessingTicketsState extends State<ProcessingTickets> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Processing: ${widget.processingMap}');
    return ListView.builder(
      itemBuilder: (context, index) {
        final Map<String, dynamic> ticket =
            widget.processingMap.elementAt(index);
        final Map<String, dynamic> data = ticket['data'];
        return Row(
          children: [
            Expanded(
              child: Center(
                child: Text(ticket['userId']),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['name']),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['receiver']),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['amount'].toString()),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['fee'].toString()),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(DateTime.fromMillisecondsSinceEpoch(
                        int.parse(data['created_date']))
                    .toIso8601String()),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['resolved_date'].isNotEmpty
                    ? DateTime.fromMillisecondsSinceEpoch(
                            int.parse(data['resolved_date']))
                        .toIso8601String()
                    : ''),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: ticket['status'] == 'PENDING'
                    ? Colors.grey
                    : Colors.orangeAccent,
                child: Text(
                  ticket['status'],
                ),
              ),
            ),
          ],
        );
      },
      itemCount: widget.processingMap.length,
    );
  }
}

class ProcessedTickets extends StatefulWidget {
  final List<Map<String, dynamic>> processedMap;
  const ProcessedTickets({Key? key, required this.processedMap})
      : super(key: key);

  @override
  State<ProcessedTickets> createState() => _ProcessedTicketsState();
}

class _ProcessedTicketsState extends State<ProcessedTickets> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Processed: ${widget.processedMap}');
    return ListView.builder(
      itemBuilder: (context, index) {
        final Map<String, dynamic> ticket =
            widget.processedMap.elementAt(index);
        final Map<String, dynamic> data = ticket['data'];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(ticket['userId']),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['name']),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['receiver']),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['amount'].toString()),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['fee'].toString()),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(DateTime.fromMillisecondsSinceEpoch(
                        int.parse(data['created_date']))
                    .toIso8601String()),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(data['resolved_date'].isNotEmpty
                    ? DateTime.fromMillisecondsSinceEpoch(
                            int.parse(data['resolved_date']))
                        .toIso8601String()
                    : ''),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: ticket['status'] == 'SUCCESS'
                    ? Colors.lightGreenAccent
                    : Colors.redAccent,
                child: Text(
                  ticket['status'],
                ),
              ),
            ),
          ],
        );
      },
      itemCount: widget.processedMap.length,
    );
  }
}

class Reports extends StatefulWidget {
  final List<Map<String, dynamic>> tickets;
  const Reports({Key? key, required this.tickets}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: Text(
          'Pending: ${widget.tickets.where((element) => element['status'] == "PENDING").toList().length}\n'
          'Processing: ${widget.tickets.where((element) => element['status'] == "PROCESSING").toList().length}\n'
          'Success: ${widget.tickets.where((element) => element['status'] == "SUCCESS").toList().length}\n'
          'Fail: ${widget.tickets.where((element) => element['status'] == "FAIL").toList().length}'),
    );
  }
}

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: scaffoldBackgroundColor,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: kHPadding,
              right: kHPadding,
              bottom: kHPadding,
            ),
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kHPadding,
                vertical: kVPadding,
              ),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                autofocus: true,
                onChanged: (str) => setState(() => _message = str),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Aa',
                  suffixIcon: _message.trim().isNotEmpty
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.send,
                            color: primaryColor,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
