// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../features/tutor/presentation/tutor_home_page.dart';
import '../constants.dart';

class GroupButton extends StatelessWidget {
  final List<String> titles;
  const GroupButton({
    Key? key,
    required this.titles,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ...titles.map(
          (title) => Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                  onPressed: () {
                    // change blue color
                    logger.i('You just selected $title');
                  },
                  // border for button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 228, 230, 235),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(title,
                      style: kSearchTextStyle.copyWith(
                          color: const Color.fromARGB(255, 100, 100, 100))))),
        ),
      ],
    );
  }
}
