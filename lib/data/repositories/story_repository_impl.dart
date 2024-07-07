import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities.dart';
import '../../domain/repositories.dart';
import '../models/story_model.dart';


class StoryRepositoryImpl implements StoryRepository {
  @override
  Future<List<Story>> getStories() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Story> stories = jsonResponse.map((data) => StoryModel.fromJson(data)).toList(); // Adjust to your StoryModel

        return stories;
      } else {
        throw Exception('Failed to load stories');
      }
    } catch (e) {
      print('Error fetching stories: $e');
      throw Exception('Failed to load stories: $e');
    }
  }
}
