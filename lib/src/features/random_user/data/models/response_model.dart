import 'user_model.dart';

class UserResponse {
  final List<UserModel> results;

  UserResponse(this.results);

  UserResponse.fromJson(Map<String, dynamic> json)
      : results =
  (json["results"] as List).map((i) => UserModel.fromJson(i)).toList();
}