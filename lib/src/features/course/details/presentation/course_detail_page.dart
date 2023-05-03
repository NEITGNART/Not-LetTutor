// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/common/breakpoint.dart';
import 'package:beatiful_ui/src/common/constants.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../route/app_route.dart';
import '../../discover/model/course.dart';
import '../../discover/model/course_topic.dart';
import '../../discover/representation/course_tab.dart';

class DetailCourseScreen extends StatefulWidget implements PreferredSizeWidget {
  final String courseId;
  final Course course;
  const DetailCourseScreen(
      {super.key, required this.courseId, required this.course});

  @override
  State<DetailCourseScreen> createState() => _DetailCourseScreenState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DetailCourseScreenState extends State<DetailCourseScreen> {
  double _scrollOffset = 0;
  bool _showTitle = true;

  void _handleScroll(double scrollOffset) {
    setState(() {
      _scrollOffset = scrollOffset;
      _showTitle = scrollOffset > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: widget.preferredSize,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: _scrollOffset > 0 ? Colors.blue : Colors.transparent,
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _showTitle ? 1.0 : 0.0,
                    child: Text(
                      'Detail Course',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _scrollOffset > 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            _handleScroll(scrollNotification.metrics.pixels);
          }
          return true;
        },
        child: buildReponsiveLayout(
          context,
        ),
      ),
    );
  }

  Widget buildReponsiveLayout(
    BuildContext context,
  ) {
    if (MediaQuery.of(context).size.width <= Breakpoint.tablet) {
      return MobileDetailScreen(course: widget.course);
    } else {
      return CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: DetailCourseCard(course: widget.course)),
                    gapW32,
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          OverviewInfo(course: widget.course),
                          gapH16,
                          // create listviewbuilder wrap inside expanded
                          // to make it scrollable
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: widget.course.topics.length,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          // purple
                          Color(0xFF5B86E5),
                          Color(0xFF36D1DC),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$index.',
                            style: kSubtitleStyle.copyWith(
                              // gradient green
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    // yellow
                                    Color(0xFFFFBF69),
                                    Color(0xFFFF9F1C),
                                  ],
                                ).createShader(
                                  const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                                ),
                            )),
                        Text(
                          widget.course.topics[index].name,
                          style: kTitle2Style.copyWith(
                            fontSize: 18,
                            // gradient orange
                            foreground: Paint()
                              ..shader = const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  // bright orange
                                  Color(0xFFFF9F1C),
                                  Color(0xFFFFBF69),
                                ],
                              ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          ),
        ],
      );
    }
  }
}

class MobileDetailScreen extends StatelessWidget {
  final Course course;
  const MobileDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                DetailCourseCard(
                  course: course,
                ),
                gapH32,
                OverviewInfo(course: course),
                gapH16,
                Text(
                  'List topics',
                  style: kTitle1Style,
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final CourseTopic topic = course.topics[index];
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    AppRoute.topicPdf.name,
                    params: {
                      'link': topic.nameFile,
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF00AEFF),
                            Color(0xFF0076FF),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$index.',
                            style: kCardSubtitleStyle,
                          ),
                          gapH12,
                          Text(
                            topic.name,
                            style: kCardTitleStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: course.topics.length,
          ),
        ),
      ],
    );
  }
}

class OverviewInfo extends StatelessWidget {
  final Course course;
  const OverviewInfo({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Overview',
          style: kTitle1Style,
        ),
        gapH16,
        OverviewText(
          title: 'What you\'ll learn',
          subtitle: course.reason,
        ),
        gapH16,
        OverviewText(
          title: 'What will you be able to do',
          subtitle: course.purpose,
        ),
        gapH16,
        Text(
          'Level Experience',
          style: kTitle1Style,
        ),
        gapH16,
        Row(
          children: [
            const Icon(Icons.people_alt_outlined),
            gapW4,
            Text(
              listLevels[course.level] ?? "",
              style: kBodyLabelStyle,
            ),
          ],
        ),
        gapH16,
        Text(
          'Course Length',
          style: kTitle1Style,
        ),
        gapH16,
        Row(
          children: [
            const Icon(Icons.topic_outlined),
            gapW4,
            Text(
              '${course.topics.length} Topics',
              style: kBodyLabelStyle,
            ),
          ],
        ),
        gapH16,
        Text(
          'Course Length',
          style: kTitle1Style,
        ),
        gapH16,
        Row(
          children: [
            const Icon(Icons.people_alt_outlined),
            gapW4,
            Text(
              'Keegan',
              style: kBodyLabelStyle,
            ),
          ],
        ),
      ],
    );
  }
}

class OverviewText extends StatelessWidget {
  final String title;
  final String subtitle;
  const OverviewText({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.question_mark_rounded, color: Colors.red),
            Expanded(
              child: Text(
                title,
                style: kTitle1Style.copyWith(
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
        gapH4,
        Container(
          padding: const EdgeInsets.only(left: 35),
          child: Text(
            subtitle,
            style: kSearchTextStyle,
          ),
        ),
      ],
    );
  }
}

class DetailCourseCard extends StatelessWidget {
  final Course course;
  const DetailCourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        // color border
        border: const Border.fromBorderSide(
          BorderSide(color: Colors.grey, width: 1),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // color: course.background.colors[0].withOpacity(0.4),
            // color: Colors.black.withOpacity(0.3),
            // blue
            color: const Color(0xFF0F4C75).withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            // color: course.background.colors[1].withOpacity(0.4),
            // color: Colors.black.withOpacity(0.3),
            // blue
            color: const Color(0xFF0F4C75).withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: getAvatar(course.imageUrl),
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(course.name,
                    style: kCardTitleStyle.copyWith(color: Colors.black)),
                gapH12,
                Text(
                  course.description,
                  style: kSubtitleStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                gapH12,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .goNamed(AppRoute.courseDiscovery.name, params: {
                            'courseId': '5e0e8b212ac750e7dc9886ac',
                          });
                        },
                        child: const Text('Discovery'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
