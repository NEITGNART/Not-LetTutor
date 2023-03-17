// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beatiful_ui/src/common/constants.dart';
import 'package:beatiful_ui/src/common/presentation/my_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../../common/presentation/app_bar.dart';
import '../../../common/presentation/up_coming_lesson.dart';
import '../../../route/app_route.dart';
import '../model/tutor_profile.dart';

var fruits = ['Apple', 'Banana', 'Mango', 'Orange'];

// All
// English for kids
// English for Business
// Conversational
// STARTERS
// MOVERS
// FLYERS
// KET
// PET
// IELTS
// TOEFL
// TOEIC
var allSkillFilter = [
  'All',
  'English for kids',
  'English for Business',
  'Conversational',
  'STARTERS',
  'MOVERS',
  'FLYERS',
  'KET',
  'PET',
  'IELTS',
  'TOEFL',
  'TOEIC'
];

var tutorSkillFilter = [
  'All',
  'English for kids',
  'English for Business',
  'Conversational',
  'STARTERS',
  'MOVERS',
];

var logger = Logger();

class TutorHomePage extends StatelessWidget {
  const TutorHomePage({super.key});

  static final List<TutorProfile> tutors = [
    TutorProfile(
      avatarUrl:
          'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4',
      flagUrl:
          'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg',
      country: 'Viet Nam',
      introduce:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching',
      hasFavorite: true,
      specialities: allSkillFilter,
    ),
    TutorProfile(
        avatarUrl:
            'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4',
        flagUrl:
            'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg',
        country: 'Viet Nam',
        introduce:
            'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching',
        hasFavorite: true,
        specialities: []),
    TutorProfile(
        avatarUrl:
            'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4',
        flagUrl:
            'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg',
        country: 'Viet Nam',
        introduce:
            'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching',
        hasFavorite: true,
        specialities: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MyAppBar(),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const UpComingLesson(),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyFilter(),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          Text('Recommended Tutors', style: kTitle1Style),
                          const SizedBox(
                            height: 10,
                          ),
                          ...tutors.map(
                            (e) => MyTutorCardReview(tutor: e),
                          ),
                          // Expanded(
                          //   child: Container(
                          //     margin: const EdgeInsets.only(top: 24),
                          //     child: ListView.builder(
                          //       itemCount: 2,
                          //       itemBuilder:
                          //           (BuildContext context, int index) =>
                          //               ListTile(
                          //         title: Text("List Item ${index + 1}"),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTutorCardReview extends StatelessWidget {
  const MyTutorCardReview({
    Key? key,
    required this.tutor,
  }) : super(key: key);
  final TutorProfile tutor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          AppRoute.tutorDetail.name,
          params: {
            'id': '12312',
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(tutor.avatarUrl)),
                  const SizedBox(width: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'John Pham',
                        style: kHeadlineLabelStyle,
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          SvgPicture.network(
                            tutor.flagUrl,
                            width: 20,
                          ),
                          const SizedBox(width: 5.0),
                          Text(tutor.country, style: kSearchPlaceholderStyle),
                          const SizedBox(width: 5.0),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          ...List.generate(
                              5,
                              (i) => const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 15,
                                  )),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: tutor.hasFavorite
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.blue,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              children: <Widget>[
                ...?tutor.specialities?.map(
                  (title) => Padding(
                      padding: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                      child: ElevatedButton(
                          onPressed: () {
                            // change blue color
                            logger.i('You just selected $title');
                          },
                          // border for button
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 221, 234, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(title,
                              style: kSearchTextStyle.copyWith(
                                  color: const Color.fromARGB(
                                      255, 0, 113, 240))))),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(tutor.introduce, style: kSearchPlaceholderStyle),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      // foreroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        // border
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.blue,
                      size: 15,
                    ),
                    label: Text('Book',
                        style: kCalloutLabelStyle.copyWith(
                            color: Colors.blue, fontSize: 13)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// // -------------------------------------------------

// const mockResults = <AppProfile>[
//   AppProfile('Stock Man', 'stock@man.com',
//       'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
//   AppProfile('Paul', 'paul@google.com',
//       'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
//   AppProfile('Fred', 'fred@google.com',
//       'https://media.istockphoto.com/photos/feeling-great-about-my-corporate-choices-picture-id507296326'),
//   AppProfile('Bera', 'bera@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('John', 'john@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Thomas', 'thomas@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Norbert', 'norbert@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Marina', 'marina@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
// ];

// class AppProfile {
//   final String name;
//   final String email;
//   final String imageUrl;

//   const AppProfile(this.name, this.email, this.imageUrl);

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is AppProfile &&
//           runtimeType == other.runtimeType &&
//           name == other.name;

//   @override
//   int get hashCode => name.hashCode;

//   @override
//   String toString() {
//     return 'Profile{$name}';
//   }
// }
