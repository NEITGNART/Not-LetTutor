// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../../../../common/app_sizes.dart';
import '../../../../common/breakpoint.dart';
import '../../../../common/constants.dart';
import '../../../../route/app_route.dart';
import '../../../tutor/presentation/tutor_home_page.dart';
import '../../discover/model/course.dart';
import '../../discover/model/course_topic.dart';

class DetailLessonPage extends StatelessWidget {
  const DetailLessonPage({Key? key, required this.course}) : super(key: key);
  final Course course;

  @override
  Widget build(BuildContext context) {
    return MobileDetailLessonScreen(course: course);
  }

  Widget buildResponsive(BuildContext context) {
    if (MediaQuery.of(context).size.width < Breakpoint.tablet) {
      return MobileDetailLessonScreen(course: course);
    }
    return const DesktopDetailLessonScreen();

    // return Platform.isAndroid || Platform.isIOS
    //     ? const MobileDetailLessonScreen()
    //     : const DesktopDetailLessonScreen();
  }
}

class MobileDetailLessonScreen extends StatelessWidget {
  String currentLessonLink = "";
  PdfViewerController? controller;

  int currentLessonIndex = -1;

  MobileDetailLessonScreen({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // appBar

          SliverAppBar(
            backgroundColor: Colors.white,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Lesson',
                style: kTitle1Style.copyWith(color: Colors.blue),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  TopicInfo(
                    img: course.imageUrl,
                    title: course.name,
                    description: course.description,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [Text('List Topics', style: kTitle1Style)],
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
      ),
    );
  }
}

class MyPdfViewer extends StatelessWidget {
  final String link;
  const MyPdfViewer({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF'),
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder<File>(
                future: DefaultCacheManager().getSingleFile(link),
                builder: (context, snapshot) => snapshot.hasData
                    ? Expanded(
                        child: PdfViewer.openFile(
                          snapshot.data!.path,
                          // params: const PdfViewerParams(
                          //     pageNumber: 1),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ));
  }
}

class DesktopDetailLessonScreen extends StatefulWidget {
  const DesktopDetailLessonScreen({
    super.key,
  });

  @override
  State<DesktopDetailLessonScreen> createState() =>
      _DesktopDetailLessonScreenState();
}

class _DesktopDetailLessonScreenState extends State<DesktopDetailLessonScreen> {
  String currentLessonLink = "";
  PdfViewerController? controller;
  int currentLessonIndex = -1;

  var src =
      'https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e';
  var data = 'Life in the Internet Age';
  var data2 = "Let's discuss how technology is changing the way we live";

  static const List<String> urls = [
    "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSocial Media.pdf",
    "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileInternet Privacy.pdf",
    "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileLive Streaming.pdf",
    "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileCoding.pdf",
    "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSocial Media.pdf",
    "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileInternet Privacy.pdf",
    "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileLive Streaming.pdf",
    "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileCoding.pdf",
  ];

  void changeLesson(lessonLink, lessonIndex) {
    if (lessonLink.isNotEmpty && currentLessonIndex != lessonIndex) {
      setState(() {
        currentLessonIndex = lessonIndex;
        currentLessonLink = lessonLink;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopicInfo(
                            img: src,
                            title: data,
                            description: data2,
                          ),
                          gapH12,
                          Text('List Topics', style: kTitle1Style),
                          gapH12,
                          Expanded(
                            child: TopicList(
                                onTap: changeLesson,
                                urls: urls,
                                currentLessonIndex: currentLessonIndex),
                          )
                        ],
                      ),
                    ),
                  ),
                  gapW32,
                  Flexible(
                    flex: 2,
                    child: (currentLessonLink.isNotEmpty)
                        ? Row(
                            children: [
                              if (currentLessonLink.isNotEmpty) ...{
                                FutureBuilder<File>(
                                  future: DefaultCacheManager()
                                      .getSingleFile(currentLessonLink),
                                  builder: (context, snapshot) => snapshot
                                          .hasData
                                      ? Expanded(
                                          child: PdfViewer.openFile(
                                            snapshot.data!.path,
                                            // params: const PdfViewerParams(
                                            //     pageNumber: 1),
                                          ),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator()),
                                )
                              } else
                                const Placeholder(),
                            ],
                          )
                        : Center(
                            child: Image.network(
                                "https://lettutor.com/assets/images/hero_img.png"),
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopicInfo extends StatelessWidget {
  const TopicInfo({
    Key? key,
    required this.img,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String img;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        //             background: const LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     Color(0xFF00AEFF),
        //     Color(0xFF0076FF),
        //   ],
        // )
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00AEFF).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
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
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: getAvatar(img),
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title,
                    style: kCardTitleStyle.copyWith(color: Colors.black)),
                gapH12,
                Text(
                  // gap between two lines
                  description,
                  style: kCalloutLabelStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          gapH12,
        ],
      ),
    );
  }
}

class TopicSliverList extends StatelessWidget {
  const TopicSliverList({
    super.key,
    required this.onTap,
    required this.urls,
    required this.currentLessonIndex,
  });

  final Function onTap;
  final List<String> urls;
  final int currentLessonIndex;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Material(
            child: InkWell(
              highlightColor: Colors.blue.withOpacity(0.4),
              splashColor: Colors.green.withOpacity(0.5),
              onTap: () {
                onTap(urls[index], index);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: currentLessonIndex != index
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF00AEFF),
                              Color(0xFF0076FF),
                            ],
                          )
                        : const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFFD504F),
                              Color(0xFFFF8181),
                            ],
                          ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                        'The title',
                        style: kCardTitleStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        childCount: urls.length,
      ),
    );
  }
}

class TopicList extends StatelessWidget {
  const TopicList({
    super.key,
    required this.onTap,
    required this.urls,
    required this.currentLessonIndex,
  });

  final Function onTap;
  final List<String> urls;
  final int currentLessonIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Material(
          child: InkWell(
            highlightColor: Colors.blue.withOpacity(0.4),
            splashColor: Colors.green.withOpacity(0.5),
            onTap: () {
              onTap(urls[index], index);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: currentLessonIndex != index
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF00AEFF),
                            Color(0xFF0076FF),
                          ],
                        )
                      : const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFD504F),
                            Color(0xFFFF8181),
                          ],
                        ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                      'The title',
                      style: kCardTitleStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: urls.length,
    );
  }
}
