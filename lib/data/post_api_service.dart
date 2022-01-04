import 'package:chopper/chopper.dart';
part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response> getPosts();

  @Get(path: '/{id}')
  Future<Response> getPostsById(@Path('id') int id);

  @Post()
  Future<Response> postPosts(@Body() Map<String, dynamic> body);

  static PostApiService create() {
    final client = ChopperClient(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        services: [_$PostApiService()],
        converter: const JsonConverter(),
        interceptors: [
          const HeadersInterceptor({'Cache-Control': 'no-cache'}),
          HttpLoggingInterceptor(),
        ]);
    return _$PostApiService(client);
  }
}
