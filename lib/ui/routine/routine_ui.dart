import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/routine/circuit_component.dart';

import 'package:get/get.dart';

class RoutineUI extends StatelessWidget {
  const RoutineUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    var userId = authController.firestoreUser.value!.uid;

    final DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(userId);

    return StreamBuilder<DocumentSnapshot>(
      stream: userRef.snapshots(),
      builder: (context, snapshot) {
        
 if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

          var userData = snapshot.data?.data();

          print("routine: ${userData!["routine"]}");
          var routine = userData["routine"];

          var circuit1workouts = routine[0]["workouts"];
          print("workouts log1: ${routine[0]["workouts"]}");

          var circuit2workouts = routine[1]["workouts"];
          print("workouts log2: ${routine[1]["workouts"]}");

          var circuit3workouts = routine[2]["workouts"];
          print("workouts log3: ${routine[2]["workouts"]}");

          var circuit4workouts = routine[3]["workouts"];
          print("workouts log4: ${routine[3]["workouts"]}");

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircuitComponent(
                routine:routine,
                workouts: circuit1workouts,
                  idx:0,
                  type: "gym",
                  title: "Circuito 1",
                  url:
                      "https://www.snapfitness.com/assets/Archive-7/9/21/HeaderBackgroundImages/e7e7b89bab/Blog-BlogHeader_0116.jpg",
                  urlHouse:
                      "https://static.sportzbusiness.com/uploads/2020/10/exercise.jpg"),
              CircuitComponent(
                routine:routine,
                workouts: circuit2workouts,
                idx:1,
                  type: "gym",
                  title: "Circuito 2",
                  url:
                      "https://www.snapfitness.com/assets/Archive-7/9/21/HeaderBackgroundImages/e7e7b89bab/Blog-BlogHeader_0116.jpg",
                  urlHouse:
                      "https://static.sportzbusiness.com/uploads/2020/10/exercise.jpg"),
              CircuitComponent(
                routine:routine,
                workouts: circuit3workouts,
                idx:2,
                  type: "gym",
                  title: "Circuito 3",
                  url:
                      "https://www.snapfitness.com/assets/Archive-7/9/21/HeaderBackgroundImages/e7e7b89bab/Blog-BlogHeader_0116.jpg",
                  urlHouse:
                      "https://static.sportzbusiness.com/uploads/2020/10/exercise.jpg"),
              CircuitComponent(
                routine:routine,
                workouts: circuit4workouts,
                idx:3,
                  type: "gym",
                  title: "Circuito 4",
                  url:
                      "https://www.snapfitness.com/assets/Archive-7/9/21/HeaderBackgroundImages/e7e7b89bab/Blog-BlogHeader_0116.jpg",
                  urlHouse:
                      "https://static.sportzbusiness.com/uploads/2020/10/exercise.jpg"),
            ],
          ),
        );
      }
    );
  }
}
