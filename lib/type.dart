// ignore_for_file: constant_identifier_names, non_constant_identifier_names

enum PlayerType {
  None,
  Host,
  Guest,
  Observer,
}

enum RoomState {
  Available,
  Full,
  InGame,
}

enum PieceType {
  Null,
  Black,
  White,
}

enum WinType {
  Null,
  Tie,
  Black,
  White,
  Flee,
}

class RoomInfo {
  late String Player1;
  late String Player2;
  late RoomState State;
}

class RoomDetail {
  late String Player1;
  late String Player2;
  late bool P1Ready;
  late bool P2Ready;
}

class BoardInfo {
  late List<PieceType> Board;
  late PieceType Turn;
  late WinType Result;
}
