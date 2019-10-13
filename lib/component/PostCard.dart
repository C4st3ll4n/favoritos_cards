import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_bloc/bloc/FavoritosBloc.dart';
import 'package:favoritos_bloc/bloc/FavoritosCardBloc.dart';
import 'package:favoritos_bloc/model/Post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({Key key, this.post}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  FavoritosCardBloc _favoritosCardBloc;

  FavoritosBloc favoritosBloc; // = BlocProvider.getBloc();

  @override
  void initState() {
    super.initState();
    _favoritosCardBloc = FavoritosCardBloc(widget.post);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      favoritosBloc = BlocProvider.of(context);
      favoritosBloc.favoritosListFlux
          .listen(_favoritosCardBloc.isFavoriteListEvent.add);
    });
  }

  @override
  void dispose() {
   _favoritosCardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //FavoritosBloc favoritosBloc = BlocProvider.getBloc();

    return Card(
      color: Colors.lightBlue,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: <Widget>[
            Center(
                child: Text(widget.post.title,
                    style: TextStyle(color: Colors.white, fontSize: 14))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.post.body,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            StreamBuilder(
                stream: _favoritosCardBloc.isFavoriteFlux,
                initialData: false,
                builder: (BuildContext contexto, AsyncSnapshot<bool> snapshot) {
                  return snapshot.data
                      ? IconButton(
                          icon: Icon(Icons.favorite, color: Colors.redAccent),
                          onPressed: () {
                            favoritosBloc.favoritosRemoveEvent.add(widget.post);
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            favoritosBloc.favoritosAddEvent.add(widget.post);
                          });
                })
          ],
        ),
      ),
    );
  }
}
