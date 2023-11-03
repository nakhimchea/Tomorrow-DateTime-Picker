import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color primaryColor = Color(0xFFFF9988);
const Color iconColor = Colors.grey;

const Color currentMonthColor = Colors.grey;

const double kHPadding = 16;
const double kVPadding = 10;
const String localeName = 'km';

class TomorrowDatePicker extends StatefulWidget {
  final DateTime? minimumDateTime;
  final DateTime? maximumDateTime;
  final DateTime? startDateTime;
  final Function(DateTime?) onChanged;
  const TomorrowDatePicker({
    Key? key,
    this.minimumDateTime,
    this.maximumDateTime,
    required this.startDateTime,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TomorrowDatePicker> createState() => _TomorrowDatePickerState();
}

class _TomorrowDatePickerState extends State<TomorrowDatePicker> {
  List<DateTime> dateList = [];
  DateTime? showDateTime;

  bool? isSwiped;
  void _changeSwiped(bool? status) => setState(() => isSwiped = status);

  void _createDateList() {
    dateList.clear();
    final DateTime newDate = DateTime((showDateTime ?? DateTime.now()).year,
        (showDateTime ?? DateTime.now()).month, 0);
    int previousMonthDay = 0;
    if (newDate.weekday < 7) {
      previousMonthDay = newDate.weekday;
      for (int i = 1; i <= previousMonthDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMonthDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMonthDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  List<Widget> get _dayLabels {
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat('EEE', localeName).format(dateList[i]),
              style: TextStyle(
                fontSize: 18,
                color: i < 5 ? iconColor : primaryColor,
              ),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  @override
  void initState() {
    super.initState();
    if (widget.startDateTime != null) showDateTime = widget.startDateTime;
    _createDateList();
  }

  @override
  Widget build(BuildContext context) {
    if (isSwiped != null) {
      showDateTime = isSwiped!
          ? (showDateTime ?? DateTime.now()).add(const Duration(days: 30))
          : (showDateTime ?? DateTime.now()).subtract(const Duration(days: 30));
      _createDateList();
      _changeSwiped(null);
    }
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(kHPadding),
      insetAnimationDuration: const Duration(milliseconds: 50),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDateTime = (showDateTime ?? DateTime.now())
                                .subtract(const Duration(days: 30));
                            _createDateList();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: iconColor,
                            size: 16,
                          ),
                        ),
                        Text(
                          DateFormat('yMMMM', localeName)
                              .format(dateList.elementAt(dateList.length ~/ 2)),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDateTime = (showDateTime ?? DateTime.now())
                                .add(const Duration(days: 30));
                            _createDateList();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: iconColor,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(children: _dayLabels),
                      const SizedBox(height: 10),
                      _CalendarMonth(
                        onSelected: showDateTime,
                        dateList: dateList,
                        onChanged: widget.onChanged,
                        onSwiped: _changeSwiped,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarMonth extends StatefulWidget {
  final DateTime? onSelected;
  final List<DateTime> dateList;
  final Function(DateTime?) onChanged;
  final Function(bool?) onSwiped;
  const _CalendarMonth({
    Key? key,
    this.onSelected,
    required this.dateList,
    required this.onChanged,
    required this.onSwiped,
  }) : super(key: key);

  @override
  State<_CalendarMonth> createState() => _CalendarMonthState();
}

class _CalendarMonthState extends State<_CalendarMonth> {
  DateTime? _onClickedDateTime;
  DateTime? startTime;
  bool? onSwiped; // false: swipe left, true: swipe right

  @override
  void initState() {
    super.initState();
    if (widget.onSelected != null) _onClickedDateTime = widget.onSelected;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 350)),
      builder: (streamContext, snapshot) {
        if (startTime != null &&
            DateTime.now().difference(startTime!).inMilliseconds > 800) {
          Navigator.maybePop(context);
        }
        return ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15)),
          child: GestureDetector(
            onPanUpdate: (details) =>
                setState(() => onSwiped = details.delta.dx < 0),
            onPanEnd: (details) => widget
                .onSwiped(details.primaryVelocity == null ? onSwiped : null),
            child: Column(
              children: List.generate(widget.dateList.length ~/ 7, (week) {
                bool isEnded = true;
                return Row(
                  children: List.generate(
                    widget.dateList.length ~/ 6,
                    (day) {
                      final int showMonth = widget.dateList
                          .elementAt(widget.dateList.length ~/ 2)
                          .month;
                      final int currentIndex =
                          week * widget.dateList.length ~/ 6 + day;
                      final current = widget.dateList.elementAt(currentIndex);
                      final DateTime now = DateTime.now();
                      if (currentIndex == 35 &&
                          current.month > showMonth % 12) {
                        isEnded = false;
                      }

                      return isEnded
                          ? Expanded(
                              child: Material(
                                color: _onClickedDateTime == current
                                    ? primaryColor
                                    : current.year == now.year &&
                                            current.month == now.month &&
                                            current.month == showMonth &&
                                            current.day == now.day
                                        ? currentMonthColor.withOpacity(0.1)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                                clipBehavior: Clip.antiAlias,
                                child: MaterialButton(
                                  onPressed: current.month == showMonth
                                      ? () {
                                          setState(() => _onClickedDateTime =
                                              _onClickedDateTime != current
                                                  ? current
                                                  : null);
                                          startTime = _onClickedDateTime != null
                                              ? startTime = DateTime.now()
                                              : null;
                                          widget.onChanged(_onClickedDateTime);
                                        }
                                      : null,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  highlightColor: primaryColor.withOpacity(0.4),
                                  splashColor: primaryColor.withOpacity(0.2),
                                  child: Text(
                                    current.month == showMonth
                                        ? current.day.toString()
                                        : '',
                                    style: TextStyle(
                                      color: _onClickedDateTime == current
                                          ? Colors.white
                                          : currentIndex % 7 < 5
                                              ? iconColor
                                              : primaryColor,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
