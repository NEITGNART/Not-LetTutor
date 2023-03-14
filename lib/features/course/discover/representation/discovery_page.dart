import 'package:beatiful_ui/common/app_sizes.dart';
import 'package:beatiful_ui/features/course/discover/representation/banner.dart';
import 'package:flutter/material.dart';

import 'book_tab.dart';
import 'course_tab.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const DiscoveryBanner(),
                    gapH12,
                    gapH12,
                    SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          unselectedLabelColor: Colors.grey,
                          labelPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          labelColor: Colors.blue,
                          controller: tabController,
                          isScrollable: true,
                          // indicator: const CircleTabIndicator(
                          //   color: Color.fromARGB(255, 16, 136, 235),
                          // ),
                          tabs: const [
                            Tab(text: 'Course'),
                            Tab(text: 'E-book'),
                            Tab(text: 'Interactive Ebook'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: tabController,
                children: const [
                  CourseTab(),
                  BookTab(),
                  Text('')
                  // InteractiveTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
