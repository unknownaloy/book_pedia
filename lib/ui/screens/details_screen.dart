import 'package:book_pedia/bloc/details/details.event.dart';
import 'package:book_pedia/bloc/details/details.state.dart';
import 'package:book_pedia/bloc/details/details_bloc.dart';
import 'package:book_pedia/enums/favorite_status.dart';
import 'package:book_pedia/models/book_model/book_item.dart';
import 'package:book_pedia/services/database_service.dart';
import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/ui/components/book_item_description.dart';
import 'package:book_pedia/ui/components/book_item_detail.dart';
import 'package:book_pedia/ui/components/book_item_rating.dart';
import 'package:book_pedia/utilities/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final BookItem bookItem;
  final Function(BookItem)? onFavorite;

  const DetailsScreen({
    Key? key,
    required this.bookItem,
    this.onFavorite,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late DetailsBloc _detailsBloc;
  final _databaseService = DatabaseService();

  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _curve;

  late bool _isFavorite;

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    print("Init state called");

    _isFavorite = widget.bookItem.isFavorite;

    _detailsBloc = DetailsBloc(databaseService: _databaseService);
    _detailsBloc.add(
      DetailsLaunched(userId: Global.bookUser.id!, bookItem: widget.bookItem),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 24, end: 40), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 40, end: 24), weight: 50),
    ]).animate(_curve);

    _animationController.addListener(() {});

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _hasAnimated = true);
      }

      if (status == AnimationStatus.dismissed) {
        setState(() => _hasAnimated = false);
      }
    });
  }

  @override
  void dispose() {
    _detailsBloc.close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => _detailsBloc,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    expandedHeight: 320.0,
                    floating: false,
                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        widget.bookItem.bookVolumeInfo.title,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      background: Hero(
                        tag: widget.bookItem.id,
                        child: Image.network(
                          widget.bookItem.bookVolumeInfo.bookImages
                                  ?.mainThumbnail ??
                              "https://www.w3schools.com/w3images/avatar6.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(
                top: 72.0,
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Authors
                  widget.bookItem.bookVolumeInfo.authors != null
                      ? DetailItem(
                          label: "Authors",
                          bodyText: widget.bookItem.bookVolumeInfo.authors!
                              .join(", "),
                        )
                      : const SizedBox.shrink(),

                  /// Subtitle
                  widget.bookItem.bookVolumeInfo.subtitle != null
                      ? DetailItem(
                          label: "Subtitle",
                          bodyText: widget.bookItem.bookVolumeInfo.subtitle!)
                      : const SizedBox.shrink(),

                  /// Category
                  widget.bookItem.bookVolumeInfo.categories != null
                      ? DetailItem(
                          label: "Category",
                          bodyText: widget.bookItem.bookVolumeInfo.categories!
                              .join(", "),
                        )
                      : const SizedBox.shrink(),

                  /// Ratings
                  widget.bookItem.bookVolumeInfo.rating != null
                      ? BookItemRating(
                          label: "Rating",
                          rating: widget.bookItem.bookVolumeInfo.rating!)
                      : const SizedBox.shrink(),

                  /// Pages
                  widget.bookItem.bookVolumeInfo.pages != null
                      ? DetailItem(
                          label: "Pages",
                          bodyText: "${widget.bookItem.bookVolumeInfo.pages}")
                      : const SizedBox.shrink(),

                  const SizedBox(
                    height: 24.0,
                  ),

                  /// Book description
                  widget.bookItem.bookVolumeInfo.description != null
                      ? BookItemDescription(
                          description:
                              widget.bookItem.bookVolumeInfo.description!)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // _hasAnimated
              //     ? _animationController.reverse()
              //     : _animationController.forward();
              _animationController.reset();
              _animationController.forward();
              _detailsBloc.add(
                FavoriteButtonPressed(
                  userId: Global.bookUser.id!,
                  bookItem: widget.bookItem,
                ),
              );

              if (widget.onFavorite != null) {
                print("DetailsScreen => widget.onFavorite is not null");
                widget.onFavorite!(widget.bookItem);
              }
            },
            child: BlocListener<DetailsBloc, DetailsState>(
              bloc: _detailsBloc,
              listener: (context, state) {
                if (state.favoriteStatus == FavoriteStatus.notFavorite) {
                  if (_isFavorite) {
                    setState(() => _isFavorite = false);
                  }
                }

                if (state.favoriteStatus == FavoriteStatus.favorite) {
                  if (!_isFavorite) {
                    setState(() => _isFavorite = true);
                  }
                }
              },
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, _) {
                  return Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: _sizeAnimation.value,
                    color: kTextColor,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
