import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:get/get.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:video_player/video_player.dart';
// import 'package:better_player/better_player.dart';
import 'package:video_viewer/video_viewer.dart';

class WorkoutUI extends StatefulWidget {
  @override
  State<WorkoutUI> createState() => _WorkoutUIState();
}

class _WorkoutUIState extends State<WorkoutUI> {
  // late BetterPlayerController _betterPlayerController;

  // late VideoPlayerController _controller;

  //    @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.network(
  //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
  //       BetterPlayerDataSourceType.network,
  //       "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
  //   _betterPlayerController = BetterPlayerController(
  //       BetterPlayerConfiguration(),
  //       betterPlayerDataSource: betterPlayerDataSource);
  // }

  @override
  Widget build(BuildContext context) {
    final VideoViewerController controller = VideoViewerController();
    final AuthController authController = Get.put(AuthController());
    var userId = authController.firestoreUser.value!.uid;

    var data = Get.arguments;
    print("args data: ${data}");
    var workoutData = data[0];
    var routineType = data[1];
    var routine = data[2];
    var circuitIdx = data[3] - 1;

    // var routine= data[3];

    print(
      "circuit-Idx: $circuitIdx",
    );

    getCircuitPercentage(circuitWorkoutsLen, circuitDoneWorkouts) {
      var per = (circuitDoneWorkouts / circuitWorkoutsLen * 100);
      print("per: $per");
      return per;
    }

    getUserProgressArr() {
      var progressArr;
      return FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get()
          .then((snapshot) {
        final Map<String, dynamic>? doc = snapshot.data();
        // Map<String, dynamic> myMap = new Map<String, dynamic>.from(response['body']);

        print(
          "doc: ${doc}",
        );
        return doc!["progress"];
        // print("progressArr: ${progressArr} "),
        // format progressArr

        //  progressArr
      });
    }

    getProgressPercentage() {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get()
          .then((snapshot) {
        print("userDataPercentage: ${snapshot.data()}");

        var userData = snapshot.data();
        var routine = userData!["routine"];
        print("routine: ${routine}");

        for (var i = 0; i < routine.length; i++) {
          var circuit = routine[i];
          print("circuit ${i}: ${circuit} ");

          var circuitDoneWorkouts = 0;
          var circuitWorkoutsLen = circuit["workouts"].length;

          for (var j = 0; j < circuitWorkoutsLen; j++) {
            print("circuitWorkout: ${circuit["workouts"][j]}");
            var circuitWorkout = circuit["workouts"][j];

            if (circuitWorkout["done"] == true) {
              circuitDoneWorkouts++;
            }
          }
          print("circuit${i}-circuitDoneWorkouts: ${circuitDoneWorkouts} ");
          var resPercentage =
              getCircuitPercentage(circuitWorkoutsLen, circuitDoneWorkouts);

          print("resPercentage: $resPercentage");

          return resPercentage;

          // print("circuit: ${circuit["id"]}");
          // print("circuitWorkouts: ${circuit["workouts"]}");
          // if(circuit["id"] == circuitIdx.toString()) {
          //   print("match in: ${circuitIdx}");
          //   // print("workouts in: ${circuit["workouts"]}");
          //     for (var i = 0; i < circuit["workouts"].length; i++) {
          //         print("iteration");
          //     }
          //   // map the done workotus of this circuit to get the percentage

          // }
        }
      });
    }

    void updateUserProgress() async {
      List months = [
        '01',
        '02',
        'mar',
        'apr',
        'may',
        'jun',
        'jul',
        'aug',
        'sep',
        'oct',
        'nov',
        'dec'
      ];

      DateTime today = DateTime.now();
      var currentDate = today.day;
      var monthOfCurrentDate = months[today.month];
      var currentFormattedDate = "${currentDate}-${monthOfCurrentDate}-2022";

      // get progress
      var userProgressArr = await getUserProgressArr();
      print("progressArr: $userProgressArr");

      // match object
      print("progressDay: ${userProgressArr[0]["day"]}");
      print("currentFormattedDate: ${currentFormattedDate}");
      // var matchedProgressObj = userProgressArr?.firstWhere((progress) => progress["day"] == currentFormattedDate);
      var matchedProgressObj;
      for (var progressObj in userProgressArr) {
        if (progressObj["day"] == currentFormattedDate) {
          print("match");
          matchedProgressObj = progressObj;
        }
      }

      print("matchedProgressObj: $matchedProgressObj");

      // remove object from firestore

      // FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(userId)
      //     .update({
      //       "progress": FieldValue.arrayRemove([matchedProgressObj])
      //     })
      //     .then((value) => print("removed doc"))
      //     .catchError((e) => print("removing e: ${e}"));

      // get percentage
      var progressPercentage = await getProgressPercentage();
      print("progressPercentage: $progressPercentage");

      // mutate matchedObj

      // matchedProgressObj["progress"] = progressPercentage;

      // add object to firestore

      var ultiCircuit = circuitIdx + 1;
      print("ulti circuitIdx:${ultiCircuit}");

      // var targetObj = matchedProgressObj["circuit${ultiCircuit}percentage"];

      // print("targetObj: $targetObj");

      FirebaseFirestore.instance
          .collection("users_progress")
          .doc(currentFormattedDate)
          .collection("circuit-$ultiCircuit")
          .doc(userId)
          .set({
        // ...matchedProgressObj,
        "circuitIdx": ultiCircuit,
        // "userId": userId,
        "progressPercentage": progressPercentage
      }).then((value) => print("added progress"));

      // FirebaseFirestore.instance.collection("users").doc(userId).update({
      //   "progress": FieldValue.arrayUnion([
      //     {
      //       "day": currentFormattedDate,
      //     }
      //   ])
      // }).then((value) => print("mutated obj"));
    }

    void handleDoneWorkout(workoutId) {
      print("workoutId: ${workoutId}");

      // var actualCircuit = routine[circuitIdx]["workouts"];
      print("routinei: ${routine}");
      print("done circuitidx: ${circuitIdx}");
      var actualCircuit = routine[circuitIdx]["workouts"];

      print("actualCircuit: ${actualCircuit}");

      for (var i = 0; i < actualCircuit.length; i++) {
        print("workoutId: ${workoutId}-${actualCircuit[i]["id"]}");
        if (actualCircuit[i]["id"] == workoutId) {
          print("matched workout");
          final newWorkout = {...actualCircuit[i], "done": true};

          // routine[circuitIdx]["workouts"][workoutId - 1] = newWorkout;
          // var newId = actualCircuit[i]["id"] - 2;

          // print("newId: $newId");
          routine[circuitIdx]["workouts"][i] = newWorkout;

          print("newWorkout: ${newWorkout}");

          // remove this workout

          FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .update({"routine": routine}).then((value) {
            print("updated routine");
            updateUserProgress();
            //  Get.back();
          }).catchError((e) => print("e: ${e}"));
          //   }
        }
      }
      // for (var workout in actualCircuit) {
      //   print("workoutId: ${workoutId}-${workout["id"]}");
      //   if (workout["id"] == workoutId) {
      //     print("matched workout");
      //     final newWorkout = {...workout, "done": true};

      //     // routine[circuitIdx]["workouts"][workoutId - 1] = newWorkout;
      //     var newId = workout["id"] - 2;

      //     print("newId: $newId");
      //     // routine[circuitIdx]["workouts"][newId] = newWorkout;

      //     print("newWorkout: ${newWorkout}");

      //     // remove this workout

      //     FirebaseFirestore.instance
      //         .collection("users")
      //         .doc(userId)
      //         .update({"routine": routine}).then((value) {
      //       print("updated routine");
      //       updateUserProgress();
      //       //  Get.back();
      //     }).catchError((e) => print("e: ${e}"));
      //   }
      // }}

// remove it
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(routineType == "gym"
            ? workoutData["title"]
            : workoutData["houseTitle"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              child: Text("Descripción: "),
            ),
            Container(
              height: 100,
              alignment: Alignment.center,
              child: Text(routineType == "gym"
                  ? workoutData["description"]
                  : workoutData["houseDescription"]),
            ),

            Card(
              child: Container(
                height: 200,
                width: 400,
                child: VideoViewer(
                  controller: controller,
                  source: {
                    "SubRip Text": VideoSource(
                      video: VideoPlayerController.network(
                          "https://www.speechpad.com/proxy/get/marketing/samples/standard-captions-example.mp4"),
                      subtitle: {
                        "English": VideoViewerSubtitle.network(
                          "https://felipemurguia.com/assets/txt/WEBVTT_English.txt",
                          type: SubtitleType.webvtt,
                        ),
                      },
                    )
                  },
                ),
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text("Series"),
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                          child: Text(workoutData["series"].toString()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Repeticiones"),
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                          child: Text(workoutData["reps"].toString()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Peso"),
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                          child: Text(workoutData["peso"].toString()),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("Nota"),
                        Container(
                          height: 50,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                          child: Text(workoutData["note"] != null
                              ? workoutData["note"]
                              : ""),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Cronómetro"),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.orange, width: 1),
                              ),
                              child: Text(workoutData["tiempo"].toString()),
                            ),
                            Container(
                              color: Colors.orange,
                              height: 30,
                              width: 70,
                              alignment: Alignment.center,
                              child: Text(
                                "Start",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          child: Text("Finalizar ejercicio"),
                          onPressed: () => handleDoneWorkout(workoutData["id"]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

// Center(
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : Container(),
//         ),
            // ElevatedButton(
            //   onPressed: () {
            //     setState(() {
            //       _controller.value.isPlaying
            //           ? _controller.pause()
            //           : _controller.play();
            //     });
            //   },
            //   child: Icon(
            //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }
}
