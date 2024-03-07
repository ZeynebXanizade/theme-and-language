
import 'package:flutter/material.dart';
import 'package:reservation/src/presentation/widgets/card/cards.dart';
import 'package:reservation/src/presentation/widgets/home/search.dart';
import 'package:reservation/src/presentation/widgets/home/text.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: SingleChildScrollView(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Column(
              children: [
          /////////////////////////////Hi text//////////////////////////////////////
               const TextWid(),
          ////////////////////////////////search //////////////////////////
                const SearchRes(),
           ////////////////////////////////cards//////////////////////////             
                RestaurantListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


