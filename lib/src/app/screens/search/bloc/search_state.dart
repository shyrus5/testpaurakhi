part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchStartState extends SearchState {}

class ResetStartState extends SearchState {}

class SearchedState extends SearchState {}
