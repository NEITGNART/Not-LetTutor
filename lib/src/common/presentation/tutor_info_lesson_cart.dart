// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class TutorInfo {
  final String name;
  final String avatarUrl;
  final String iconUrl;
  final String country;
  TutorInfo({
    required this.name,
    required this.avatarUrl,
    required this.iconUrl,
    required this.country,
  });
}

class TutorInfoLessonCard extends StatelessWidget {
  const TutorInfoLessonCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Row(
        children: [
          const CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4')),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  'John Pham',
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
                  Text('Viet Nam', style: kSearchPlaceholderStyle),
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
                  label: Text('Direct Message',
                      style:
                          kSearchPlaceholderStyle.copyWith(color: Colors.blue)))
            ],
          ),
        ],
      ),
    );
  }
}
