import 'package:book_pedia/data/models/book/book_item.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FetchFavorites extends FavoriteEvent {}

class FavoritePressed extends FavoriteEvent {
  final BookItem bookItem;

  const FavoritePressed({required this.bookItem});

  @override
  List<Object> get props => [bookItem];
}

class FetchMoreFavoriteBooks extends FavoriteEvent {}