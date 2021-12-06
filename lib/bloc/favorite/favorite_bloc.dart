import 'package:book_pedia/bloc/favorite/favorite_event.dart';
import 'package:book_pedia/bloc/favorite/favorite_state.dart';
import 'package:book_pedia/enums/favorite_status.dart';
import 'package:book_pedia/enums/request_status.dart';
import 'package:book_pedia/models/book_model/book_item.dart';
import 'package:book_pedia/services/database_service.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:book_pedia/utilities/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final DatabaseService _databaseService;

  FavoriteBloc({required DatabaseService databaseService})
      : _databaseService = databaseService,
        super(const FavoriteState()) {
    on<FetchFavorites>(_onFetchFavorites);
    on<FavoritePressed>(_onFavoritePressed);
  }

  void _onFetchFavorites(
    FetchFavorites event,
    Emitter<FavoriteState> emit,
  ) async {

    try {
      final bookItems = await _databaseService.fetchFavoriteBooks(
        userId: Global.bookUser.id!,
      );

      if (bookItems.isEmpty) {
        return emit(state.copyWith(status: RequestStatus.empty));
      }

      return emit(state.copyWith(status: RequestStatus.success, bookItems: bookItems));
    } on Failure catch (e) {
      return emit(state.copyWith(status: RequestStatus.failure, errorMessage: e.message));
    }
  }

  void _onFavoritePressed(
    FavoritePressed event,
    Emitter<FavoriteState> emit,
  ) async {

    final List<BookItem>tempBookItems = state.bookItems!;

    final indexOfBookItem = tempBookItems.indexWhere((item) => item == event.bookItem);

    if (indexOfBookItem != -1) {
      tempBookItems.removeAt(indexOfBookItem);
      emit(state.copyWith(bookItems: tempBookItems, favoriteStatus: FavoriteStatus.notFavorite));
    } else {
      tempBookItems.insert(0, event.bookItem);
      emit(state.copyWith(bookItems: tempBookItems, favoriteStatus: FavoriteStatus.favorite));
    }

    return emit (state.copyWith(favoriteStatus: FavoriteStatus.idle));
  }
}
