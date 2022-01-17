import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/ui/goal_ui.dart';
import 'package:flutter_starter/ui/ui.dart';
import 'package:get/get.dart';
import 'package:flutter_starter/controllers/controllers.dart';


class ProfileDetailsUI extends StatefulWidget {
  @override
  State<ProfileDetailsUI> createState() => _ProfileDetailsUIState();
}

class _ProfileDetailsUIState extends State<ProfileDetailsUI> {
  String bodytypeValue = "Delgada";
  String nameValue = "";
  String ageValue = "";
  String heightValue = "";
  String weightValue = "";
  String genderValue = "Masculino";

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    var userId = authController.firestoreUser.value!.uid;
      print("userId : ${userId}");


    handleProfileSaving() {
      FirebaseFirestore.instance.collection("users").doc(userId).update({
       "name":nameValue,
       "age":ageValue,
       "height":heightValue,
       "weight":weightValue,
       "bodytype":bodytypeValue,
       "gender":genderValue,
      }).then((value) => Get.to(GoalUI()));
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
                    SizedBox(height: 120),
                    // Avatar(controller.firestoreUser.value!),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          // width: 230,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextField(
                                onChanged: (txt) {
                                  setState(() {
                                    nameValue = txt;
                                  });
                                },
                                // controller: nameController,
                                decoration:
                                    const InputDecoration(labelText: 'Nombre'),

                              ),
                              const SizedBox(height: 8),
                              // TextField(
                              //   controller: lastNameController,
                              //   decoration: const InputDecoration(labelText: 'Last Name'),
                              // ),
                              TextField(
                                onChanged: (txt) {
                                  setState(() {
                                    weightValue = txt;
                                  });
                                },
                                // controller: weightController,
                                decoration:
                                    const InputDecoration(labelText: 'Peso'),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                // controller: heightController,
                                
                                decoration: const InputDecoration(
                                    labelText: 'Estatura'),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                onChanged: (txt) {
                                  setState(() {
                                    ageValue = txt;
                                  });
                                },
                                // controller: ageController,
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(labelText: 'Edad'),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text("Complexión"),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  DropdownButton<String>(
                                    value: bodytypeValue,
                                    hint: Text('Selecciona tu complexión'),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    onChanged: (newValue) {
                                      setState(() {
                                        bodytypeValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Delgada',
                                      'Robusta',
                                      'Obesa'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text("Sexo"),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  DropdownButton<String>(
                                    value: genderValue,
                                    hint: Text('Selecciona tu sexo'),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        genderValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Masculino',
                                      'Femenino',
                                      'Prefiero no decirlo'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                           // onPressed: () => Get.to(GoalUI()),
                           onPressed: handleProfileSaving,
                          child: Text("Guardar"),
                          // onPressed: () => Get.toNamed(Routes.profile),
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
