import 'package:cinemagic/Api.dart';
import 'package:cinemagic/Models/Tv.dart';
import 'package:cinemagic/Models/movie.dart';
import 'package:cinemagic/Screens/MovieInfo.dart';
import 'package:flutter/material.dart';

class viewer extends StatefulWidget {
  const viewer({super.key, required this.type});

  final String type;

  @override
  State<viewer> createState() => _ViewerState();
}

class _ViewerState extends State<viewer> {
  List<dynamic> items = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  void _loadMoreTopMovies() async {
    setState(() {
      _isLoading = true;
    });

    var result = (widget.type == "Movie")
        ? await tmdb.v3.movies.getTopRated(page: _currentPage)
        : await tmdb.v3.tv.getTopRated();

    setState(() {
      if (widget.type == "Movie") {
        items.addAll(
            result["results"].map((movie) => convertData(movie)).toList());
      } else {
        items.addAll(
            result["results"].map((show) => convertShowData(show)).toList());
      }
      _currentPage++;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMoreTopMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreTopMovies();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top-Rated Movies"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 60,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
        ),
        controller: _scrollController,
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index < items.length) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => Movieinfo(
                      item: items[index],
                      type: widget.type,
                    ),
                  ),
                );
              },
              child: Image.network(
                items[index].image,
                height: 150,
                fit: BoxFit.fitHeight,
              ),
            );
          } else if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
