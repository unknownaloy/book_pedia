import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/utilities/global.dart';
import 'package:flutter/material.dart';

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
                    "Hi, ${Global.bookUser.toString()}",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text("Favorites", style: Theme.of(context).textTheme.bodyText1,),
                leading: const Icon(Icons.favorite, color: kTextColor,),
              ),
              const Divider(),
            ],
          ),
          Column(
            children: [
              const Divider(),
              ListTile(
                onTap: () {},
                title:  Text("Logout", style: Theme.of(context).textTheme.bodyText1,),
                leading: const Icon(Icons.power_settings_new, color: kTextColor,),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
