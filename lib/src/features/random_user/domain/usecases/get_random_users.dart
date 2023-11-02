import 'package:rua/src/core/core.dart';

import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetRandomUsersUseCase implements UseCase<DataState<List<UserEntity>>, int> {
  final UserRepository _userRepository;

  GetRandomUsersUseCase(this._userRepository);

  @override
  Future<DataState<List<UserEntity>>> call({int? params}) {
    return _userRepository.getRandomUsers(params!);
  }
}