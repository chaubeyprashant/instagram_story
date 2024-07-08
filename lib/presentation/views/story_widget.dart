import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities.dart';

class StoryGroupWidget extends StatelessWidget {
  final List<Story> stories;

  const StoryGroupWidget({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: CachedNetworkImageProvider(stories[0].thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
