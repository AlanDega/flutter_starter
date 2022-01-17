import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/ui/components/diet_component.dart';
import 'package:flutter_starter/ui/components/diet_time_component.dart';
import 'package:flutter_starter/ui/diet/diet_time_ui.dart';
import 'package:flutter_starter/controllers/controllers.dart';

import 'package:get/get.dart';

class DietUI extends StatefulWidget {
  const DietUI({Key? key}) : super(key: key);

  @override
  State<DietUI> createState() => _DietUIState();
}

class _DietUIState extends State<DietUI> {
  String selectedIdx = "D1";

  Widget getDayComponents(List<DayComponent> days) {
    return new Row(
        children: days
            .map((item) => DayComponent(
                  title: item.title,
                  selected: item.selected,
                  onSelectedDay: item.onSelectedDay,
                  selectedDay: selectedIdx,
                ))
            .toList());
  }

  onSelectedDay(idx) {
    setState(() {
      selectedIdx = idx;
    });
  }

  onSelectedTime(userId, timeTitle) {
    Get.to(DietTimeUI(), arguments: [userId, selectedIdx, timeTitle]);
  }

  @override
  Widget build(BuildContext context) {
    final days = [
      DayComponent(
        title: "D1",
        selected: true,
        onSelectedDay: onSelectedDay,
        selectedDay: selectedIdx,
      ),
      DayComponent(
        title: "D2",
        selected: false,
        onSelectedDay: onSelectedDay,
        selectedDay: selectedIdx,
      ),
      DayComponent(
        title: "D3",
        selected: false,
        onSelectedDay: onSelectedDay,
        selectedDay: selectedIdx,
      ),
      DayComponent(
        title: "D4",
        selected: false,
        onSelectedDay: onSelectedDay,
        selectedDay: selectedIdx,
      ),
      DayComponent(
        title: "D5",
        selected: false,
        onSelectedDay: onSelectedDay,
        selectedDay: selectedIdx,
      ),
    ];

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser.value!.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                    height: 100, child: Center(child: getDayComponents(days))),
                Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(controller.firestoreUser.value!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }

                        var userData = snapshot.data?.data();

                        var foodtimes = userData?["dietFoodTimes"];



                        return Container(
                            color: Colors.indigo[900],
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 36,
                                  width: 240,
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                  child: Center(
                                      child: Text(
                                    "Kcal. totales asignadas ${userData?["assignedDietKcals"]}",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                                DietTimeComponent(
                                    title: "Desayuno",
                                    onSelectedTime: onSelectedTime,
                                    kcal1: foodtimes[0]["kcals"],
                                    kcal2: 320,
                                    userId:
                                        controller.firestoreUser.value!.uid),
                                DietTimeComponent(
                                    title: "Colación",
                                    onSelectedTime: onSelectedTime,
                                    kcal1: foodtimes[1]["kcals"],
                                    kcal2: 320,
                                    userId:
                                        controller.firestoreUser.value!.uid),
                                DietTimeComponent(
                                    title: "Comida",
                                    onSelectedTime: onSelectedTime,
                                    kcal1: foodtimes[2]["kcals"],
                                    kcal2: 320,
                                    userId:
                                        controller.firestoreUser.value!.uid),
                                DietTimeComponent(
                                    title: "Colación",
                                    onSelectedTime: onSelectedTime,
                                    kcal1: foodtimes[3]["kcals"],
                                    kcal2: 320,
                                    userId:
                                        controller.firestoreUser.value!.uid),
                                DietTimeComponent(
                                    title: "Cena",
                                    onSelectedTime: onSelectedTime,
                                    kcal1: foodtimes[4]["kcals"],
                                    kcal2: 320,
                                    userId:
                                        controller.firestoreUser.value!.uid),
                              ],
                            ));
                      }),
                )
              ],
            ),
    );
  }
}
