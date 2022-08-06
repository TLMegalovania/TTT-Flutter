import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.setName, required this.client})
      : super(key: key);

  final Function(String) setName;
  final HubConnection client;

  @override
  Widget build(BuildContext context) => Center(
        child: TextField(
          decoration: const InputDecoration(hintText: 'Enter your nickname...'),
          onSubmitted: (s) async {
            setName(s);
            //await Navigator.push(context, )
          },
        ),
      );
}
