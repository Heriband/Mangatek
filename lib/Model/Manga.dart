class Manga {
  final String name;
  final int volume;
  final int popularity;

  Manga({ required this.name, required this.volume, required this.popularity});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'popularity' : popularity,
      'volume': volume,
    };
  }
}

