import 'package:book_pedia/models/book_model/book_item.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoriteState {}

class FavoritesSuccess extends FavoriteState {
  final List<BookItem> bookItems;

  const FavoritesSuccess({required this.bookItems});

  @override
  List<Object> get props => [bookItems];
}

class FavoritesEmpty extends FavoriteState {}

class FavoritesFailure extends FavoriteState {
  final String errorMessage;

  const FavoritesFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
