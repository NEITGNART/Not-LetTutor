import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../route/route.dart';
import '../model/course.dart';

class ListViewCard extends StatelessWidget {
  const ListViewCard({
    super.key,
    required List<Course> results,
    required ScrollController scrollController,
    required this.listLevels,
  })  : _results = results,
        _scrollController = scrollController;

  final List<Course> _results;
  final ScrollController _scrollController;
  final Map<String, String> listLevels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _results.length,
      controller: _scrollController,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            context.pushNamed(AppRoute.courseDetail.name, params: {
              'courseId': _results[index].id,
            });
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             DetailCourseScreen(courseId: _results[index].id)));
          },
          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: _results[index].imageUrl,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _results[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 15),
                          child: Text(
                            _results[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[800]),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listLevels[_results[index].level] as String,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[800]),
                              ),
                              Text(
                                '${_results[index].topics.length}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
