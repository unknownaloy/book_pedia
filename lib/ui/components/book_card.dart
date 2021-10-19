import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String? imageUrl;
  final String bookTitle;
  final String? bookAuthor;
  final double? bookRating;
  final String? category;
  final Object heroTag;
  final VoidCallback onTap;

  const BookCard({
    Key? key,
    this.imageUrl,
    required this.bookTitle,
    this.bookAuthor,
    this.bookRating,
    this.category,
    required this.heroTag,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
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
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Hero(
                    tag: heroTag,
                    child: Image.network(
                      imageUrl ?? "https://www.w3schools.com/w3images/avatar6.png",
                      fit: BoxFit.contain,
                      width: 104.0,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : const CircularProgressIndicator();
                      },
                      errorBuilder: (context, child, progress) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bookAuthor != null
                          ? Text(
                              "by $bookAuthor",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: kHintColor),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        bookTitle,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: kAccentColor,
                            size: 18.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "${bookRating ?? 0.0}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: kHintColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      category != null
                          ? Chip(
                              backgroundColor: kHighLightColor,
                              label: Text(category!),
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                              // labelPadding: const EdgeInsets.symmetric(vertical: 2.0),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
