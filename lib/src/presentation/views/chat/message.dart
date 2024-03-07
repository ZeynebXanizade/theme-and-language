import 'package:flutter/material.dart';
import 'package:reservation/src/presentation/views/chat/usermesssage.dart';

String isim = "Kullanici1";

// ignore: must_be_immutable
class MessagePage extends StatelessWidget {
 const MessagePage({super.key, required this.message});
 final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserMessage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.primary),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        child: Text(
                          isim[0],
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        isim,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
