class PictureModel {
  final String large;
  final String medium;
  final String thumbnail;

  PictureModel(this.large, this.medium, this.thumbnail);

  PictureModel.fromJson(Map<String, dynamic> json)
      : large = json['large'],
        medium = json['medium'],
        thumbnail = json['thumbnail'];
}