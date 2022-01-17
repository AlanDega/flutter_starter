import 'package:flutter/material.dart';

class DayComponent extends StatelessWidget {
  final String title;
  final bool selected;
  final Function onSelectedDay;
  final String selectedDay;

  const DayComponent(
      {required this.title,
      required this.selected,
      required this.onSelectedDay,
      required this.selectedDay
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onSelectedDay(title),
        child: Container(
          height: 50,
          width: 50,
          color: title == selectedDay ? Colors.blue : Colors.orange,
          child: Center(child: Text(title),),
        ),
      ),
    );
  }
}
