import 'package:flutter/material.dart';

class DietTimeComponent extends StatelessWidget {
  final String title;
  final Function onSelectedTime;
  final int kcal1;
  final int kcal2;
  final String userId;

  const DietTimeComponent({
    required this.title,
    required this.onSelectedTime,
    required this.kcal1,
    required this.kcal2,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelectedTime(userId, title.toLowerCase()),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          color: Colors.white,
          height: 70,
          width: 200,
          child: Row(children: [
            Image.network(
              "https://media.istockphoto.com/photos/dinner-table-full-of-food-picture-id1136956875?k=20&m=1136956875&s=612x612&w=0&h=RxWNKQSgpOrgdw0DeR_sH6KyPrxp9znVdBYzLn1Y7Hc=",
              height: 80,
              width: 100,
            ),
            SizedBox(width: 20,),
            Text(title),
          ]),
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 40,
              width: 80,
              color: Colors.white,
              child: Center(child: Text(this.kcal1.toString())),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 40,
              width: 80,
              color: Colors.orange,
              child: Center(child: Text(this.kcal2.toString(), style: TextStyle(color: Colors.white),)),
            ),
          )
        ],),
      ]),
    );
  }
}
