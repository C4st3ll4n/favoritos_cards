import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_bloc/bloc/FavoritosBloc.dart';
import 'package:favoritos_bloc/component/PostCard.dart';
import 'package:favoritos_bloc/model/Post.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  void initState() {
    super.initState();
    //_favoritosBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FavoritosBloc _favoritosBloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Página de favoritos"),
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream: _favoritosBloc.favoritosListFlux,
            builder: (context, AsyncSnapshot<List<Post>> snapshot) {
              return snapshot.hasData && snapshot.data.isNotEmpty
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        Post _post = snapshot.data[index];
                        return Dismissible(
                          child: PostCard(
                            post: _post,
                          ), key: Key(_post.id.toString()),
                          onDismissed: (direction){
                            _favoritosBloc.favoritosRemoveEvent.add(_post);
                          },
                        );
                      })
                  : Center(
                      child: Text("Nenhum post favorito ainda"),
                    );
            },
          ),
        ),
      ),
    );
  }
}
