import 'package:rua/src/core/util/usecase.dart';

import '../repositories/user_repository.dart';

class RemoveAllUsersUseCase implements UseCase<void, void> {
  final UserRepository _userRepository;

  RemoveAllUsersUseCase(this._userRepository);

  @override
  Future<void> call({void params}) {
    return _userRepository.removeAllUsers();
  }
}