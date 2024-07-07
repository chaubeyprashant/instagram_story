import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_story_clone/presentation/bloc/story_bloc.dart';
import 'package:instagram_story_clone/presentation/views/stories_screen.dart';
import 'package:http/http.dart' as http;
import 'data/repositories/story_repository_impl.dart';
import 'domain/usecases.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StoryBloc(getStories: GetStories(StoryRepositoryImpl())),
        ),
      ],
      child: MaterialApp(
        title: 'Instagram Stories Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoriesScreen(),
      ),
    );
  }
}
