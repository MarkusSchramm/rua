import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? lastName;
  final String? firstName;
  final String? birthYear;
  final String? birthMonth;
  final String? birthDay;
  final int? age;
  final String? email;
  final String? phone;
  final String? urlToLargeImage;
  final String? urlToMediumImage;
  final String? urlToThumbnail;

  const UserEntity({
    this.id,
    this.lastName,
    this.firstName,
    this.birthYear,
    this.birthMonth,
    this.birthDay,
    this.age,
    this.email,
    this.phone,
    this.urlToLargeImage,
    this.urlToMediumImage,
    this.urlToThumbnail,
  });

  @override
  List<Object?> get props {
    return [
      lastName,
      firstName,
      birthYear,
      birthMonth,
      birthDay,
      age,
      email,
      phone,
      urlToLargeImage,
      urlToMediumImage,
      urlToThumbnail,
    ];
  }
}