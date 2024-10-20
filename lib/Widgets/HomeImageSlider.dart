import 'package:flutter/material.dart';

import 'package:cinemagic/Screens/MovieInfo.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Imageslider extends StatefulWidget {
  const Imageslider({super.key, required this.items, required this.type});

  final List<dynamic> items;
  final String type;

  @override
  State<Imageslider> createState() => _ImagesliderState();
}

class _ImagesliderState extends State<Imageslider> {
  late int _CurrentIndex;

  @override
  void initState() {
    super.initState();
    _CurrentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: widget.items[_CurrentIndex].id,
              child: Image.network(
                widget.items[_CurrentIndex].background,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CarouselSlider.builder(
              itemCount: widget.items.length,
              itemBuilder: (ctx, index, indx2) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => Movieinfo(
                          item: widget.items[index],
                          type: widget.type,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    widget.items[index].image,
                    scale: 5,
                  ),
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _CurrentIndex = index;
                  });
                },
                viewportFraction: 0.3,
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
