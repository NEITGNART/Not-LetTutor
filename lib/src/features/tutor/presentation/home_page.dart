import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:flutter/material.dart';

import '../../../common_widget/sidebar_screen.dart';
import '../../chat/presentation/chat_page.dart';
import '../../course/discover/representation/discovery_page.dart';
import '../../schedule/upcomming/presentation/schedule_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [
        TutorHomePage(),
        DiscoverPage(),
        ChatPage(),
        SchedulePage(),
        SideBarScreen(),
      ][_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          NavigationDestination(
              icon: const Icon(
                Icons.search,
                color: Colors.blue,
              ),
              label: AppLocalizations.of(context)!.discovery),
          NavigationDestination(
              icon: const Icon(
                Icons.message_outlined,
                color: Colors.blue,
              ),
              label: AppLocalizations.of(context)!.messages),
          NavigationDestination(
              icon: const Icon(
                Icons.schedule,
                color: Colors.blue,
              ),
              label: AppLocalizations.of(context)!.upcomming),
          NavigationDestination(
            icon: const Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            label: AppLocalizations.of(context)!.setting,
          ),
        ],
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
