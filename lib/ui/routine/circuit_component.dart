import 'package:flutter/material.dart';
import 'package:flutter_starter/ui/routine/circuit_ui.dart';
import 'package:get/get.dart';

class CircuitComponent extends StatelessWidget {
  final routine;
  final workouts;
  final int idx;
  final String title;
  final String url;
  final String urlHouse;
  final String type;
  const CircuitComponent(
      {
        required this.routine,
        required this.workouts,
      required this.idx,
      required this.title,
      required this.url,
      required this.urlHouse,
      required this.type});
  @override
  Widget build(BuildContext context) {
    // print("workouts : $workouts");

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () => Get.to(CircuitScreen(), arguments: [type, idx, workouts, routine]),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                type == "gym" ? url : urlHouse,
                height: 100,
                width: 180,
              ),
              Expanded(
                child: Center(child: Text(title)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
