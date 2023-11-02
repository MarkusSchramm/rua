import 'package:floor/floor.dart';

import '../../domain/entities/user_entity.dart';
import 'dob_model.dart';
import 'name_model.dart';
import 'picture_model.dart';

@Entity(tableName: 'users', primaryKeys: ['id'])
class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.lastName,
    super.firstName,
    super.birthYear,
    super.birthMonth,
    super.birthDay,
    super.age,
    super.email,
    super.phone,
    super.urlToLargeImage,
    super.urlToMediumImage,
    super.urlToThumbnail
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      lastName: NameModel.fromJson(json['name']).last?? '',
      firstName: NameModel.fromJson(json['name']).first?? '',
      birthYear: DobModel.fromJson(json['dob']).date?.substring(0, 4)?? '',
      birthMonth: DobModel.fromJson(json['dob']).date?.substring(5, 7)?? '',
      birthDay: DobModel.fromJson(json['dob']).date?.substring(8, 10)?? '',
      age: DobModel.fromJson(json['dob']).age?? 0,
      email: json['email']?? '',
      phone: json['phone']?? '',
      urlToLargeImage: PictureModel.fromJson(json['picture']).large?? '',
      urlToMediumImage: PictureModel.fromJson(json['picture']).medium?? '',
      urlToThumbnail: PictureModel.fromJson(json['picture']).thumbnail?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
   return UserModel(
     id: entity.id,
     lastName: entity.lastName,
     firstName: entity.firstName,
     birthYear: entity.birthYear,
     birthMonth: entity.birthMonth,
     birthDay: entity.birthDay,
     age: entity.age,
     email: entity.email,
     phone: entity.phone,
     urlToLargeImage: entity.urlToLargeImage,
     urlToMediumImage: entity.urlToMediumImage,
     urlToThumbnail: entity.urlToThumbnail,
   );
  }
}

