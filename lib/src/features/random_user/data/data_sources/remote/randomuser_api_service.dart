import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:rua/src/core/constants/constants.dart';

import '../../models/response_model.dart';

part 'randomuser_api_service.g.dart';

@RestApi(baseUrl: randomUserApiBaseUrl)
abstract class RandomUserApiService {
  factory RandomUserApiService(Dio dio) = _RandomUserApiService;

  @GET(randomUserApi)
  Future<HttpResponse<UserResponse>> getRandomUsers({
    @Query('results') String? results
  });
}