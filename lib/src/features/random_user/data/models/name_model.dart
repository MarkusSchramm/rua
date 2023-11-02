class NameModel {
  final String title;
  final String first;
  final String last;

  NameModel(this.title, this.first, this.last);

  NameModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        first = json['first'],
        last = json['last'];
}