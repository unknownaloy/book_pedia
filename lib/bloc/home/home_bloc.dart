import 'package:book_pedia/bloc/home/home_event.dart';
import 'package:book_pedia/bloc/home/home_state.dart';
import 'package:book_pedia/models/book_model/books.dart';
import 'package:book_pedia/services/books_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BooksService _booksService;

  HomeBloc({required BooksService booksService})
      : _booksService = booksService,
        super(const HomeState()) {
    on<FetchBooks>(_onHomeState);

    on<SearchBooks>(
      _onSearchBooks,
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }

  late Books _books;

  EventTransformer<HomeEvent> debounce<HomeEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  void _onHomeState(FetchBooks event, Emitter<HomeState> emit) async {
    try {
      final books = await _booksService.fetchFamousBooks();
      _books = books;
      return emit(state.copyWith(status: HomeStatus.success, books: books));
    } catch (e) {
      // Handle error here
    }
  }

  void _onSearchBooks(SearchBooks event, Emitter<HomeState> emit) async {
    if (event.searchQuery == "") {
      return emit(state.copyWith(books: _books, homeType: HomeType.famous));
    }

    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final books = await _booksService.fetchFamousBooks(event.searchQuery);

      print("${books.totalItems} => TOTAL ITEMS");

      if (books.totalItems == 0) {
        return emit(state.copyWith(status: HomeStatus.empty));
      }

      emit(state.copyWith(
        status: HomeStatus.success,
        homeType: HomeType.searched,
        books: books,
      ));
    } catch (e) {
      // Handle error here
    }
  }
}
