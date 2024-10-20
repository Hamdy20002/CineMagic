import 'package:cinemagic/Models/actor.dart';
import 'package:cinemagic/Screens/MovieInfo.dart';
import 'package:flutter/material.dart';

class Smallslider extends StatelessWidget {
  const Smallslider({
    super.key,
    this.MovieList,
    this.ActorList,
    required this.type,
  });

  final List<dynamic>? MovieList;
  final List<Actor>? ActorList;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (type == "Actor") ? ActorList!.length : MovieList!.length,
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              (type == "Actor")
                  ? ClipOval(
                      child: Image.network(
                        ActorList![index].image,
                        fit: BoxFit.fitHeight,
                        height: 100,
                        width: 100,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => Movieinfo(
                              item: MovieList![index],
                              type: type,
                            ),
                          ),
                        );
                      },
                      child: Image.network(
                        MovieList![index].image,
                        fit: BoxFit.fitHeight,
                        height: 100,
                        width: 100,
                      ),
                    ),
              const SizedBox(height: 10),
              SizedBox(
                width: 80,
                child: Text(
                  (type == "Actor")
                      ? ActorList![index].name
                      : MovieList![index].name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
