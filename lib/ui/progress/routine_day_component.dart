import 'package:flutter/material.dart';
import 'package:flutter_starter/ui/progress/progress_day_component.dart';
import 'package:intl/intl.dart';

class RoutineDayComponent extends StatelessWidget {
  final dates;
  final int idx;
  final userData;

  const RoutineDayComponent({this.dates, required this.idx, this.userData});

  @override
  Widget build(BuildContext context) {
    List months = [
      '01',
      '02',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];

    DateTime today = DateTime.now();
    var currentDate = today.day;
    var monthOfCurrentDate = months[today.month];
    var circuitPercentages = [];
    var dates = [];

    // // get last 5 days
    for (var i = 5; i >= 0; i--) {
      // DateTime futureDate = DateTime.now().add(Duration(days: i));
      DateTime futureDate = DateTime.now().subtract(Duration(days: idx));

      var dayOfFutureDate = futureDate.day;
      var monthOfFutureDate = months[futureDate.month];
      var year = futureDate.year;

      var formattedDate = "${dayOfFutureDate}/${monthOfFutureDate}/${year}";
      print("formattedDate:${formattedDate} ");

      for (var i = 0; i < userData["progress"].length; i++) {
        print("progress: ${userData["progress"][i]}");
        print("progress-day: ${userData["progress"][i]["day"]}");

        var userProgressDay = userData["progress"][i]["day"];
        if (userProgressDay == formattedDate) {
          print("match");
          dates.add(userProgressDay);
          circuitPercentages.add(userData["progress"][i]["circuit1percentage"]);
          // circuitPercentages.add(userData["progress"][i]["circuit2percentage"]);
          // circuitPercentages.add(userData["progress"][i]["circuit3percentage"]);
          // circuitPercentages.add(userData["progress"][i]["circuit4percentage"]);
        }
      }
    }

    print("dates: ${dates}");
    print("circuitPercentages: ${circuitPercentages}");

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ProgressDayComponent(
          date: dates[idx],
          percentage: circuitPercentages[0],
          circuitTitle: "Circuito 1",
        ),
        // ProgressDayComponent(
        //   date: dates[idx],
        //   percentage: circuitPercentages[1],
        //   circuitTitle: "Circuito 2",
        // ),
        // ProgressDayComponent(
        //   date: dates[idx],
        //   percentage: circuitPercentages[2],
        //   circuitTitle: "Circuito 3",
        // ),
        // ProgressDayComponent(
        //   date: dates[idx],
        //   percentage: circuitPercentages[3],
        //   circuitTitle: "Circuito 4",
        // ),
      ],
    );
  }
}
