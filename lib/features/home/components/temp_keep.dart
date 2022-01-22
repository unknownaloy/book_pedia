import 'package:flutter/material.dart';

class TempKeep extends StatelessWidget {
  const TempKeep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const HomeDrawer(),
        body: BlocProvider(
          create: (context) => _homeBloc,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                  NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    pinned: false,
                    floating: true,
                    snap: true,
                    title: Text(
                      "Book Pedia",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverToBoxAdapter(
                    child:

                    /// App's slogan
                    Text(
                      AppLocalizations.of(context)!
                          .exploreThousandsOfBooksOnTheGo,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),

              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                // horizontal: 16.0,
              ),
              child: Column(
                children: [
                  /// Search text widget
                  Container(
                    height: 56.0,
                    margin: const EdgeInsets.only(
                      top: 18.0,
                      bottom: 6.0,
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

                  const SizedBox(
                    height: 24.0,
                  ),

                  BlocBuilder<HomeBloc, HomeState>(
                    bloc: _homeBloc,
                    builder: (context, state) {
                      if (state.status == HomeStatus.failure) {
                        return Expanded(
                          child: MessageDisplay(error: state.errorMessage!),
                        );
                      }

                      if (state.status == HomeStatus.empty) {
                        return Expanded(
                          child: MessageDisplay(
                              error:
                              AppLocalizations.of(context)!.noResultFound),
                        );
                      }

                      if (state.status == HomeStatus.success) {
                        final bookItems = state.books!.bookItem;

                        return Expanded(
                          child: BookItemsListView(
                            label: state.homeType == HomeType.famous
                                ? AppLocalizations.of(context)!.famousBooks
                                : _searchController.text.trim(),
                            bookItems: bookItems!,
                            isLoadingMoreData: state.isFetchingNewBooks,
                            onScrollEnd: () {
                              _homeBloc.add(FetchBooks(_searchController.text.trim()));
                            },
                          ),
                        );
                      }

                      return const Expanded(
                        child: LoadingShimmer(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
