import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_saved_users.dart';
import '../../domain/usecases/remove_all_users.dart';
import '../../domain/usecases/remove_user.dart';
import '../../domain/usecases/save_user.dart';
import 'local_user_event.dart';
import 'local_user_state.dart';

class LocalUserBloc extends Bloc<LocalUserEvent, LocalUserState> {
  final GetSavedUsersUseCase _getSavedUsersUseCase;
  final SaveUserUseCase _saveUserUseCase;
  final RemoveUserUseCase _removeUserUseCase;
  final RemoveAllUsersUseCase _removeAllUsersUseCase;

  LocalUserBloc(
    this._getSavedUsersUseCase,
    this._saveUserUseCase,
    this._removeUserUseCase,
    this._removeAllUsersUseCase
  ) : super(const LocalUserLoading()) {
    on<GetSavedUsers> (onGetSavedUsers);
    on<SaveUser> (onSaveUser);
    on<RemoveUser> (onRemoveUser);
    on<RemoveAllUsers> (onRemoveAllUsers);
  }

  void onGetSavedUsers(GetSavedUsers event, Emitter<LocalUserState> emit) async {
    final users = await _getSavedUsersUseCase();
    emit(LocalUserDone(users: users));
  }

  void onSaveUser(SaveUser event, Emitter<LocalUserState> emit) async {
    await _saveUserUseCase(params: event.user);
    final users = await _getSavedUsersUseCase();
    emit(LocalUserDone(users: users));
  }

  void onRemoveUser(RemoveUser event, Emitter<LocalUserState> emit) async {
    await _removeUserUseCase(params: event.user);
    final users = await _getSavedUsersUseCase();
    emit(LocalUserDone(users: users));
  }

  void onRemoveAllUsers(RemoveAllUsers event, Emitter<LocalUserState> emit) async {
    await _removeAllUsersUseCase();
    final users = await _getSavedUsersUseCase();
    emit(LocalUserDone(users: users));
  }
}