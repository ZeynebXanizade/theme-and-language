import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserMessage extends StatefulWidget {
  // ignore: use_super_parameters
  const UserMessage({Key? key}) : super(key: key);

  @override
  State<UserMessage> createState() => _UserMessageState();
}

class _UserMessageState extends State<UserMessage> {
  TextEditingController t1 = TextEditingController();
  List<MessageParametrs> messageParams = [];

  messageSent(String messages) {
    setState(() {
      MessageParametrs messageParametrs = MessageParametrs(
        message: messages,
      );
      messageParams.insert(0, messageParametrs);
      t1.clear();
    });
  }

  Widget metinAlani() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(child: TextField(controller: t1, onSubmitted: messageSent)),
          IconButton(onPressed: () => messageSent(t1.text), icon: const Icon(Icons.send) , color: Theme.of(context).colorScheme.primary, )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.profil.toString()),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (_, index) => messageParams[index],
              itemCount: messageParams.length,
            ),
          ),
          metinAlani()
        ],
      ),
    );
  }
}

String isim = "Kullanici1";

class MessageParametrs extends StatelessWidget {
  const MessageParametrs({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              isim[0],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                isim,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
               Text(
            message,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
            ],
          ),
        ],
      ),
    );
  }
}
