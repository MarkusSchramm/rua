import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rua/src/core/core.dart';

import '../../domain/usecases/get_random_users.dart';
import 'remote_user_event.dart';
import 'remote_user_state.dart';

class RemoteUserBloc extends Bloc<RemoteUserEvent, RemoteUserState> {
  final GetRandomUsersUseCase _getRandomUsersUseCase;

  RemoteUserBloc(this._getRandomUsersUseCase) : super(const RemoteUserLoading()) {
    on<GetRandomUsers> (onGetRandomUsers);
  }

  void onGetRandomUsers(GetRandomUsers event, Emitter<RemoteUserState> emit) async {
     final dataState = await _getRandomUsersUseCase(params: event.quantity);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteUserDone(generatedUsers: dataState.data!));
    }

    if (dataState is DataFail) {
      emit(RemoteUserError(error: dataState.error!));
    }

    if (dataState.data!.isEmpty) {
      emit(const RemoteUserLoading());
    }
  }
}