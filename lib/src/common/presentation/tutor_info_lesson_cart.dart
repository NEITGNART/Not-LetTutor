// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/tutor/model/tutor.dart';
import '../app_sizes.dart';
import '../constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorInfoLessonCard extends StatelessWidget {
  final Tutor tutor;
  const TutorInfoLessonCard({
    super.key,
    required this.tutor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          color: scheduleReviewBackground,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              getAvatar(tutor.avatar),
            ),
          ),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  tutor.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: kHeadlineLabelStyle,
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  SvgPicture.network(
                    'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg',
                    width: 20,
                  ),
                  const SizedBox(width: 5.0),
                  Text(getCountry(tutor.country),
                      style: kSearchPlaceholderStyle.copyWith(
                        color: Colors.black,
                      )),
                  const SizedBox(width: 5.0),
                ],
              ),
              const SizedBox(height: 5.0),
              ElevatedButton.icon(
                  // set elevation to 0
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.chat, color: Colors.blue),
                  label: Text(AppLocalizations.of(context)!.directMessage,
                      style:
                          kSearchPlaceholderStyle.copyWith(color: Colors.blue)))
            ],
          ),
        ],
      ),
    );
  }
}
