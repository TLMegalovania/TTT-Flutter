import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:ttt/type.dart';

class HallPage extends StatelessWidget {
  const HallPage({Key? key, required this.client, required this.roomInfos})
      : super(key: key);

  final HubConnection client;
  final List<RoomInfo> roomInfos;

  @override
  Widget build(BuildContext context) => DataTable(
        columns: const [
          DataColumn(label: Text('Room'), numeric: true),
          DataColumn(label: Text('Player1')),
          DataColumn(label: Text('Player2')),
          DataColumn(label: Text('State'))
        ],
        rows: roomInfos
            .map((e) => DataRow(
                  cells: [
                    DataCell(Text(roomInfos.indexOf(e).toString())),
                    DataCell(Text(e.Player1)),
                    DataCell(Text(e.Player2)),
                    DataCell(Text(e.State.name))
                  ],
                  onSelectChanged: (value) async {
                    if (value == true) {
                      await client
                          .invoke('joinRoom', args: [roomInfos.indexOf(e)]);
                      // await Navigator.push(context, );
                    }
                  },
                ))
            .toList(),
        showCheckboxColumn: false,
      );
}
