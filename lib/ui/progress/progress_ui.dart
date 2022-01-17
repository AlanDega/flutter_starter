import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/progress/progress_day_component.dart';
import 'package:flutter_starter/ui/progress/routine_day_component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProgressUI extends StatelessWidget {
  const ProgressUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    var userId = authController.firestoreUser.value!.uid;

    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    

    // var dates = [];
    // var circuitPercentages = [];

    return Container(
      child: StreamBuilder<DocumentSnapshot>(
          stream: userRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            var userData = snapshot.data?.data();

            print("userData: ${userData!}");

            // // get last 5 days
            // for (var i = 5; i >= 0; i--) {
            //   // DateTime futureDate = DateTime.now().add(Duration(days: i));
            //   DateTime futureDate = DateTime.now().subtract(Duration(days: i));

            //   var dayOfFutureDate = futureDate.day;
            //   var monthOfFutureDate = months[futureDate.month];
            //   var year = futureDate.year;

            //   var formattedDate =
            //       "${dayOfFutureDate}/${monthOfFutureDate}/${year}";
            //   print("formattedDate:${formattedDate} ");

            //   for (var i = 0; i < userData["progress"].length; i++) {
            //     print("progress: ${userData["progress"][i]}");
            //     print("progress-day: ${userData["progress"][i]["day"]}");

            //     var userProgressDay = userData["progress"][i]["day"];
            //     if (userProgressDay == formattedDate ) {
            //       print("match");
            //       dates.add(userProgressDay);
            //       circuitPercentages
            //           .add(userData["progress"][i]["circuit1percentage"]);
            //       circuitPercentages
            //           .add(userData["progress"][i]["circuit2percentage"]);
            //       circuitPercentages
            //           .add(userData["progress"][i]["circuit3percentage"]);
            //       circuitPercentages
            //           .add(userData["progress"][i]["circuit4percentage"]);
            //     }
            //   }
            // }

            // print("dates: ${dates}");
            // print("circuitPercentages: ${circuitPercentages}");

           
            return Column(children: [
              RoutineDayComponent(
                // dates: dates,
                // circuitPercentages: circuitPercentages,
                idx: 0,
                userData: userData
              ),
              SizedBox(height: 30,),
              // RoutineDayComponent(
              //   // dates: dates,
              //   // circuitPercentages: circuitPercentages,
              //   idx: 1,
              //   userData: userData
              // ),
            ]);
          }),
    );
  }
}
