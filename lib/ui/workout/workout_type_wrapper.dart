import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/workout/workout_component.dart';
import 'package:flutter_starter/ui/workout/workout_ui.dart';
import 'package:get/get.dart';

class WorkoutTypeWrapper
 extends StatelessWidget {
   final String type;
   final String routineType;
   final int circuitIdx;
   final  workouts;
   final routine;

  const WorkoutTypeWrapper
  ({required this.type, required this.routineType, required this.circuitIdx, required this.workouts, required this.routine });

  @override
  Widget build(BuildContext context) {
    // get the workouts of this circuit and filter the one of the back
     final AuthController authController = Get.put(AuthController());
    var userId = authController.firestoreUser.value!.uid;

    // final Query workoutsRef = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(userId)
    //     .collection("ASSIGNED_ROUTINE")
    //     .doc(routineId)
    //     .collection("CIRCUITS")
    //     .doc("CIRCUIT-$circuitIdx")
    //     .collection("WORKOUTS")
    //     .where("type", isEqualTo: type);

    return 


             ListView.builder(
              itemCount: workouts?.length,
              itemBuilder: (context, index) => WorkoutComponent(data: workouts![index], routineType: routineType, routine: routine, circuitIdx: circuitIdx),
            );
          
        
        
  }
}
