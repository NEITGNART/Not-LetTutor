import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/constants.dart';
import '../../../../common/presentation/blockquote.dart';

class DiscoveryBanner extends StatelessWidget {
  const DiscoveryBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width >= 400
        ? const SizedBox(
            // width: double.maxFinite,
            // child: Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[
            //     SizedBox(
            //       width: 120,
            //       height: 120,
            //       child: SvgPicture.network(
            //           'https://sandbox.app.lettutor.com/static/media/history.1e097d10.svg'),
            //     ),
            //     gapW16,
            //     const Expanded(
            //       child: SearchWithIcon(),
            //     ),
            //   ],
            // ),
            )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120,
                height: 120,
                child: SvgPicture.network(
                    'https://sandbox.app.lettutor.com/static/media/history.1e097d10.svg'),
              ),
              gapW16,
              const SearchWithIcon(),
            ],
          );
  }
}

class SearchWithIcon extends StatelessWidget {
  const SearchWithIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Text('Discovery Course', style: kTitle1Style),
        gapH12,
        BlockQuote(
          blockColor: Colors.grey,
          child: Text(
              'LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.'),
        ),
      ],
    );
  }
}

class SearchCourse extends StatefulWidget {
  const SearchCourse({
    super.key,
  });

  @override
  State<SearchCourse> createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
  String _searchText = "";
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          focusColor: Colors.blue,
          // radius: 10,
          labelText: 'Course',
          suffixIcon: _searchText.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                    });
                  },
                )
              : null),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
