import 'dart:io';

import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/features/authentication/presentation/controller/login_controller.dart';
import 'package:beatiful_ui/src/features/chat/presentation/chat_page.dart';
import 'package:beatiful_ui/src/features/language/presentation/my_language.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/widget/becom_tutor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../route/app_route.dart';
import '../../../constants.dart';
import '../../../../features/course/details/temp/models/sidebar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideBarScreen extends StatefulWidget {
  const SideBarScreen({
    super.key,
  });

  @override
  State<SideBarScreen> createState() => _SideBarScreenState();
}

class _SideBarScreenState extends State<SideBarScreen> {
  @override
  Widget build(BuildContext context) {
    LoginPageController c = Get.find();
    final boxdecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 2),
          blurRadius: 32.0,
        ),
      ],
    );

    const icon = Icon(
      Icons.arrow_forward_ios,
      size: 16,
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: kSidebarBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(34.0),
            ),
          ),
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 30.0,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  context.pushNamed(AppRoute.profile.name);
                },
                child: Row(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                          getAvatar(c.authUser.value?.avatar),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              c.authUser.value?.name ?? "",
                              style: kHeadlineLabelStyle.copyWith(
                                fontSize: 17.0,
                              ),
                            )),
                        const SizedBox(height: 5.0),
                        Obx(
                          () => Text(
                            Platform.isIOS
                                ? c.authUser.value?.email ?? ""
                                : handleOverflow(c.authUser.value?.email ?? ""),
                            style: kSearchPlaceholderStyle.copyWith(
                                fontSize: 13.0,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // build in widget that have in List

              // ListTile(
              //   leading: const Icon(Icons.history),
              //   title: const Text('History'),
              //   onTap: () {
              //     // context.goNamed(AppRoute.history.name);
              //   },
              // ),
              gapH64,
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.history.name);
                },
                child: Container(
                  decoration: boxdecoration,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.history),
                      gapW12,
                      Text(AppLocalizations.of(context)!.history,
                          style: kCalloutLabelStyle),
                      const Spacer(),
                      icon
                    ],
                  ),
                ),
              ),
              gapH12,
              GestureDetector(
                onTap: () {
                  Get.to(() => const MyLanguage());
                },
                child: Container(
                  decoration: boxdecoration,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.language),
                      gapW12,
                      Text(AppLocalizations.of(context)!.language,
                          style: kCalloutLabelStyle),
                      const Spacer(),
                      icon
                    ],
                  ),
                ),
              ),
              gapH12,
              // gapH12,
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //     decoration: boxdecoration,
              //     padding: const EdgeInsets.all(12),
              //     child: Row(
              //       children: [
              //         const Icon(Icons.history),
              //         gapW12,
              //         Text('History', style: kCalloutLabelStyle),
              //         const Spacer(),
              //         icon
              //       ],
              //     ),
              //   ),
              // ),
              // const Spacer(),
              gapH64,
              GestureDetector(
                onTap: () async {
                  await launchUrl(
                      Uri.parse('https://www.facebook.com/reggieFlying/'));
                },
                child: Container(
                  decoration: boxdecoration,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.people),
                      gapW12,
                      Text(AppLocalizations.of(context)!.ourWebsite,
                          style: kCalloutLabelStyle),
                      const Spacer(),
                      icon
                    ],
                  ),
                ),
              ),
              gapH12,
              GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse('https://app.lettutor.com'));
                },
                child: Container(
                  decoration: boxdecoration,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.web),
                      gapW12,
                      Text(AppLocalizations.of(context)!.webVersion,
                          style: kCalloutLabelStyle),
                      const Spacer(),
                      icon
                    ],
                  ),
                ),
              ),
              gapH12,
              GestureDetector(
                onTap: () {
                  Get.to(() => const BecomeTutor());
                },
                child: Container(
                  decoration: boxdecoration,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.app_registration),
                      gapW12,
                      Text(AppLocalizations.of(context)!.registerTeacher,
                          style: kCalloutLabelStyle),
                      const Spacer(),
                      icon
                    ],
                  ),
                ),
              ),
              gapH64,
              gapH64,
              GestureDetector(
                onTap: () async {
                  context.goNamed(AppRoute.signOut.name);
                  LoginPageController c = Get.find();
                  await c.logout();
                },
                child: Container(
                  decoration: boxdecoration.copyWith(
                    color: Colors.blue.shade200,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.exit_to_app),
                      gapW12,
                      Text(AppLocalizations.of(context)!.logout,
                          style: kCalloutLabelStyle),
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

class SideBarRow extends StatelessWidget {
  final SidebarItem sideBarItem;
  const SideBarRow({
    super.key,
    required this.sideBarItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50.0,
          height: 50.0,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: sideBarItem.background,
          ),
          child: sideBarItem.icon,
        ),
        const SizedBox(width: 10.0),
        Text(
          sideBarItem.title,
          style: kCalloutLabelStyle,
        )
      ],
    );
  }
}
