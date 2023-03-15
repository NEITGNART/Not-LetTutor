// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants.dart';

class GroupButtonColor extends StatelessWidget {
  final List<String> titles;
  const GroupButtonColor({
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
              child: TextButton(
                  // onPressed: null,
                  onPressed: () {},
                  // border for button
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: const Color.fromARGB(255, 221, 234, 255),
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(title,
                      style: kSearchTextStyle.copyWith(
                          color: const Color.fromARGB(255, 0, 113, 240))))),
        ),
      ],
    );
  }
}
