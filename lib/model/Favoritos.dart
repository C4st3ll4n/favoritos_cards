import 'package:favoritos_bloc/model/Post.dart';

class Favoritos{
  final _postList = <Post>{};

  Set<Post> get posts => _postList;

  void addPost(Post post) => _postList.add(post);


  void deletePost(Post post) => _postList.remove(post);
}