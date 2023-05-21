import 'package:flutter/material.dart';

import 'book_tab.dart';
import 'course_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  // const DiscoveryBanner(),
                  SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        physics: const NeverScrollableScrollPhysics(),
                        unselectedLabelColor: Colors.grey,
                        labelPadding:
                            const EdgeInsets.only(left: 20, right: 20),
                        labelColor: Colors.blue,
                        controller: tabController,
                        isScrollable: true,
                        // indicator: const CircleTabIndicator(
                        //   color: Color.fromARGB(255, 16, 136, 235),
                        // ),
                        tabs: [
                          Tab(text: AppLocalizations.of(context)!.course),
                          const Tab(text: 'E-book'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: const [
                      CourseTab(),
                      BookTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
