import 'package:book_pedia/data/repositories/database_repository_impl.dart';
import 'package:book_pedia/features/favorite/bloc/favorite_bloc.dart';
import 'package:book_pedia/features/favorite/bloc/favorite_event.dart';
import 'package:book_pedia/features/favorite/bloc/favorite_state.dart';
import 'package:book_pedia/enums/request_status.dart';
import 'package:book_pedia/reusables/book_items_list_view.dart';
import 'package:book_pedia/reusables/message_display.dart';
import 'package:book_pedia/reusables/shimmers/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteBloc _favoriteBloc;
  final _databaseService = DatabaseRepositoryImpl();

  @override
  void initState() {
    super.initState();

    _favoriteBloc = FavoriteBloc(databaseService: _databaseService);
    _favoriteBloc.add(FetchFavorites());
  }

  @override
  void dispose() {
    _favoriteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            AppLocalizations.of(context)!.favorites,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: BlocProvider(
          create: (context) => _favoriteBloc,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8.0),
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if (state.status == RequestStatus.empty) {
                  return MessageDisplay(
                      error: AppLocalizations.of(context)!.noResultFound);
                }

                if (state.status == RequestStatus.failure) {
                  return MessageDisplay(
                    error: state.errorMessage!,
                  );
                }

                if (state.status == RequestStatus.success) {
                  return BookItemsListView(
                    bookItems: state.bookItems!,
                    onScrollEnd: () {
                      _favoriteBloc.add(FetchMoreFavoriteBooks());
                    },
                    isLoadingMoreData: state.isFetchingNewBooks, // Whether to display bottom loading icon
                    onFavoriteHandler: (bookItem) => _favoriteBloc.add(
                      FavoritePressed(bookItem: bookItem),
                    ),
                  );
                }

                return const LoadingShimmer();
              },
            ),
          ),
        ),
      ),
    );
  }
}
