import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reservation/src/presentation/views/chat/message.dart';
import 'package:reservation/src/presentation/views/more/app_about.dart';
import 'package:reservation/src/presentation/views/more/more.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/presentation/views/tapcontroller/restadd.dart';
import 'package:reservation/src/presentation/widgets/home/homewidget.dart';

String message = "";

class TabControllers extends StatefulWidget {
  const TabControllers({
    super.key,
  });
  @override
  State<TabControllers> createState() => _TabControllersState();
}

class _TabControllersState extends State<TabControllers> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            const HomePage(),
            // ignore: avoid_unnecessary_containers
            const AppAbout(),
            // ignore: avoid_unnecessary_containers
            MessagePage(message: message),
            MoreWidget(
              userId: user?.uid ?? "",
            ),
          ],
        ),
        extendBody: true,
//////////////////////////TABBAR//////////////////////////////////////////////
        floatingActionButton: FloatingActionButton(
            splashColor:
                Theme.of(context).floatingActionButtonTheme.splashColor,
            backgroundColor:
                Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const RestaurantAdd()));
            },
            // ignore: sort_child_properties_last
            child: Icon(
              Icons.add,
              color: Theme.of(context).floatingActionButtonTheme.splashColor,
            ),
            shape: const CircleBorder(eccentricity: 1.0)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          child: TabBar(
              dividerHeight: 0,
              unselectedLabelColor:
                  Theme.of(context).tabBarTheme.unselectedLabelColor,
              labelColor: Theme.of(context).tabBarTheme.labelColor,
              indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
              tabs: [
                Tab(
                  text: AppLocalizations.of(context)!.home.toString(),
                  icon: const Icon(Icons.home_filled),
                ),
                Tab(
                    text: AppLocalizations.of(context)!.restaurant.toString(),
                    icon: const Icon(Icons.restaurant)),
                Tab(
                    text: AppLocalizations.of(context)!.message.toString(),
                    icon: const Icon(Icons.message)),
                Tab(
                    text: AppLocalizations.of(context)!.more.toString(),
                    icon: const Icon(Icons.more_horiz)),
              ]),
        ),
      ),
    );
  }
}
