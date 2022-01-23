import 'package:book_pedia/common/models/book_model/book_item.dart';
import 'package:book_pedia/config/theme/colors.dart';
import 'package:book_pedia/reusables/book_card.dart';
import 'package:book_pedia/features/details/views/details_screen.dart';
import 'package:flutter/material.dart';

class BookItemsListView extends StatefulWidget {
  final List<BookItem> bookItems;
  final Function(BookItem)? onFavoriteHandler;
  final bool isLoadingMoreData;
  final VoidCallback? onScrollEnd;

  const BookItemsListView({
    Key? key,
    required this.bookItems,
    this.onFavoriteHandler,
    this.isLoadingMoreData = false,
    this.onScrollEnd,
  }) : super(key: key);

  @override
  State<BookItemsListView> createState() => _BookItemsListViewState();
}

class _BookItemsListViewState extends State<BookItemsListView> {
  late final ScrollController _scrollController;

  bool _isAtBottom = false;

  void _scrollListenerHandler() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double delta = MediaQuery.of(context).size.height * 0.20;

    if (maxScroll - currentScroll <= delta) {
      widget.onScrollEnd!();
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

    _scrollController = ScrollController();

    _scrollController.addListener(_scrollListenerHandler);
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.bookItems.length,
            itemBuilder: (BuildContext context, int index) {
              final book = widget.bookItems[index];
              return BookCard(
                imageUrl: book.bookVolumeInfo.bookImages?.smallThumbnail,
                bookTitle: book.bookVolumeInfo.title,
                bookAuthor: book.bookVolumeInfo.authors?.join(", "),
                bookRating: book.bookVolumeInfo.rating,
                category: book.bookVolumeInfo.categories?[0],
                heroTag: book.id,
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => DetailsScreen(
                        bookItem: book,
                        onFavorite: widget.onFavoriteHandler,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        _isAtBottom && widget.isLoadingMoreData
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                width: 16.0,
                height: 16.0,
                child: const CircularProgressIndicator(
                  color: kAccentColor,
                  strokeWidth: 2.0,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
