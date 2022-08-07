import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';

class HallPage extends StatefulWidget {
  const HallPage({Key? key, required this.client}) : super(key: key);

  final HubConnection client;

  @override
  State<StatefulWidget> createState() => _HallState();
}

class _HallState extends State<HallPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
