import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_story_clone/presentation/views/story_widget.dart';

import '../bloc/story_bloc.dart';
import '../bloc/story_event.dart';
import '../bloc/story_state.dart';

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
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.stories.length,
              itemBuilder: (context, index) {
                final story = state.stories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: StoryWidget(story: story),
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
