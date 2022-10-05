class Players {
  final String gamingName;
  final String socketID;
  final double points;
  final String playerType;

  Players({
    required this.gamingName,
    required this.socketID,
    required this.points,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'gamingName': gamingName,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
    };
  }

  factory Players.fromMap(Map<String, dynamic> map) {
    return Players(
      gamingName: map['gamingName'] ?? '',
      socketID: map['socketID'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      playerType: map['playerType'] ?? '',
    );
  }

  Players copyWith({
    String? gamingName,
    String? socketID,
    double? points,
    String? playerType,
  }) {
    return Players(
      gamingName: gamingName ?? this.gamingName,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
