import 'package:flutter/material.dart';

class ProgressDayComponent extends StatelessWidget {
  final String date;
  final String percentage;
  final String circuitTitle;

  const ProgressDayComponent({required this.date, required this.percentage, required this.circuitTitle});
  // const ProgressDayComponent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(date, style: TextStyle(color: Colors.white),),
            ),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(circuitTitle , style: TextStyle(color: Colors.white),),
            ),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(percentage, style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
