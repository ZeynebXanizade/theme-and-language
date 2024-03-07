import 'package:flutter/material.dart';
import 'package:reservation/src/data/restaurant_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/presentation/views/card/restdetals.dart';

// ignore: use_key_in_widget_constructors
class RestaurantListWidget extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: firestoreService.getRestaurantsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Hata: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> restaurantsDataList =
                snapshot.data ?? [];

            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 2.0,
              ),
              itemCount: restaurantsDataList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> restaurantData =
                    restaurantsDataList[index];
                List<dynamic> image = restaurantData['image'] ?? [];
            
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalsRest(
                          name: restaurantData['name'] ?? '',
                          image: image.isNotEmpty ? image[0] : '',
                          time: restaurantData['time'] ?? '',
                          address: restaurantData['address'] ?? '',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Theme.of(context).colorScheme.onBackground,
                    elevation: 3,
                    child: Column(
                      children: [
                        if (image.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              image[0],
                              width: double.infinity,
                              height:
                                  MediaQuery.of(context).size.height * 0.1,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          Container(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                restaurantData['name'] ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .restaurant
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            restaurantData['address'] ?? '',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
