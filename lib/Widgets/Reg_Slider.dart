import 'package:cinemagic/Models/data.dart';
import 'package:cinemagic/Screens/info.dart';
import 'package:cinemagic/Screens/view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class regSlider extends StatelessWidget {
  const regSlider({
    super.key,
    required this.items,
    required this.title,
    required this.type,
  });

  final List<dynamic> items;
  final String title;
  final main_types type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            if (type != main_types.actor)
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => viewAll(type: type, title: title),
                    ),
                  );
                },
                child: Text("View All"),
              ),
          ],
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 250.h,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (ctx, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: SizedBox(
                height: 180.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (type != main_types.actor) {
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
                        height: 140.h,
                        width: 100.w,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
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
