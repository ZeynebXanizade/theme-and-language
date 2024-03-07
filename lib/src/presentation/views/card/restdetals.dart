import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/presentation/widgets/button/button.dart';
import 'package:reservation/src/presentation/widgets/welcome_page/welcome_page_container.dart';

class DetalsRest extends StatefulWidget {
  const DetalsRest(
      {super.key,
      required this.name,
      required this.address,
      required this.time,
      required this.image});
  final String name;
  final String address;
  final String time;
  final String image;

  @override
  State<DetalsRest> createState() => _DetalsRestState();
}

class _DetalsRestState extends State<DetalsRest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Positioned.fill(
              // ignore: sort_child_properties_last
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
              bottom: MediaQuery.of(context).size.height * 0.5,
            ),
            Positioned(
                top: MediaQuery.of(context).size.width * 0.6,
                child: MyContainer(
                    color: Theme.of(context).colorScheme.background,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(70),
                        child: Wrap(
                          // Dikey ortalama
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .hours
                                      .toString(),
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  widget.time,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .address
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  Text(
                                    widget.address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )))
          ],
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyButton(
                text: Text(
                  AppLocalizations.of(context)!.contact.toString(),
                ),
                onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                // İkon tıklandığında yapılacak işlemler
              },
            ),
          ],
        ),
      ),
    );
  }
}
