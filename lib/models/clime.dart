class Clime {
  final int number;
  final String name;
  final String arabicName;
  final String bounds;
  final String description;

  Clime({
    required this.number,
    required this.name,
    required this.arabicName,
    required this.bounds,
    required this.description,
  });

  factory Clime.fromJson(Map<String, dynamic> json) {
    return Clime(
      number: json['number'],
      name: json['name'],
      arabicName: json['arabicName'],
      bounds: json['bounds'],
      description: json['description'],
    );
  }
}