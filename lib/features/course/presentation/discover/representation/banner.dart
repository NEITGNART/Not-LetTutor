import 'package:beatiful_ui/common/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../common/constants.dart';

class DiscoveryBanner extends StatelessWidget {
  const DiscoveryBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width >= 400
        ? SizedBox(
            width: double.maxFinite,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 120,
                  height: 120,
                  child: SvgPicture.network(
                      'https://sandbox.app.lettutor.com/static/media/history.1e097d10.svg'),
                ),
                gapW16,
                const Expanded(
                  child: SearchWithIcon(),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Discovery Course', style: kTitle1Style),
        gapH12,
        // create
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: SizedBox(
                height: 50,
                child: SearchCourse(),
              ),
            ),
            Container(
              height: 50,
              decoration: const BoxDecoration(
                // border color for right, left, bottom, top, except top left
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                  ),
                  right: BorderSide(
                    color: Colors.grey,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {}),
            )
          ],
        )
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
            borderRadius: BorderRadius.all(Radius.zero),
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
