
import 'package:instagram_story_clone/domain/repositories.dart';

import 'entities.dart';

class GetStories {
  final StoryRepository repository;

  GetStories(this.repository);

  Future<List<Story>> call() async {
    return await repository.getStories();
  }
}
