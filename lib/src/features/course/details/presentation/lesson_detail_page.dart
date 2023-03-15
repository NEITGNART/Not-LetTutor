// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../../../../common/app_sizes.dart';
import '../../../../common/breakpoint.dart';
import '../../../../common/constants.dart';
import '../../../../route/app_route.dart';
import '../../../tutor/presentation/tutor_home_page.dart';

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: buildResponsive(context));
  }

  Widget buildResponsive(BuildContext context) {
    if (MediaQuery.of(context).size.width < Breakpoint.tablet) {
      logger.i("Mobile");
      return const MobileDetailLessonScreen();
    }
    return const DesktopDetailLessonScreen();

    // return Platform.isAndroid || Platform.isIOS
    //     ? const MobileDetailLessonScreen()
    //     : const DesktopDetailLessonScreen();
  }
}

class MobileDetailLessonScreen extends StatefulWidget {
  const MobileDetailLessonScreen({super.key});

  @override
  State<MobileDetailLessonScreen> createState() =>
      _MobileDetailLessonScreenState();
}

class _MobileDetailLessonScreenState extends State<MobileDetailLessonScreen> {
  String currentLessonLink = "";
  PdfViewerController? controller;
  int currentLessonIndex = -1;

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

  var src =
      'https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e';
  var data = 'Life in the Internet Age';
  var data2 =
      'By default, the thumb will fade in and out as the child scroll view scrolls. When thumbVisibility is true, the scrollbar thumb will remain visible without the fade animation. This requires that the ScrollController associated with the Scrollable widget is provided to controller, or that the PrimaryScrollController is being used by that Scrollable widget.';

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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  child: TopicInfo(
                    src: src,
                    data: data,
                    data2: data2,
                    currentLessonLink: currentLessonLink,
                    currentLessonIndex: currentLessonIndex,
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: TopicList(
                                onTap: (String link, int index) {
                                  context.goNamed(
                                    AppRoute.topicPdf.name,
                                    params: {
                                      'link': link,
                                    },
                                  );
                                },
                                urls: urls,
                                currentLessonIndex: currentLessonIndex),
                          ),
                        ],
                      ),
                    ),
                  ),
                  gapW32,
                ],
              ),
            ),
          )
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
  var data2 =
      'By default, the thumb will fade in and out as the child scroll view scrolls. When thumbVisibility is true, the scrollbar thumb will remain visible without the fade animation. This requires that the ScrollController associated with the Scrollable widget is provided to controller, or that the PrimaryScrollController is being used by that Scrollable widget.';

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

  // Widget buildResponsive(BuildContext context) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       if (constraints.maxWidth < Breakpoint.tablet) {
  //         return Container();
  //       } else {
  //         return ;
  //       }
  //     },
  //   );
  // }

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
                        children: [
                          TopicInfo(
                            src: src,
                            data: data,
                            data2: data2,
                            currentLessonLink: currentLessonLink,
                            currentLessonIndex: currentLessonIndex,
                          ),
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
                        ? Container(
                            child: Row(
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
                            ),
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
  const TopicInfo(
      {Key? key,
      required this.src,
      required this.data,
      required this.data2,
      required this.currentLessonLink,
      required this.currentLessonIndex})
      : super(key: key);

  final String src;
  final String data;
  final String data2;
  final String currentLessonLink;
  final int currentLessonIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image.network(
                src,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Text(data, style: kCardTitleStyle.copyWith(color: Colors.black)),
              gapH12,
              Text(
                data2,
                style: kSearchTextStyle,
              ),
            ],
          ),
          gapH12,
        ],
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
