import 'package:cinemagic/Widgets/smallSlider.dart';
import 'package:flutter/material.dart';

class Favitems extends StatelessWidget {
  const Favitems({
    super.key,
    required this.type,
    required this.items,
  });

  final List<dynamic> items;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Watch-Later $type:  "),
        const SizedBox(height: 10),
        Smallslider(
          type: type,
          MovieList: items,
        )
      ],
    );
  }
}
