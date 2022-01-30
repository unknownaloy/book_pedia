import 'package:book_pedia/data/models/books.dart';
import 'package:book_pedia/data/repositories/book_repository_impl.dart';
import 'package:book_pedia/features/home/bloc/home_event.dart';
import 'package:book_pedia/features/home/bloc/home_state.dart';
import 'package:book_pedia/utilities/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BookRepositoryImpl _booksService;

  HomeBloc({required BookRepositoryImpl booksService})
      : _booksService = booksService,
        super(const HomeState()) {
    on<FetchFamousBooks>(_onFetchFamousBooks);

    on<SearchBooks>(
      _onSearchBooks,
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );

    on<FetchBooks>(_onFetchBooks);
  }

  Books? _cachedBooks;

  EventTransformer<HomeEvent> debounce<HomeEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  void _onFetchFamousBooks(
      FetchFamousBooks event, Emitter<HomeState> emit) async {
    try {
      final books = await _booksService.fetchBooks();
      _cachedBooks = books;
      return emit(state.copyWith(status: HomeStatus.success, books: books));
    } on Failure catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
    }
  }

  void _onSearchBooks(SearchBooks event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    if (event.searchQuery == "" || event.searchQuery.isEmpty) {
      if (_cachedBooks == null) {
        try {
          final books = await _booksService.fetchBooks();
          _cachedBooks = books;
          return emit(state.copyWith(
            status: HomeStatus.success,
            homeType: HomeType.famous,
            books: books,
          ));
        } on Failure catch (e) {
          return emit(
            state.copyWith(status: HomeStatus.failure, errorMessage: e.message),
          );
        }
      }

      return emit(state.copyWith(
        books: _cachedBooks,
        homeType: HomeType.famous,
        status: HomeStatus.success,
      ));
    }

    try {
      final books = await _booksService.fetchBooks(query: event.searchQuery);

      if (books.totalItems == 0) {
        return emit(state.copyWith(
            status: HomeStatus.empty, homeType: HomeType.searched));
      }

      emit(state.copyWith(
        status: HomeStatus.success,
        homeType: HomeType.searched,
        books: books,
      ));
    } on Failure catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
    }
  }

  void _onFetchBooks(
    FetchBooks event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMax) return;

    if (state.isFetchingNewBooks) return;

    emit(state.copyWith(isFetchingNewBooks: true));

    final bookLastIndex = state.books!.bookItem!.length;

    late Books books;

    try {
      state.homeType == HomeType.famous
          ? books = await _booksService.fetchBooks(startIndex: bookLastIndex)
          : books = await _booksService.fetchBooks(
              startIndex: bookLastIndex,
              query: event.searchQuery!,
            );

      if (books.totalItems == 0) {
        return emit(
            state.copyWith(hasReachedMax: true, isFetchingNewBooks: false));
      } else {
        Books? previousBooks = state.books;

        previousBooks?.bookItem?.addAll(books.bookItem!);

        if (state.homeType == HomeType.famous) {
          _cachedBooks = previousBooks;
        }

        return emit(
          state.copyWith(
            status: HomeStatus.success,
            books: previousBooks,
            isFetchingNewBooks: false,
          ),
        );
      }
    } on Failure catch (e) {
      // TODO: Handle error here
      print("_onFetchBooks error -> ${e.message}");
    }
  }
}
