class Actor {
  const Actor({required this.name, required this.image});

  final String name;
  final String image;
}

Actor convertActor(Map<String, dynamic> data) {
  return Actor(
    name: data['original_name'],
    image: (data['profile_path'] != null)
        ? "http://image.tmdb.org/t/p/w500" + data['profile_path']
        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6Q82WISxpWPp5dHBTWHypFOZbRTvc0ST0xQ&s",
  );
}
