import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_bloc/model/Favoritos.dart';
import 'package:favoritos_bloc/model/Post.dart';
import 'package:rxdart/rxdart.dart';

class FavoritosBloc extends BlocBase {

  final _favoritos = Favoritos();

  final _favoritosListControler = BehaviorSubject<List<Post>>();
  Observable<List<Post>> get favoritosListFlux =>
      _favoritosListControler.stream;
  Sink<List<Post>> get favoritosListEvent => _favoritosListControler.sink;

  final _favoritosListAddControler = BehaviorSubject<Post>();
  Observable<Post> get favoritosAddFlux => _favoritosListAddControler.stream;
  Sink<Post> get favoritosAddEvent => _favoritosListAddControler.sink;

  final _favoritosListRemoverControler = BehaviorSubject<Post>();
  Observable<Post> get favoritosRemoveFlux => _favoritosListRemoverControler.stream;
  Sink<Post> get favoritosRemoveEvent => _favoritosListRemoverControler.sink;

  FavoritosBloc(){
    favoritosAddFlux.listen(_tratarAdd);
    favoritosRemoveFlux.listen(_tratarRemove);
  }

  void _tratarAdd(Post p) {
    _favoritos.addPost(p);
    _updateList();
  }
    void _tratarRemove(Post p) {
      _favoritos.deletePost(p);
      _updateList();
    }

    void _updateList() => favoritosListEvent.add(_favoritos.posts.toList());

    @override
    void dispose() {
      _favoritosListControler.close();
      _favoritosListRemoverControler.close();
      _favoritosListAddControler.close();
    }

}