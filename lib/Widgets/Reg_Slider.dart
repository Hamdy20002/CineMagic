import 'package:cinemagic/Models/Motion.dart';
import 'package:cinemagic/Screens/info.dart';
import 'package:flutter/material.dart';

class regSlider extends StatelessWidget {
  const regSlider({
    super.key,
    required this.items,
    required this.title,
  });

  final List<dynamic> items;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 250,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (ctx, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (title != "Cast :") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => motionInfo(
                                item: items[index],
                              ),
                            ),
                          );
                        }
                      },
                      child: Image.network(
                        items[index].image,
                        fit: BoxFit.fill,
                        height: 140,
                        width: 100,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        items[index].name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
