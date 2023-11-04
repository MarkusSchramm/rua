import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class RemoteUserState extends Equatable {
  final List<UserEntity>? generatedUsers;
  final DioException? error;

  const RemoteUserState({this.generatedUsers, this.error});

  @override
  List<Object> get props => [generatedUsers?? '', error?? ''];
}

class RemoteUserLoading extends RemoteUserState {
  const RemoteUserLoading();
}

class RemoteUserDone extends RemoteUserState {
  const RemoteUserDone({super.generatedUsers});
}

class RemoteUserError extends RemoteUserState {
  const RemoteUserError({super.error});
}