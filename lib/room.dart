import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:ttt/type.dart';

class RoomPage extends StatelessWidget {
  const RoomPage(
      {Key? key,
      required this.client,
      required this.roomDetail,
      required this.id,
      required this.playerType,
      required this.board,
      required this.turn,
      required this.result})
      : super(key: key);

  final HubConnection client;
  final RoomDetail roomDetail;
  final int id;
  final PlayerType playerType;
  final List<PieceType> board;
  final PieceType turn;
  final WinType result;
  void startOrJoin() {
    if (playerType != PlayerType.Observer) {
      client.invoke("startGame");
    } else {
      client.invoke("joinRoom", args: [id]);
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          GridView.count(
            crossAxisCount: 4,
            children: [
              Text('${roomDetail.P1Ready ? '⚫' : ''} ${roomDetail.Player1}'),
              Text(id.toString()),
              Text('${roomDetail.P2Ready ? '⚪' : ''} ${roomDetail.Player2}'),
              if (!((roomDetail.P1Ready && roomDetail.P2Ready) ||
                  (playerType == PlayerType.Observer &&
                      roomDetail.Player1 != '' &&
                      roomDetail.Player2 != '')))
                ElevatedButton(
                    onPressed: startOrJoin,
                    child: Text(playerType == PlayerType.Observer
                        ? "Join"
                        : (playerType == PlayerType.Host
                                ? roomDetail.P1Ready
                                : playerType == PlayerType.Guest
                                    ? roomDetail.P2Ready
                                    : false)
                            ? "Unready"
                            : "Ready"))
            ],
          ),
          GridView.count(
            crossAxisCount: 5,
            children: List.generate(
                board.length,
                (index) => TextButton(
                      onPressed: !(roomDetail.P1Ready && roomDetail.P2Ready) ||
                              playerType != turn ||
                              board[index] != PieceType.Null
                          ? null
                          : () => client.invoke("go", args: [index]),
                      child: Text(board[index] == PieceType.Black
                          ? "⚫"
                          : board[index] == PieceType.White
                              ? "⚪"
                              : ""),
                    )),
          ),
          if (roomDetail.P1Ready && roomDetail.P2Ready)
            Text(
                'Now ${turn == PlayerType.Host ? "⚫" : turn == PlayerType.Guest ? "⚪" : ""}')
          else if (result != WinType.Null)
            Text(
                '${result == WinType.Black ? "⚫ " : result == WinType.White ? "⚪ " : ""}${result == WinType.Tie ? "Tie" : result == WinType.Flee ? "Flee" : "Win"}')
        ],
      );
}
