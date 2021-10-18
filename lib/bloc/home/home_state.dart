import 'package:book_pedia/models/book_model/books.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum HomeStatus { loading, success, empty, failure }

enum HomeType { famous, searched }

@immutable
class HomeState extends Equatable {
  final HomeStatus status;
  final HomeType homeType;
  final Books? books;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.loading,
    this.homeType = HomeType.famous,
    this.books,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    HomeType? homeType,
    Books? books,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      homeType: homeType ?? this.homeType,
      books: books ?? this.books,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, homeType, books, errorMessage];
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
