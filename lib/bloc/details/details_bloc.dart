import 'package:book_pedia/bloc/details/details.event.dart';
import 'package:book_pedia/bloc/details/details.state.dart';
import 'package:book_pedia/enums/favorite_status.dart';
import 'package:book_pedia/models/book_model/book_item.dart';
import 'package:book_pedia/services/database_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DatabaseService _databaseService;

  DetailsBloc({required DatabaseService databaseService})
      : _databaseService = databaseService,
        super(const DetailsState()) {
    on<DetailsLaunched>(_onDetailsLaunched);

    on<FavoriteButtonPressed>(_onFavoriteButtonPressed);
  }

  void _onDetailsLaunched(
      DetailsLaunched event, Emitter<DetailsState> emit) async {
    if (!event.bookItem.isFavorite) {
      final status = await _databaseService.getFavoriteStatus(
        userId: event.userId,
        bookItem: event.bookItem,
      );

      if (status) {
        return emit(state.copyWith(favoriteStatus: FavoriteStatus.favorite));
      }

      return emit(state.copyWith(favoriteStatus: FavoriteStatus.notFavorite));
    }

    return emit(state.copyWith(favoriteStatus: FavoriteStatus.favorite));
  }

  void _onFavoriteButtonPressed(
      FavoriteButtonPressed event, Emitter<DetailsState> emit) async {
    if (state.favoriteStatus != FavoriteStatus.idle) {
      if (state.favoriteStatus == FavoriteStatus.favorite) {
        emit(state.copyWith(favoriteStatus: FavoriteStatus.notFavorite));
        return await _databaseService.removeBookItemFromFavorite(
          userId: event.userId,
          bookItem: event.bookItem,
        );
      }

      event.bookItem.isFavorite = true;

      emit(state.copyWith(favoriteStatus: FavoriteStatus.favorite));
      return await _databaseService.addBookItemToFavorite(
        userId: event.userId,
        bookItem: event.bookItem,
      );
    }
  }
}
