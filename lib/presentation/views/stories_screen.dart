import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_story_clone/presentation/views/story_view_screen.dart';
import 'package:instagram_story_clone/presentation/views/story_widget.dart';

import '../bloc/story_bloc.dart';
import '../bloc/story_event.dart';
import '../bloc/story_state.dart';
import '../../domain/entities.dart';



class StoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories'),
      ),
      body: BlocBuilder<StoryBloc, StoryState>(
        builder: (context, state) {
          if (state is StoryInitial) {
            context.read<StoryBloc>().add(FetchStories());
            return const Center(child: CircularProgressIndicator());
          } else if (state is StoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StoryLoaded) {
            final Map<int, List<Story>> groupedStories = {};
            for (var story in state.stories) {
              if (!groupedStories.containsKey(story.albumId)) {
                groupedStories[story.albumId] = [];
              }
              if (groupedStories[story.albumId]!.length < 5) {
                groupedStories[story.albumId]!.add(story);
              }
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groupedStories.length,
              itemBuilder: (context, index) {
                final albumId = groupedStories.keys.elementAt(index);
                final stories = groupedStories[albumId]!;
                return Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoryGroupViewScreen(
                              groupedStories: groupedStories,
                              initialAlbumId: albumId,
                            ),
                          ),
                        );
                      },
                      child: StoryGroupWidget(stories: stories),
                    ),
                  ),
                );
              },
            );
          } else if (state is StoryError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
