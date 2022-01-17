import 'package:flutter/material.dart';
import 'package:flutter_starter/ui/workout/workout_ui.dart';
import 'package:flutter_starter/ui/workout/workout_type_wrapper.dart';
import 'package:get/get.dart';

class CircuitScreen extends StatelessWidget {
  const CircuitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;

    print("circuit args: ${args[0]} ${args[1]} ${args[2] }");

    return Scaffold(
      appBar: AppBar(
        title: Text("Circuito ${args[1] + 1}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(alignment: Alignment.centerLeft, child: Text("Pecho")),
            Container(
              height: 200,
              child: WorkoutTypeWrapper(type: "back", routineType: args[0], circuitIdx: (args[1] + 1), workouts: args[2], routine: args[3]),
            ),

            SizedBox(
              height: 20,
            ),
            Container(alignment: Alignment.centerLeft, child: Text("Espalda")),

            SizedBox(
              height: 20,
            ),
            // ElevatedButton(child: Text("Finalizar circuito"), onPressed: () => Get.to(WorkoutUI()),)
          ],
        ),
      ),
    );
  }
}
