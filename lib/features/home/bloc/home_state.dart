import 'package:book_pedia/data/models/books.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum HomeStatus { initial, loading, success, empty, failure }

enum HomeType { famous, searched }

@immutable
class HomeState extends Equatable {
  final HomeStatus status;
  final HomeType homeType;
  final Books? books;
  final String? errorMessage;
  final bool hasReachedMax;
  final bool isFetchingNewBooks;

  const HomeState({
    this.status = HomeStatus.initial,
    this.homeType = HomeType.famous,
    this.books,
    this.errorMessage,
    this.hasReachedMax = false,
    this.isFetchingNewBooks = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    HomeType? homeType,
    Books? books,
    String? errorMessage,
    bool? hasReachedMax,
    bool? isFetchingNewBooks,
  }) {
    return HomeState(
      status: status ?? this.status,
      homeType: homeType ?? this.homeType,
      books: books ?? this.books,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetchingNewBooks: isFetchingNewBooks ?? this.isFetchingNewBooks,
    );
  }

  @override
  List<Object?> get props => [
        status,
        homeType,
        books,
        errorMessage,
        hasReachedMax,
        isFetchingNewBooks,
      ];
}

// @immutable
// abstract class HomeState extends Equatable {
//   const HomeState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class HomeLoading extends HomeState {}
//
// class HomeSuccess extends HomeState {
//   final Books books;
//
//   const HomeSuccess({required this.books});
//
//   @override
//   List<Object> get props => [books];
// }
//
// class HomeFailure extends HomeState {
//   final String error;
//
//   const HomeFailure({required this.error});
//
//   @override
//   List<Object> get props => [error];
// }
