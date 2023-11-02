import 'package:rua/src/core/util/usecase.dart';

import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetSavedUsersUseCase implements UseCase<List<UserEntity>, void> {
  final UserRepository _userRepository;

  GetSavedUsersUseCase(this._userRepository);

  @override
  Future<List<UserEntity>> call({void params}) {
    return _userRepository.getSavedUsers();
  }
}