import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_bloc/model/Post.dart';
import 'package:rxdart/rxdart.dart';

class FavoritosCardBloc extends BlocBase {

  FavoritosCardBloc(Post post){
    isFavoriteListFlux
        .map((data)=> data.contains(post))
        .listen(isFavoriteEvent.add);
  }

  final _isFavoriteListController = BehaviorSubject<List<Post>>();
  Observable<List<Post>> get isFavoriteListFlux =>
      _isFavoriteListController.stream;
  Sink<List<Post>> get isFavoriteListEvent => _isFavoriteListController.sink;

  final _isFavoriteController = BehaviorSubject<bool>();
  Observable<bool> get isFavoriteFlux => _isFavoriteController.stream;
  Sink<bool> get isFavoriteEvent => _isFavoriteController.sink;

  @override
  void dispose() {
    _isFavoriteController.close();
    _isFavoriteListController.close();
  }
}
