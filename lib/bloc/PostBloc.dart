import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_bloc/model/Post.dart';
import 'package:favoritos_bloc/service/PostService.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc extends BlocBase {

  final _postApi = PostService();

  PostBloc(){
    _postApi.getPosts().then(postsListEvent.add);
  }

  final _postsListControler = BehaviorSubject<List<Post>>();

  Observable<List<Post>> get postsListFlux => _postsListControler.stream;

  Sink<List<Post>> get postsListEvent => _postsListControler.sink;

  @override
  void dispose() {
    _postsListControler.close();
  }
}
