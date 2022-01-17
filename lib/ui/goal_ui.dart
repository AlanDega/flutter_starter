import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/ui/tabs_ui.dart';
import 'package:flutter_starter/ui/ui.dart';
import 'package:get/get.dart';


class GoalUI extends StatefulWidget {
  @override
  State<GoalUI> createState() => _GoalUIState();
}

class _GoalUIState extends State<GoalUI> {
  String goalValue = "";

  @override
  Widget build(BuildContext context) {
// final AuthController authController = Get.put(AuthController());
//     var userId = authController.firestoreUser.value!.uid;
           print("goalValue : ${goalValue}");

   handleProfileSaving(userId) {
           print("userId : ${userId}");
           print("goalValue : ${goalValue}");

      FirebaseFirestore.instance.collection("users").doc(userId).update({
        "goal":goalValue
      }).then((value) => Get.to(TabsUI()));
    }

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser.value!.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('home.title'.tr),
                actions: [
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Get.to(SettingsUI());
                      }),
                ],
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30),

                    // Avatar(controller.firestoreUser.value!),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text("¿Qué te gustaría lograr?"),
                        ),
                        Container(
                          // width: 230,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  onChanged: (txt) {
                                  setState(() {
                                    goalValue = txt;
                                  });
                                },
                                  // controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Escribe aquí...',
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                        vertical: 40.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed:() =>  handleProfileSaving(controller.firestoreUser.value!.uid),
                          child: Text("Guardar"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
