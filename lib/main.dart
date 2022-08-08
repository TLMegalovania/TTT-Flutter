import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:ttt/home.dart';
import 'package:ttt/type.dart';

void main() {
  runApp(MaterialApp(
    title: 'Tic Tac Toe',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomeApp(title: 'Tic Tac Toe'),
  ));
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  _HomeAppState() {
    client.on('gotRooms',
        (args) => setState(() => roomInfos = args![0] as List<RoomInfo>));
  }
  final HubConnection client = HubConnectionBuilder()
      .withUrl('url',
          transportType: HttpTransportType.WebSockets,
          options: HttpConnectionOptions(skipNegotiation: true))
      .build();
  String nickname = '';
  void setNickname(String nickname) => setState(() => this.nickname = nickname);
  List<RoomInfo> roomInfos = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Image.asset('images/favicon.ico'),
          title: Text(widget.title),
        ),
        body: HomePage(setName: setNickname, client: client, roomInfos: roomInfos,),
      );
}
