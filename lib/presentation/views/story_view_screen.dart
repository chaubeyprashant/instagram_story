import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../domain/entities.dart';

class StoryViewScreen extends StatelessWidget {
  final Story story;

  const StoryViewScreen({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storyController = StoryController();

    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.pageImage(
            url: story.url,
            controller: storyController,
          ),
          // Add more StoryItems if needed
        ],
        onStoryShow: (s, index) {
          print("Showing story ${index + 1}");
        },
        onComplete: () {
          Navigator.of(context).pop();
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}
