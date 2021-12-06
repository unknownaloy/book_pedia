import 'package:book_pedia/bloc/favorite/favorite_bloc.dart';
import 'package:book_pedia/bloc/favorite/favorite_event.dart';
import 'package:book_pedia/bloc/favorite/favorite_state.dart';
import 'package:book_pedia/enums/request_status.dart';
import 'package:book_pedia/services/database_service.dart';
import 'package:book_pedia/ui/components/book_items_list_view.dart';
import 'package:book_pedia/ui/components/message_display.dart';
import 'package:book_pedia/ui/components/shimmers/loading_shimmer.dart';
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
  final _databaseService = DatabaseService();

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
        ),
        body: BlocProvider(
          create: (context) => _favoriteBloc,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
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
                    label: AppLocalizations.of(context)!.favorites,
                    bookItems: state.bookItems!,
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
