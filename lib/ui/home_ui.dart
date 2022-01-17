import 'package:flutter/material.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/ui/ui.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    Row(
                    
                  
                      children: [
                        Avatar(controller.firestoreUser.value!),
                        SizedBox(width: 30,),
                        Text(
                           
                                controller.firestoreUser.value!.name,
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       
                        FormVerticalSpace(),
                        FormVerticalSpace(),
                        Text(
                            'Edad' +
                                ': ' +
                                controller.firestoreUser.value!.age,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                           Text(
                            'Sexo' +
                                ': ' +
                                controller.firestoreUser.value!.gender,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                           Text(
                            'Peso' +
                                ': ' +
                                controller.firestoreUser.value!.weight + " kg",
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                           Text(
                            'Estatura' +
                                ': ' +
                                controller.firestoreUser.value!.height + " cm",
                            style: TextStyle(fontSize: 16)),
                       
                        FormVerticalSpace(),
                           Text(
                            'Complexión' +
                                ': ' +
                                controller.firestoreUser.value!.bodytype,
                            style: TextStyle(fontSize: 16)),
                       
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
