import 'package:book_pedia/bloc/home/home_bloc.dart';
import 'package:book_pedia/bloc/home/home_event.dart';
import 'package:book_pedia/bloc/home/home_state.dart';
import 'package:book_pedia/services/books_service.dart';
import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/ui/components/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;
  final _booksService = BooksService();

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(booksService: _booksService);
    _homeBloc.add(FetchBooks());
  }

  @override
  void dispose() {
    _homeBloc.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => _homeBloc,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                /// App's slogan
                Text(
                  AppLocalizations.of(context)!.exploreThousandsOfBooksOnTheGo,
                  style: Theme.of(context).textTheme.headline2,
                ),

                const SizedBox(
                  height: 24.0,
                ),

                /// Search text widget
                Container(
                  height: 56.0,
                  margin: const EdgeInsets.only(
                    bottom: 6.0,
                  ), //Same as `blurRadius` i guess
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.transparent),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: kShadowColor,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 8.0,
                        spreadRadius: 4.0,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) {
                      _homeBloc.add(SearchBooks(
                          searchQuery: _searchController.text.trim()));
                    },
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          left: 32.0,
                          right: 16.0,
                        ),
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 16.0),
                      hintText: AppLocalizations.of(context)!.searchForBooks,
                      border: InputBorder.none,
                      focusColor: kAccentColor,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 24.0,
                ),

                BlocBuilder<HomeBloc, HomeState>(
                  bloc: _homeBloc,
                  builder: (context, state) {
                    if (state.status == HomeStatus.failure) {
                      return const Text("Something went wrong");
                    }

                    if (state.status == HomeStatus.empty) {
                      return const Text("No result found");
                    }

                    if (state.status == HomeStatus.success) {
                      final bookItems = state.books!.bookItem;
                      return Expanded(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.homeType == HomeType.famous
                                    ? "Famous Books"
                                    : _searchController.text.trim(),
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: bookItems!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final book = bookItems[index];
                                  return BookCard(
                                    imageUrl: book.bookVolumeInfo.bookImages
                                        ?.smallThumbnail,
                                    bookTitle: book.bookVolumeInfo.title,
                                    bookAuthor: book.bookVolumeInfo.authors?[0],
                                    bookRating: book.bookVolumeInfo.rating,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return const Text("Loading...");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
