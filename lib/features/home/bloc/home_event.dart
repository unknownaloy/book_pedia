import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchBooks extends HomeEvent {
  final String? searchQuery;

  const FetchBooks(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}

class FetchFamousBooks extends HomeEvent {}

class SearchBooks extends HomeEvent {
  final String searchQuery;

  const SearchBooks({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}