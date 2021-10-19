import 'package:book_pedia/bloc/authentication/authentication_bloc.dart';
import 'package:book_pedia/bloc/authentication/authentication_event.dart';
import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/ui/screens/favorite_screen.dart';
import 'package:book_pedia/utilities/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: kAccentColor),
                child: Center(
                  child: Text(
                    "${AppLocalizations.of(context)!.hi}, ${Global.bookUser.toString()}",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                      const FavoriteScreen(),
                    ),
                  );
                },
                title: Text(
                  AppLocalizations.of(context)!.favorites,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                leading: const Icon(
                  Icons.favorite,
                  color: kTextColor,
                ),
              ),
              const Divider(),
            ],
          ),

          /// Logout section
          Column(
            children: [
              const Divider(),
              ListTile(
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
                title: Text(
                  AppLocalizations.of(context)!.logout,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                leading: const Icon(
                  Icons.power_settings_new,
                  color: kTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
