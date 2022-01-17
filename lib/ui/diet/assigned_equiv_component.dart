import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignedEquivComponent extends StatelessWidget {
  final equiv;

  const AssignedEquivComponent(this.equiv);

  @override
  Widget build(BuildContext context) {
    print("equiv: ${this.equiv}");

    // var diettimeData =
    //             snapshotData?.data()?["assignedDiet"][0]["desayuno"];
    //         print("diettimeData: ${diettimeData[0]["metadata"]}");
    //         print("diettimeLen: ${diettimeData.length}");

    return Container(
      height: 34,
      width: 174,
      color: Colors.white,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(equiv[0]["title"]),
            Container(
                height: 34, color: Colors.blueAccent, child: Text("1 taza")),
          ],
        ),
      )),
    );
  }
}
