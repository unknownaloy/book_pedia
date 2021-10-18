import 'package:book_pedia/models/book_model/book_volume_info.dart';
import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/ui/components/book_item_description.dart';
import 'package:book_pedia/ui/components/book_item_detail.dart';
import 'package:book_pedia/ui/components/book_item_rating.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final BookVolumeInfo bookVolumeInfo;

  const DetailsScreen({Key? key, required this.bookVolumeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                      bookVolumeInfo.title,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    background: Image.network(
                      bookVolumeInfo.bookImages?.mainThumbnail ??
                          "https://www.w3schools.com/w3images/avatar6.png",
                      fit: BoxFit.cover,
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
                bookVolumeInfo.authors != null
                    ? DetailItem(
                        label: "Authors",
                        bodyText: bookVolumeInfo.authors!.join(", "),
                      )
                    : const SizedBox.shrink(),

                // const Divider(),

                /// Subtitle
                bookVolumeInfo.subtitle != null
                    ? DetailItem(
                        label: "Subtitle", bodyText: bookVolumeInfo.subtitle!)
                    : const SizedBox.shrink(),

                // const Divider(),

                /// Category
                bookVolumeInfo.categories != null
                    ? DetailItem(
                        label: "Category",
                        bodyText: bookVolumeInfo.categories!.join(", "),
                      )
                    : const SizedBox.shrink(),

                // const Divider(),

                /// Ratings
                bookVolumeInfo.rating != null
                    ? BookItemRating(label: "Rating", rating: bookVolumeInfo.rating!)
                    : const SizedBox.shrink(),
                
                /// Pages
                bookVolumeInfo.pages != null
                    ? DetailItem(
                        label: "Pages", bodyText: "${bookVolumeInfo.pages}")
                    : const SizedBox.shrink(),
                
                const SizedBox(
                  height: 24.0,
                ),

                /// Book description
                bookVolumeInfo.description != null
                    ? BookItemDescription(
                        description: bookVolumeInfo.description!)
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.favorite_border,
            color: kTextColor,
          ),
        ),
      ),
    );
  }
}
