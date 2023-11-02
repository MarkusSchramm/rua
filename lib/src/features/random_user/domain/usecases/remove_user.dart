import 'package:rua/src/core/util/usecase.dart';

import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class RemoveUserUseCase implements UseCase<void, UserEntity> {
  final UserRepository _userRepository;

  RemoveUserUseCase(this._userRepository);

  @override
  Future<void> call({UserEntity? params}) {
    return _userRepository.removeUser(params!);
  }
}