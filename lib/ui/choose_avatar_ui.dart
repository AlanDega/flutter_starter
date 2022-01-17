import 'package:flutter/material.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/ui/profile_details_ui.dart';
import 'package:flutter_starter/ui/ui.dart';
import 'package:get/get.dart';

class ChooseAvatar extends StatelessWidget {
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
                    SizedBox(height: 120),
                    // Avatar(controller.firestoreUser.value!),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text("Elige tu foto de perfil"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          // onTap: () async {
                          //   final pickedImage =
                          //       await picker.pickImage(source: ImageSource.gallery);
                          //   if (pickedImage != null) {
                          //     Get.find<MyUserController>().setImage(File(pickedImage.path));
                          //   }
                          // },
                          child: Center(
                            child: ClipOval(
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/default.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Obx(() {
                        //   // final isSaving = userController.isSaving.value;
                        //   return Stack(
                        //     alignment: Alignment.center,
                        //     children: [
                        //       ElevatedButton(
                        //         child: const Text('Guardar'),
                        //         onPressed: isSaving ? null : handleUserSaving,
                        //       ),
                        //       if (isSaving) const CircularProgressIndicator(),
                        //     ],
                        //   );
                        // }),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          child: Text("Omitir"),
                          onPressed: () => Get.to(ProfileDetailsUI()),
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
