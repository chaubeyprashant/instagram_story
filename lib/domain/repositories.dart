
import 'entities.dart';

abstract class StoryRepository {
  Future<List<Story>> getStories();
}
