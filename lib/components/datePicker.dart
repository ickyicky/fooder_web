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
        width: picked? 100: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            // color: picked ? colorScheme.onPrimary : Colors.transparent,
            color: Colors.transparent,
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
                fontSize: picked ? 24: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${date.day}.${date.month}',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: picked ? 24: 12,
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          children: <Widget>[
            FDateItemWidget(date: date.add(Duration(days: -3)), onDatePicked: onDatePicked),
            FDateItemWidget(date: date.add(Duration(days: -2)), onDatePicked: onDatePicked),
            FDateItemWidget(date: date.add(Duration(days: -1)), onDatePicked: onDatePicked),
            FDateItemWidget(date: date, onDatePicked: onDatePicked, picked: true),
            FDateItemWidget(date: date.add(Duration(days: 1)), onDatePicked: onDatePicked),
            FDateItemWidget(date: date.add(Duration(days: 2)), onDatePicked: onDatePicked),
            Container(
              width: 50,
              child: IconButton(
                icon: Icon(
                  Icons.calendar_month,
                  color: colorScheme.onPrimary,
                  size: 20,
                ),
                onPressed: () {
                  // open date picker
                  showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: date.add(Duration(days: -365)),
                    lastDate: date.add(Duration(days: 365)),
                  ).then((value) {
                    if (value != null) {
                      onDatePicked(value);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
