import 'package:beatiful_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../model/language.dart';

class MyLanguage extends StatefulWidget {
  const MyLanguage({super.key});
  @override
  State<MyLanguage> createState() => _MyLanguageState();
}

class _MyLanguageState extends State<MyLanguage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Language> get languages => [
        Language(
          'Tiếng Việt',
          'asset/svg/vn-flag.svg',
          'vi',
          'VN',
        ),
        Language(
          'English',
          'asset/svg/united-kingdom-flag.svg',
          'en',
          'US',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              // align left
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: SvgPicture.asset(
                        languages[index].iconUrl,
                        width: 30,
                        height: 30,
                      ),
                      title: Text(languages[index].name),
                      onTap: () {
                        LocalController c = Get.find();
                        final locale = Locale(languages[index].code,
                            languages[index].countryCode);
                        c.changeLocale(locale);
                      },
                    );
                  },
                  itemCount: 2),
            ),
          ],
        ),
      ),
    );
  }
}
