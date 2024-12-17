import 'package:cinemagic/Models/data.dart';
import 'package:cinemagic/Screens/info.dart';
import 'package:flutter/material.dart';
import 'package:cinemagic/Models/Motion.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class viewAll extends StatefulWidget {
  const viewAll({super.key, required this.type, required this.title});

  final main_types type;
  final String title;

  @override
  State<viewAll> createState() => _viewAllState();
}

class _viewAllState extends State<viewAll> {
  final List<Motion> _items = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _loadData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMoreData) {
        _loadData();
      }
    });
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Motion> newItems = [];
      if (widget.title[0] == 'T') {
        newItems = await loadTopRated(widget.type, _currentPage);
      } else {
        newItems = await loadPopular(widget.type, _currentPage);
      }

      setState(() {
        if (newItems.isEmpty) {
          _hasMoreData = false;
        } else {
          _items.addAll(newItems);
          _currentPage++;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load data: ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: (_isLoading && _items.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: _items.length + (_hasMoreData ? 1 : 0),
                itemBuilder: (ctx, index) {
                  if (index == _items.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return InkWell(
                    key: ValueKey(_items[index].id),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => motionInfo(
                            item: _items[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.surface,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              _items[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            _items[index].name,
                            style: TextStyle(fontSize: 14.sp),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
