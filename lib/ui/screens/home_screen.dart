import 'package:book_pedia/services/books_service.dart';
import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookService = BooksService();
    bookService.fetchFamousBooks();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.exploreThousandsOfBooksOnTheGo,
                style: Theme.of(context).textTheme.headline2,
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     prefixIcon: const Icon(Icons.add),
              //     hintText: "Search for books...",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(50.0),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(
              //         color: kAccentColor,
              //         width: 2.0,
              //       ),
              //       borderRadius: BorderRadius.circular(50.0),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 24.0,
              ),
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
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 32.0, right: 16.0,),
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                    contentPadding:
                       const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
                    hintText: AppLocalizations.of(context)!.searchForBooks,
                    border: InputBorder.none,
                    focusColor: kAccentColor,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
