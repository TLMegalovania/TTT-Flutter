import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:ttt/type.dart';

import 'hall.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.setName,
      required this.client,
      required this.roomInfos,
      required this.roomDetail,
      required this.id,
      required this.playerType,
      required this.board,
      required this.turn,
      required this.result})
      : super(key: key);

  final Function(String) setName;
  final HubConnection client;
  final List<RoomInfo> roomInfos;
  final RoomDetail roomDetail;
  final int id;
  final PlayerType playerType;
  final List<PieceType> board;
  final PlayerType turn;
  final WinType result;

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
                      builder: (_) => HallPage(
                            client: widget.client,
                            roomInfos: widget.roomInfos,
                            board: widget.board,
                            id: widget.id,
                            playerType: widget.playerType,
                            turn: widget.turn,
                            result: widget.result,
                            roomDetail: widget.roomDetail,
                          )));
            } finally {
              setConnecting(false);
            }
          },
        ),
      );
}
