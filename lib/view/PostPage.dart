import 'package:favoritos_bloc/bloc/PostBloc.dart';
import 'package:favoritos_bloc/component/PostCard.dart';
import 'package:favoritos_bloc/model/Post.dart';
import 'package:favoritos_bloc/view/FavoritesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostBloc _postBloc;

  @override
  void initState() {
    _postBloc = PostBloc();
    super.initState();
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Posts")),
      ),
      body: Container(
          child: StreamBuilder(
              stream: _postBloc.postsListFlux,
              builder: (context, AsyncSnapshot<List<Post>> snapshot) {
                return snapshot.hasData  && snapshot.data.isNotEmpty
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext contexto, int index) {
                          Post _p = snapshot.data[index];
                          return PostCard(
                            post: _p,
                          );
                        },
                      )
                    : Text("No data found");
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.favorite,
        ),
        onPressed: () => Navigator.push(
            context, CupertinoPageRoute(builder: (context) => FavoritesPage())),
      ),
    );
  }
}
