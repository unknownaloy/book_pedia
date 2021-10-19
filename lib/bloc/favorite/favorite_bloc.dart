import 'package:book_pedia/bloc/favorite/favorite_event.dart';
import 'package:book_pedia/bloc/favorite/favorite_state.dart';
import 'package:book_pedia/services/database_service.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:book_pedia/utilities/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final DatabaseService _databaseService;

  FavoriteBloc({required DatabaseService databaseService})
      : _databaseService = databaseService,
        super(FavoritesLoading()) {
    on<FetchFavorites>(_onFetchFavorites);
  }

  void _onFetchFavorites(
      FetchFavorites event, Emitter<FavoriteState> emit) async {
    emit(FavoritesLoading());

    try {
      final bookItems = await _databaseService.fetchFavoriteBooks(
        userId: Global.bookUser.id!,
      );

      if (bookItems.isEmpty) {
        return emit(FavoritesEmpty());
      }

      return emit(FavoritesSuccess(bookItems: bookItems));
    } on Failure catch (e) {
       return emit(FavoritesFailure(errorMessage: e.message));
    }
  }
}
