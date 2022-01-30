import 'package:book_pedia/data/repositories/book_repository_impl.dart';
import 'package:book_pedia/features/details/views/details_screen.dart';
import 'package:book_pedia/features/home/bloc/home_bloc.dart';
import 'package:book_pedia/features/home/bloc/home_event.dart';
import 'package:book_pedia/features/home/bloc/home_state.dart';
import 'package:book_pedia/reusables/book_card.dart';
import 'package:book_pedia/reusables/persistent_header.dart';
import 'package:book_pedia/config/theme/colors.dart';
import 'package:book_pedia/reusables/message_display.dart';
import 'package:book_pedia/features/home/components/home_drawer.dart';
import 'package:book_pedia/reusables/shimmers/loading_shimmer.dart';
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
  final _booksService = BookRepositoryImpl();

  final TextEditingController _searchController = TextEditingController();

  late final ScrollController _scrollController;

  bool _isSearchedResult = false;

  late String _searchedQueryText;

  bool _isAtBottom = false;
  bool _isLoadingMoreData = false;

  void _scrollListenerHandler() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double delta = MediaQuery.of(context).size.height * 0.20;

    if (maxScroll - currentScroll <= delta) {
      _homeBloc.add(
        FetchBooks(
          _searchController.text.trim(),
        ),
      );
    }

    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() => _isAtBottom = true);
    } else {
      setState(() => _isAtBottom = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(booksService: _booksService);
    _homeBloc.add(FetchFamousBooks());

    _scrollController = ScrollController();

    _scrollController.addListener(_scrollListenerHandler);
  }

  @override
  void dispose() {
    _homeBloc.close();
    _searchController.dispose();

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const HomeDrawer(),
        body: BlocProvider(
          create: (context) => _homeBloc,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                snap: true,
                title: Text(
                  "Book Pedia",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 40.0,
                ),
                sliver: SliverToBoxAdapter(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 1),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!
                          .exploreThousandsOfBooksOnTheGo,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeader(
                  // minHeight: 64.0,
                  margin: const EdgeInsets.only(
                    top: 0.0,
                    bottom: 8.0,
                  ),
                  child: Container(
                    height: 56.0,
                    margin: const EdgeInsets.only(
                      // top: 18.0,
                      // bottom: 6.0,
                      left: 16.0,
                      right: 16.0,
                    ),
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
                        _homeBloc.add(
                          SearchBooks(
                            searchQuery: _searchController.text.trim(),
                          ),
                        );
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
                          left: 24.0,
                          right: 24.0,
                          top: 16.0,
                        ),
                        hintText: AppLocalizations.of(context)!.searchForBooks,
                        border: InputBorder.none,
                        focusColor: kAccentColor,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      _isSearchedResult
                          ? _searchedQueryText
                          : AppLocalizations.of(context)!.famousBooks,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
              ),
              BlocConsumer<HomeBloc, HomeState>(
                bloc: _homeBloc,
                listener: (context, state) {
                  if (state.status == HomeStatus.success) {
                    if (state.homeType == HomeType.famous) {
                      setState(() => _isSearchedResult = false);
                    } else {
                      setState(() {
                        _isSearchedResult = true;
                        _searchedQueryText = _searchController.text.trim();
                      });
                    }

                    if (state.isFetchingNewBooks) {
                      setState(() => _isLoadingMoreData = true);
                    } else {
                      setState(() => _isLoadingMoreData = false);
                    }
                  }

                  if (state.status == HomeStatus.empty) {
                    setState(() => _searchedQueryText = "No result found");
                  }
                },
                builder: (context, state) {
                  if (state.status == HomeStatus.failure) {
                    return SliverFillRemaining(
                      child: MessageDisplay(error: state.errorMessage!),
                    );
                  }

                  if (state.status == HomeStatus.empty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Image.asset(
                          "assets/no_search_result.png",
                          width: 80.0,
                          color: kAccentColor,
                          colorBlendMode: BlendMode.srcATop,
                        ),
                      ),
                    );
                  }

                  if (state.status == HomeStatus.success) {
                    final bookItems = state.books!.bookItem;

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final book = bookItems![index];
                          return BookCard(
                            imageUrl:
                                book.bookVolumeInfo.bookImages?.smallThumbnail,
                            bookTitle: book.bookVolumeInfo.title,
                            bookAuthor: book.bookVolumeInfo.authors?.join(", "),
                            bookRating: book.bookVolumeInfo.rating,
                            category: book.bookVolumeInfo.categories?[0],
                            heroTag: book.id,
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      DetailsScreen(
                                    bookItem: book,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        childCount: bookItems!.length,
                      ),
                    );
                  }

                  return const SliverFillRemaining(
                    child: LoadingShimmer(),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: _isAtBottom && _isLoadingMoreData
                    ? Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 4.0,
                          ),
                          width: 18.0,
                          height: 18.0,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: kAccentColor,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
