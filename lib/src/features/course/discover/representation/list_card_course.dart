import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../route/app_route.dart';
import '../model/course.dart';

class ListViewCard extends StatelessWidget {
  const ListViewCard({
    super.key,
    required List<Course> results,
    required this.listLevels,
  }) : _results = results;

  final List<Course> _results;
  final Map<String, String> listLevels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _results.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: MyCourseCard(
            results: _results[index], listLevels: listLevels, index: index),
      ),
    );
  }
}

class MyCourseCard extends StatelessWidget {
  const MyCourseCard({
    super.key,
    required Course results,
    required this.listLevels,
    required this.index,
  }) : _results = results;

  final Course _results;
  final Map<String, String> listLevels;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoute.detailCourse.name,
            params: {
              'courseId': _results.id,
            },
            extra: _results);
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
                  imageUrl: _results.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _results.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 15),
                      child: Text(
                        _results.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            listLevels[_results.level] as String,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[800]),
                          ),
                          Text(
                            '${_results.topics.length}',
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
    );
  }
}
