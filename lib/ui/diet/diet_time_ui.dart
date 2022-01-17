import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/ui/components/diet_time_component.dart';
import 'package:flutter_starter/ui/diet/assigned_equiv_component.dart';
import 'package:get/get.dart';

class DietTimeUI extends StatelessWidget {
  const DietTimeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    print("diet ui args: $args");

    final DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(args[0]);

    return Scaffold(
      appBar: AppBar(
        title: Text("D1"),
        // actions: [
        //   // IconButton(onPressed: Get.back(), icon: Icon())
        // ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: userRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            var dayIdx;

            switch (args[1]) {
              case "D1":
              dayIdx = 0;
              break;
              case "D2":
              dayIdx = 1;
              break;
                
              default:
            }

            var snapshotData = snapshot.data;
            var diettimeData =
                snapshotData?.data()?["assignedDiet"][dayIdx][args[2]];
            print("diettimeData: ${diettimeData[0]["metadata"]}");
            print("diettimeLen: ${diettimeData.length}");

            var totalKcals = snapshotData?.data()?["assignedDietKcals"];

            print("args: ${args[0]}");
            return Column(
              children: [
                Container(
                  height: 36,
                  width: 240,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Center(
                      child: Text(
                    "Kcal. totales asignadas ${totalKcals}",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                Container(
                  height: 40,
                  width: 174,
                  color: Colors.white,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Alimentos Asignados"),
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 500.0,
                  child: ListView.builder(
                      itemCount: diettimeData?.length,
                      itemBuilder: (context, index) =>
                          AssignedEquivComponent(diettimeData)),
                ),
              ],
            );
          }),
    );
  }
}
