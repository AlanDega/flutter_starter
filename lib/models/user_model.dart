//User Model
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  final String gender;
  final String bodytype;
  final String weight;
  final String height;
  final String goal;
  final String age;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.photoUrl,
            required this.gender,
            required this.bodytype,
            required this.weight,
            required this.height,
            required this.goal,
            required this.age,
});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      gender: data['gender'] ?? '',
      bodytype: data['bodytype'] ?? '',
      weight: data['weight'] ?? '',
      height: data['height'] ?? '',
      goal: data['goal'] ?? '',
      age: data['age'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "photoUrl": photoUrl,
        "gender": gender,
        "bodytype": bodytype,
        "weight": weight,
        "height": height,
        "goal": goal,
        "age": age,
      };
}
