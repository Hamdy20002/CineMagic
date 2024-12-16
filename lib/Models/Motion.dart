import 'package:cinemagic/Models/data.dart';

class Motion {
  const Motion({
    required this.id,
    required this.type,
    required this.name,
    required this.overview,
    required this.release,
    required this.image,
    required this.background,
    required this.rate,
  });

  final int id;
  final main_types type;
  final String name;
  final String overview;
  final String release;
  final String rate;
  final String image;
  final String background;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'name': name,
      'overview': overview,
      'release': release,
      'rate': rate,
      'image': image,
      'background': background,
    };
  }

  factory Motion.fromJson(Map<String, dynamic> json) {
    return Motion(
      id: json['id'],
      type: main_types.values
          .firstWhere((e) => e.toString().split('.').last == json['type']),
      name: json['name'],
      overview: json['overview'],
      release: json['release'],
      rate: json['rate'],
      image: json['image'],
      background: json['background'],
    );
  }
}

Motion converter(Map<String, dynamic> data, main_types type) {
  return Motion(
    id: data['id'],
    type: type,
    name: (type == main_types.movie) ? data['title'] : data['original_name'],
    overview: data['overview'],
    release: (type == main_types.movie)
        ? data['release_date']
        : data['first_air_date'],
    image: (data['poster_path'] != null)
        ? "http://image.tmdb.org/t/p/w500" + data['poster_path']
        : "https://www.movienewsletters.net/photos/000000H1.jpg",
    background: (data['backdrop_path'] != null)
        ? "http://image.tmdb.org/t/p/w500" + data['backdrop_path']
        : "https://st4.depositphotos.com/17828278/24401/v/450/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg",
    rate: data['vote_average'].toStringAsFixed(1),
  );
}
