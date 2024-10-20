class Tv {
  const Tv({
    required this.id,
    required this.name,
    required this.overview,
    required this.release,
    required this.image,
    required this.background,
    required this.rate,
  });

  final int id;
  final String name;
  final String overview;
  final String release;
  final String rate;
  final String image;
  final String background;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'release': release,
      'rate': rate,
      'image': image,
      'background': background,
    };
  }

  // Create a Tv object from JSON
  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      release: json['release'],
      rate: json['rate'],
      image: json['image'],
      background: json['background'],
    );
  }
}

Tv convertShowData(Map<String, dynamic> data) {
  return Tv(
    id: data['id'],
    name: data['original_name'],
    overview: data['overview'],
    release: data['first_air_date'],
    image: (data['poster_path'] != null)
        ? "http://image.tmdb.org/t/p/w500" + data['poster_path']
        : "https://i0.wp.com/rollingfilmfestival.com/wp-content/uploads/2021/01/no-poster-available.png?resize=1080%2C1526&ssl=1",
    background: (data['backdrop_path'] != null)
        ? "http://image.tmdb.org/t/p/w500" + data['backdrop_path']
        : "https://t3.ftcdn.net/jpg/05/88/70/78/360_F_588707867_pjpsqF5zUNMV1I2g8a3tQAYqinAxFkQp.jpg",
    rate: data['vote_average'].toStringAsFixed(1),
  );
}
