class DobModel {
  String? date;
  int? age;

  DobModel({this.date, this.age});

  DobModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    age = json['age'];
  }
}