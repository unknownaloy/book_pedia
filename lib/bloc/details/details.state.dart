import 'package:book_pedia/enums/favorite_status.dart';
import 'package:equatable/equatable.dart';

// abstract class DetailsState extends Equatable {
//   const DetailsState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class DetailsInitial extends DetailsState {}
//
// class IsFavoriteBook extends DetailsState {}
//
// class IsNotFavoriteBook extends DetailsState {}

class DetailsState extends Equatable {
  final FavoriteStatus favoriteStatus;

  const DetailsState({this.favoriteStatus = FavoriteStatus.initial});

  DetailsState copyWith({FavoriteStatus? favoriteStatus}) {
    return DetailsState(favoriteStatus: favoriteStatus ?? this.favoriteStatus);
  }

  @override
  List<Object> get props => [favoriteStatus];
}
