import 'package:book_pedia/common/models/book_model/book_item.dart';
import 'package:book_pedia/reusables/book_card.dart';
import 'package:book_pedia/features/details/views/details_screen.dart';
import 'package:flutter/material.dart';

class BookItemsListView extends StatelessWidget {
  final String label;
  final List<BookItem> bookItems;
  final Function(BookItem)? onFavoriteHandler;

  const BookItemsListView({
    Key? key,
    required this.label,
    required this.bookItems,
    this.onFavoriteHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: bookItems.length,
            itemBuilder: (BuildContext context, int index) {
              final book = bookItems[index];
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
                        onFavorite: onFavoriteHandler,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
