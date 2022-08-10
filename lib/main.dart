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
    client.on("gotBoard", (list) {
      var b = list?[0] as BoardInfo;
      setState(() {
        board = b.Board;
        turn = b.Turn == PieceType.Black
            ? PlayerType.Host
            : b.Turn == PieceType.White
                ? PlayerType.Guest
                : PlayerType.None;
        result = b.Result;
      });
    });
    client.on("gotRoom", (list) {
      var detail = list?[0] as RoomDetail;
      setState(() => roomDetail = detail);
    });
    client.on("joinedRoom", (list) {
      var t = list?[0] as PlayerType;
      setState(() => playerType = t);
    });
  }
  final HubConnection client = HubConnectionBuilder()
      .withUrl('url',
          transportType: HttpTransportType.WebSockets,
          options: HttpConnectionOptions(skipNegotiation: true))
      .build();
  String nickname = '';
  void setNickname(String nickname) => setState(() => this.nickname = nickname);
  List<RoomInfo> roomInfos = [];
  List<PieceType> board = [];
  PlayerType turn = PlayerType.None;
  WinType result = WinType.Null;
  int id = -1;
  PlayerType playerType = PlayerType.None;
  RoomDetail roomDetail = RoomDetail();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Image.asset('images/favicon.ico'),
          title: Text(widget.title),
        ),
        body: HomePage(
          setName: setNickname,
          client: client,
          roomInfos: roomInfos,
          board: board,
          id: id,
          playerType: playerType,
          turn: turn,
          result: result,
          roomDetail: roomDetail,
        ),
      );
}
