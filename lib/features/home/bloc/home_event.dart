import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchBooks extends HomeEvent {}

class SearchBooks extends HomeEvent {
  final String searchQuery;

  const SearchBooks({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}