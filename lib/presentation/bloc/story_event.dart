import 'package:equatable/equatable.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class FetchStories extends StoryEvent {}
