import 'package:favoritos_bloc/bloc/FavoritosBloc.dart';
import 'package:favoritos_bloc/view/PostPage.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       bloc: FavoritosBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PostPage(),
      ),
    );
  }
}
