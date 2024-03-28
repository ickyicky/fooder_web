import 'package:flutter/material.dart';


class FDateItemWidget extends StatelessWidget {
  final DateTime date;
  final bool picked;
  final Function(DateTime) onDatePicked;

  const FDateItemWidget({super.key, required this.date, required this.onDatePicked, this.picked = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var dayOfTheWeekMap = {
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
      7: 'Sun',
    };

    return GestureDetector(
      onTap: () {
        onDatePicked(date);
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: colorScheme.onPrimary,
            width: 2,
          ),
          color: picked ? colorScheme.onPrimary.withOpacity(0.25) : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              dayOfTheWeekMap[date.weekday]!,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${date.day}.${date.month}',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FDatePickerWidget extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDatePicked;

  const FDatePickerWidget({super.key, required this.date, required this.onDatePicked});

  @override
  State<FDatePickerWidget> createState() => _FDatePickerWidgetState();
}

class _FDatePickerWidgetState extends State<FDatePickerWidget> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      date = widget.date;
    });
  }

  Future<void> onDatePicked(DateTime date) async {
    setState(() {
      this.date = date;
    });

    await widget.onDatePicked(date);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return SizedBox(
      height: 100,
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(width: 25),
            FDateItemWidget(date: date.add(Duration(days: -2)), onDatePicked: onDatePicked),
            SizedBox(width: 25),
            FDateItemWidget(date: date.add(Duration(days: -1)), onDatePicked: onDatePicked),
            SizedBox(width: 25),
            FDateItemWidget(date: date, onDatePicked: onDatePicked, picked: true),
            SizedBox(width: 25),
            FDateItemWidget(date: date.add(Duration(days: 1)), onDatePicked: onDatePicked),
            SizedBox(width: 25),
            FDateItemWidget(date: date.add(Duration(days: 2)), onDatePicked: onDatePicked),
            Container(
              width: 100,
              child: IconButton(
                icon: Icon(
                  Icons.calendar_month,
                  color: colorScheme.onPrimary,
                  size: 40,
                ),
                onPressed: () {
                  onDatePicked(date.add(Duration(days: 1)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
