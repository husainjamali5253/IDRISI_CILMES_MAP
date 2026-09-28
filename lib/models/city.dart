class City {
  final String id;
  final String name;
  final String arabicName;
  final int clime;
  final String history;
  final String idrisiHint;
  final double modernLat;
  final double modernLng;
  final double? px;
  final double? py;

  City({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.clime,
    required this.history,
    required this.idrisiHint,
    required this.modernLat,
    required this.modernLng,
    this.px,
    this.py,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      arabicName: json['arabicName'],
      clime: json['clime'],
      history: json['history'],
      idrisiHint: json['idrisiHint'],
      modernLat: (json['modernLat'] as num).toDouble(),
      modernLng: (json['modernLng'] as num).toDouble(),
      px: json['px'] != null ? (json['px'] as num).toDouble() : null,
      py: json['py'] != null ? (json['py'] as num).toDouble() : null,
    );
  }
}