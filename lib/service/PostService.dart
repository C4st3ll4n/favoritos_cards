import 'package:dio/dio.dart';
import 'package:favoritos_bloc/model/Post.dart';

class PostService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/posts";
  final Dio dio = Dio();

  Future<List<Post>> getPosts() async {
    try {
      Response response = await dio.get(baseUrl);

      List list = response.data as List;

      List<Post> postList =
          list.map<Post>((post) => Post.fromJson(post)).toList();

      return postList;
    } catch (e) {
      throw e;
    }
  }
}
