import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:ttt/type.dart';

import 'hall.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.setName,
      required this.client,
      required this.roomInfos})
      : super(key: key);

  final Function(String) setName;
  final HubConnection client;
  final List<RoomInfo> roomInfos;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  bool connecting = false;

  void setConnecting(bool val) => setState(() => connecting = val);

  @override
  Widget build(BuildContext context) => Center(
        child: TextField(
          decoration: const InputDecoration(hintText: 'Enter your nickname...'),
          enabled: !connecting,
          onSubmitted: (s) async {
            try {
              setConnecting(true);
              s = s == '' ? 'Noob' : s;
              await widget.client.start();
              await widget.client.invoke('login', args: [s]);
              widget.setName(s);
              if (!mounted) return;
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HallPage(client: widget.client, roomInfos: widget.roomInfos,)));
            } finally {
              setConnecting(false);
            }
          },
        ),
      );
}
