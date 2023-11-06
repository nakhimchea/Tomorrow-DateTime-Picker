import 'package:flutter/material.dart';

const String localeName = 'km';
const double kHPadding = 16;
const double kVPadding = 10;

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  //MOCKUPS
  final List<Map<String, dynamic>> data = [
    {
      'userId': 'userId0|អតិថិជនទី០',
      'type': 'report_issue|រាយការណ៍បញ្ហា',
      'ticketNumber': [
        'TK0|x00001|លេខ០០០០១',
        'TK1|x00002|លេខ០០០០២',
        'TK2|x00003|លេខ០០០០៣',
      ],
    },
    {
      'userId': 'userId1|អតិថិជនទី1',
      'type': 'report_issue|រាយការណ៍បញ្ហា',
      'ticketNumber': [
        'TK0|x00001|លេខ០០០០១',
      ],
    },
    {
      'userId': 'userId2|អតិថិជនទី2',
      'type': 'report_issue|រាយការណ៍បញ្ហា',
      'ticketNumber': [
        'TK0|x00001|លេខ០០០០១',
        'TK1|x00002|លេខ០០០០២',
      ],
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Map<String, dynamic> ticket = data.elementAt(index);
          final String userId = ticket['userId'];
          final String type = ticket['type'];
          final List<String> ticketNumber = ticket['ticketNumber'];

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHPadding,
                  vertical: kVPadding,
                ),
                color: Colors.lightGreenAccent,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      localeName == 'km'
                          ? userId.split('|').last
                          : userId.split('|').first,
                    ),
                    Text(
                      localeName == 'km'
                          ? type.split('|').last
                          : type.split('|').last,
                    ),
                  ],
                ),
              ),
              ...List.generate(
                ticketNumber.length,
                (number) => Container(
                  margin: const EdgeInsets.only(left: kHPadding),
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHPadding,
                    vertical: kVPadding,
                  ),
                  color: Colors.lightGreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ticketNumber.elementAt(number).split('|').first,
                          ),
                          Text(
                            localeName == 'km'
                                ? ticketNumber.elementAt(number).split('|').last
                                : ticketNumber
                                    .elementAt(number)
                                    .split('|')
                                    .elementAt(1),
                          ),
                        ],
                      ),
                      localeName == 'km'
                          ? Text(
                              ticketNumber
                                  .elementAt(number)
                                  .split('|')
                                  .elementAt(1),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
