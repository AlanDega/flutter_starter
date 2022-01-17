import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/ui/workout/workout_ui.dart';
import 'package:get/get.dart';

class WorkoutComponent extends StatelessWidget {
  final  data;
  final String routineType;
  final routine;
  final circuitIdx;

  const WorkoutComponent({
    required this.data,
    required this.routineType,
    required this.routine,
    required this.circuitIdx
  });

  
  @override
  Widget build(BuildContext context) {
    print("data: ${this.data["title"]}");
    var data = this.data;
    var workoutId = this.data["id"];
    var workoutTitle = data["title"];
    var houseWorkoutTitle = data["houseTitle"];
    var workoutDoneState= data["done"];
    print("workoutDoneState: ${workoutDoneState}");

    return GestureDetector(
      onTap: () => Get.to(WorkoutUI(), arguments: [data,  routineType, routine, circuitIdx] ),
      child: Container(
        color: workoutDoneState == true ? Colors.greenAccent : Colors.blue[700],
        height: 40,
        width: 300,
        alignment: Alignment.center,
        child: Text(
          routineType != "gym" ? 
          houseWorkoutTitle :
          workoutTitle,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
