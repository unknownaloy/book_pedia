import 'package:book_pedia/data/models/book/book_item.dart';
import 'package:book_pedia/data/repositories/database_repository_impl.dart';
import 'package:book_pedia/features/favorite/bloc/favorite_event.dart';
import 'package:book_pedia/features/favorite/bloc/favorite_state.dart';
import 'package:book_pedia/enums/favorite_status.dart';
import 'package:book_pedia/enums/request_status.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:book_pedia/utilities/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final DatabaseRepositoryImpl _databaseService;

  FavoriteBloc({required DatabaseRepositoryImpl databaseService})
      : _databaseService = databaseService,
        super(const FavoriteState()) {
    on<FetchFavorites>(_onFetchFavorites);
    on<FavoritePressed>(_onFavoritePressed);
    on<FetchMoreFavoriteBooks>(_onFetchMoreFavoriteBooks);
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
        return emit(state.copyWith(
          status: RequestStatus.empty,
          hasReachedMax: true,
        ));
      }

      /// If the length of books return is less than 10, it means there's no more
      /// books available in the user's favorite collection to fetch more books from
      if (bookItems.length < 10) {
        return emit(
          state.copyWith(
              status: RequestStatus.success,
              bookItems: bookItems,
              hasReachedMax: true),
        );
      }

      return emit(
          state.copyWith(status: RequestStatus.success, bookItems: bookItems));
    } on Failure catch (e) {
      return emit(state.copyWith(
          status: RequestStatus.failure, errorMessage: e.message));
    }
  }

  void _onFavoritePressed(
    FavoritePressed event,
    Emitter<FavoriteState> emit,
  ) async {
    final List<BookItem> tempBookItems = state.bookItems!;

    final indexOfBookItem =
        tempBookItems.indexWhere((item) => item == event.bookItem);

    if (indexOfBookItem != -1) {
      tempBookItems.removeAt(indexOfBookItem);
      emit(state.copyWith(
          bookItems: tempBookItems,
          favoriteStatus: FavoriteStatus.notFavorite));
    } else {
      tempBookItems.insert(0, event.bookItem);
      emit(state.copyWith(
          bookItems: tempBookItems, favoriteStatus: FavoriteStatus.favorite));
    }

    return emit(
      state.copyWith(favoriteStatus: FavoriteStatus.idle),
    );
  }

  void _onFetchMoreFavoriteBooks(
    FetchMoreFavoriteBooks event,
    Emitter<FavoriteState> emit,
  ) async {
    if (state.hasReachedMax || state.isFetchingNewBooks) return;

    emit(state.copyWith(isFetchingNewBooks: true));

    try {
      final bookItems = await _databaseService.fetchNextFavoriteBooks(
        userId: Global.bookUser.id!,
      );

      if (bookItems.isEmpty) {
        return emit(state.copyWith(
          hasReachedMax: true,
          isFetchingNewBooks: false,
        ));
      }

      List<BookItem>? previousBooks = state.bookItems;

      previousBooks?.addAll(bookItems);

      /// If the length of books return is less than 10, it means there's no more
      /// books available in the user's favorite collection to fetch more books from
      if (bookItems.length < 10) {
        return emit(
          state.copyWith(
            status: RequestStatus.success,
            bookItems: previousBooks,
            hasReachedMax: true,
            isFetchingNewBooks: false,
          ),
        );
      }

      return emit(state.copyWith(
        status: RequestStatus.success,
        bookItems: previousBooks,
      ));
    } on Failure catch (e) {
      return emit(state.copyWith(
          status: RequestStatus.failure, errorMessage: e.message));
    }
  }
}
