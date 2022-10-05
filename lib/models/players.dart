class Players {
  final String gamingName;
  final String socketId;
  final double points;
  final String playerType;

  Players({
    required this.gamingName,
    required this.socketId,
    required this.points,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'gamingName': gamingName,
      'socketId': socketId,
      'points': points,
      'playerType': playerType,
    };
  }

  factory Players.fromMap(Map<String, dynamic> map) {
    return Players(
      gamingName: map['gamingName'] ?? '',
      socketId: map['socketId'] ?? '',
      points: map['points'] ?? '0.0',
      playerType: map['playerType'] ?? '',
    );
  }

  Players copyWith({
    String? gamingName,
    String? socketId,
    double? points,
    String? playerType,
  }) {
    return Players(
      gamingName: gamingName ?? this.gamingName,
      socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
