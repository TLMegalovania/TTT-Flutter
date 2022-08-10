import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:ttt/room.dart';
import 'package:ttt/type.dart';

class HallPage extends StatelessWidget {
  const HallPage(
      {Key? key,
      required this.client,
      required this.roomInfos,
      required this.roomDetail,
      required this.id,
      required this.playerType,
      required this.board,
      required this.turn,
      required this.result})
      : super(key: key);

  final HubConnection client;
  final List<RoomInfo> roomInfos;
  final RoomDetail roomDetail;
  final int id;
  final PlayerType playerType;
  final List<PieceType> board;
  final PlayerType turn;
  final WinType result;

  @override
  Widget build(BuildContext context) => DataTable(
        columns: const [
          DataColumn(label: Text('Room'), numeric: true),
          DataColumn(label: Text('Player1')),
          DataColumn(label: Text('Player2')),
          DataColumn(label: Text('State'))
        ],
        rows: List.generate(roomInfos.length, (index) {
          var e = roomInfos[index];
          return DataRow(
            cells: [
              DataCell(Text(index.toString())),
              DataCell(Text(e.Player1)),
              DataCell(Text(e.Player2)),
              DataCell(Text(e.State.name))
            ],
            onSelectChanged: (value) {
              if (value == true) {
                client.invoke('joinRoom', args: [index]).then((_) =>
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RoomPage(
                                client: client,
                                roomDetail: roomDetail,
                                id: id,
                                playerType: playerType,
                                board: board,
                                turn: turn,
                                result: result))));
              }
            },
          );
        }),
        showCheckboxColumn: false,
      );
}
