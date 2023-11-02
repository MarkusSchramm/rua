import 'package:rua/src/core/util/usecase.dart';

import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class SaveUserUseCase implements UseCase<void, UserEntity> {
  final UserRepository _userRepository;

  SaveUserUseCase(this._userRepository);

  @override
  Future<void> call({UserEntity? params}) {
    return _userRepository.saveUser(params!);
  }
}