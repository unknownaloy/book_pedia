import 'package:book_pedia/data/models/book/book_item.dart';
import 'package:book_pedia/enums/favorite_status.dart';
import 'package:book_pedia/enums/request_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class FavoriteState extends Equatable {
  final RequestStatus status;
  final List<BookItem>? bookItems;
  final String? errorMessage;
  final bool hasReachedMax;
  final bool isFetchingNewBooks;
  final FavoriteStatus favoriteStatus;

  const FavoriteState({
    this.status = RequestStatus.loading,
    this.bookItems,
    this.errorMessage,
    this.hasReachedMax = false,
    this.isFetchingNewBooks = false,
    this.favoriteStatus = FavoriteStatus.favorite,
  });

  FavoriteState copyWith({
    RequestStatus? status,
    List<BookItem>? bookItems,
    String? errorMessage,
    bool? hasReachedMax,
    bool? isFetchingNewBooks,
    FavoriteStatus? favoriteStatus,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      bookItems: bookItems ?? this.bookItems,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetchingNewBooks: isFetchingNewBooks ?? this.isFetchingNewBooks,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
    );
  }

  @override
  List<Object?> get props => [
        status,
        bookItems,
        favoriteStatus,
        hasReachedMax,
        isFetchingNewBooks,
      ];
}
