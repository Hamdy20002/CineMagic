class Actor {
  const Actor({required this.name, required this.image});

  final String name;
  final String image;
}

Actor actorConverter(Map<String, dynamic> data) {
  return Actor(
    name: data['original_name'],
    image: (data['profile_path'] != null)
        ? "http://image.tmdb.org/t/p/w500" + data['profile_path']
        : "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg",
  );
}
