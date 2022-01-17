import 'package:flutter/material.dart';
import 'package:flutter_starter/ui/routine/circuit_component.dart';
import 'package:get/get.dart';

class HouseRoutineUI extends StatelessWidget {
  const HouseRoutineUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircuitComponent(
            routine:[],
            workouts:"wdw",
            idx:0,
              type: "house",
              title: "Circuito 1",
              url:
                  "https://www.snapfitness.com/assets/Archive-7/9/21/HeaderBackgroundImages/e7e7b89bab/Blog-BlogHeader_0116.jpg",
              urlHouse:
                  "https://static.sportzbusiness.com/uploads/2020/10/exercise.jpg"),
          CircuitComponent(
            routine:[],
            workouts:"wdw",
            idx:1,
              type: "house",
              title: "Circuito 2",
              url:
                  "https://www.snapfitness.com/assets/Archive-7/9/21/HeaderBackgroundImages/e7e7b89bab/Blog-BlogHeader_0116.jpg",
              urlHouse:
                  "https://static.sportzbusiness.com/uploads/2020/10/exercise.jpg"),
          CircuitComponent(
            routine:[],
            workouts:"wdw",
            idx:2,
              type: "house",
              title: "Circuito 3",
              url:
                  "https://www.snapfitness.com/assets/Archive-7/9/21/HeaderBackgroundImages/e7e7b89bab/Blog-BlogHeader_0116.jpg",
              urlHouse:
                  "https://static.sportzbusiness.com/uploads/2020/10/exercise.jpg"),
          CircuitComponent(
            routine:[],
            workouts:"wdw",
            idx:3,
              type: "house",
              title: "Circuito 4",
              url:
                  "https://www.snapfitness.com/assets/Archive-7/9/21/HeaderBackgroundImages/e7e7b89bab/Blog-BlogHeader_0116.jpg",
              urlHouse:
                  "https://static.sportzbusiness.com/uploads/2020/10/exercise.jpg"),
        ],
      ),
    );
  }
}
