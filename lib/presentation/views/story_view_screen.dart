import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../domain/entities.dart';

class StoryGroupViewScreen extends StatefulWidget {
  final Map<int, List<Story>> groupedStories;
  final int initialAlbumId;

  const StoryGroupViewScreen({
    Key? key,
    required this.groupedStories,
    required this.initialAlbumId,
  }) : super(key: key);

  @override
  _StoryGroupViewScreenState createState() => _StoryGroupViewScreenState();
}

class _StoryGroupViewScreenState extends State<StoryGroupViewScreen> {
  late StoryController storyController;
  late List<Story> currentStories;
  late int currentAlbumId;

  @override
  void initState() {
    super.initState();
    storyController = StoryController();
    currentAlbumId = widget.initialAlbumId;
    currentStories = widget.groupedStories[currentAlbumId]!;
  }

  void moveToNextAlbum() {
    final albumIds = widget.groupedStories.keys.toList();
    final currentIndex = albumIds.indexOf(currentAlbumId);

    if (currentIndex < albumIds.length - 1) {
      setState(() {
        currentAlbumId = albumIds[currentIndex + 1];
        currentStories = widget.groupedStories[currentAlbumId]!;
        storyController = StoryController();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  void moveToPreviousAlbum() {
    final albumIds = widget.groupedStories.keys.toList();
    final currentIndex = albumIds.indexOf(currentAlbumId);

    if (currentIndex > 0) {
      setState(() {
        currentAlbumId = albumIds[currentIndex - 1];
        currentStories = widget.groupedStories[currentAlbumId]!;
        storyController = StoryController();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
            moveToNextAlbum();
          } else if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
            moveToPreviousAlbum();
          }
        },
        child: Stack(
          children: [
            StoryView(
              storyItems: currentStories.map((story) {
                return StoryItem.pageImage(
                  url: story.url,
                  controller: storyController,
                  duration: const Duration(seconds: 5),
                );
              }).toList(),
              onStoryShow: (s, index) {
                print("Showing story ${index + 1}");
              },
              onComplete: () {
                moveToNextAlbum();
              },
              progressPosition: ProgressPosition.bottom,
              repeat: false,
              controller: storyController,
            ),
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'User: $currentAlbumId',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }
}
