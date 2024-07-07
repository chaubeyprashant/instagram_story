import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_story_clone/presentation/bloc/story_event.dart';
import 'package:instagram_story_clone/presentation/bloc/story_state.dart';

import '../../domain/usecases.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final GetStories getStories;

  StoryBloc({required this.getStories}) : super(StoryInitial()) {
    on<FetchStories>((event, emit) async {
      emit(StoryLoading());
      try {
        final stories = await getStories();
        emit(StoryLoaded(stories: stories));
      } catch (e) {
        emit(StoryError(message: e.toString()));
      }
    });
  }
}
