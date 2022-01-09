import 'package:book_pedia/common/models/book_model/book_item.dart';
import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class DetailsLaunched extends DetailsEvent {
  final String userId;
  final BookItem bookItem;

  const DetailsLaunched({required this.userId, required this.bookItem});

  @override
  List<Object> get props => [userId, bookItem];
}

class FavoriteButtonPressed extends DetailsEvent {
  final String userId;
  final BookItem bookItem;

  const FavoriteButtonPressed({required this.userId, required this.bookItem});

  @override
  List<Object> get props => [userId, bookItem];
}