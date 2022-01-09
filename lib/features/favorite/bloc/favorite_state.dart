import 'package:book_pedia/enums/favorite_status.dart';
import 'package:book_pedia/enums/request_status.dart';
import 'package:book_pedia/common/models/book_model/book_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class FavoriteState extends Equatable {
  final RequestStatus status;
  final List<BookItem>? bookItems;
  final String? errorMessage;
  final FavoriteStatus favoriteStatus;

  const FavoriteState({
    this.status = RequestStatus.loading,
    this.bookItems,
    this.errorMessage,
    this.favoriteStatus = FavoriteStatus.favorite,
  });

  FavoriteState copyWith({
    RequestStatus? status,
    List<BookItem>? bookItems,
    String? errorMessage,
    FavoriteStatus? favoriteStatus,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      bookItems: bookItems ?? this.bookItems,
      errorMessage: errorMessage ?? this.errorMessage,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
    );
  }

  @override
  List<Object?> get props => [status, bookItems, favoriteStatus];
}
