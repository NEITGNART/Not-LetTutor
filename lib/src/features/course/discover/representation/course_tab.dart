import 'dart:async';
import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/common/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../data/repository.dart';
import '../model/course.dart';
import '../model/course_category.dart';
import 'grid_card_course.dart';
import 'list_card_course.dart';

class CourseTab extends StatefulWidget {
  const CourseTab({Key? key}) : super(key: key);
  @override
  State<CourseTab> createState() => _CourseTabState();
}

final listLevels = {
  "0": "Any level",
  "1": "Beginner",
  "2": "High Beginner",
  "3": "Pre-Intermediate",
  "4": "Intermediate",
  "5": "Upper-Intermediate",
  "6": "Advanced",
  "7": "Proficiency"
};

class _CourseTabState extends State<CourseTab> {
  List<Course> _results = [];
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String category = "";
  String search = "";
  bool isLoading = true;
  bool isLoadingCategories = true;
  bool isLoadMore = false;
  int page = 1;
  int perPage = 10;
  late ScrollController _scrollController;
  List<CourseCategory> categories = [];
  CourseCategory? currentCategory;

  void getCategories() async {
    try {
      final response = await CourseFunctions.getAllCourseCategories();
      if (response != null && mounted) {
        setState(() {
          categories = response;
          isLoadingCategories = false;
        });
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  List<Widget> _generateChips(
      List<CourseCategory> categories, VoidCallback? cb) {
    return categories
        .map(
          (chip) => GestureDetector(
            onTap: () {
              currentCategory = chip;
              pickCategory(chip);
              cb?.call();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 5, right: 8),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: chip.id == category ? Colors.blue[50] : Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: chip.id == category
                        ? Colors.blue[100] as Color
                        : Colors.grey[400] as Color),
              ),
              child: Text(
                chip.title,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      chip.id == category ? Colors.blue[400] : Colors.grey[600],
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  void pickCategory(CourseCategory chip) {
    if (category == chip.id) {
      setState(() {
        category = "";
        currentCategory = null;
        _results = [];
        page = 1;
        isLoading = true;
      });
    } else {
      setState(() {
        category = chip.id;
        currentCategory = chip;
        _results = [];
        page = 1;
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.removeListener(loadMore);
    super.dispose();
  }

  void getListCourse(int page, int size) async {
    try {
      final courses =
          await CourseFunctions.getListCourseWithPagination(page, size);
      setState(() {
        _results.addAll(courses!);
        isLoading = false;
      });
      // List<Course>? response =
      //     await CourseFunctions.getListCourseWithPagination(page, size,
      //         categoryId: category, q: search);
      // if (response != null && mounted) {
      //   setState(() {
      //     _results.addAll(response);
      //     isLoading = false;
      //   });
      // }
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Không thể tải thêm nữa'),
      );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void loadMore() async {
    if (_scrollController.position.extentAfter < page * perPage) {
      setState(() {
        isLoadMore = true;
        page++;
      });

      try {
        // List<Course>? response =
        //     await CourseFunctions.getListCourseWithPagination(page, perPage,
        //         categoryId: category, q: search);
        // if (response != null && mounted) {
        //   setState(() {
        //     _results.addAll(response);
        //     isLoadMore = false;
        //   });
        // }
      } catch (e) {
        final snackBar = SnackBar(
          content: Text(e.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      getListCourse(page, perPage);
    }
    if (isLoadingCategories) {
      getCategories();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          child: TextField(
            style: TextStyle(fontSize: 12, color: Colors.grey[900]),
            controller: _controller,
            onChanged: (value) async {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  search = value;
                  _results = [];
                  page = 1;
                  isLoading = true;
                });
              });
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(13),
                  child: SvgPicture.asset(
                    "asset/svg/ic_search.svg",
                    color: Colors.grey[600],
                  ),
                ),
                contentPadding: const EdgeInsets.only(left: 5, right: 5),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                hintText: 'Search Course'),
          ),
        ),
        gapH12,
        // isLoadingCategories
        //     ? const Center(
        //         child: CircularProgressIndicator(),
        //       ) :
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(
              height: 30,
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  showCategoryModel(context);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Select level"),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  showCategoryModel(context);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Categories"),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  showCategoryModel(context);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Sort by Level"),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ],
        ),
        gapH12,
        Wrap(
          runSpacing: 10,
          children: [
            // MyInputChip(label: 'Any Level', onDeleted: () {}),
            // gapW12,
            // MyInputChip(label: 'Level increasing', onDeleted: () {}),
            // gapW12,
            currentCategory != null && currentCategory!.id != ""
                ? MyInputChip(
                    label: currentCategory!.title,
                    onDeleted: () {
                      pickCategory(currentCategory!);
                    })
                : Container(),
          ],
        ),
        gapH12,
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: _results.isEmpty ? const EmptyData() : getCourseCard()),
        if (isLoadMore)
          const SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  void showCategoryModel(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        barrierColor: const Color(0x00ffffff),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              alignment: Alignment.center,
              child: Wrap(
                children: [
                  ..._generateChips(categories, () {
                    Navigator.pop(context);
                  })
                ],
              ));
        });
  }

  void showLevelModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        barrierColor: const Color(0x00ffffff),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              alignment: Alignment.center,
              child: Wrap(
                children: [
                  ..._generateChips(categories, () {
                    Navigator.pop(context);
                  })
                ],
              ));
        });
  }

  void showSortLevelModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        barrierColor: const Color(0x00ffffff),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              alignment: Alignment.center,
              child: Wrap(
                children: [
                  ..._generateChips(categories, () {
                    Navigator.pop(context);
                  })
                ],
              ));
        });
  }

  Widget getCourseCard() {
    if (MediaQuery.of(context).size.width < Breakpoint.tablet) {
      return ListViewCard(
          results: _results,
          scrollController: _scrollController,
          listLevels: listLevels);
    } else if (MediaQuery.of(context).size.width < Breakpoint.desktop) {
      return GridViewCard(
          results: _results,
          scrollController: _scrollController,
          listLevels: listLevels);
    }
    return GridViewCard(
        results: _results,
        scrollController: _scrollController,
        listLevels: listLevels,
        gridNum: 3);
  }
}

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "asset/svg/ic_notfound.svg",
            width: 200,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              "No data",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}

class MyInputChip extends StatefulWidget {
  final String label;
  final Function() onDeleted;
  const MyInputChip({super.key, required this.label, required this.onDeleted});
  @override
  _MyInputChipState createState() => _MyInputChipState();
}

class _MyInputChipState extends State<MyInputChip> {
  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(widget.label),
      deleteIcon: const Icon(Icons.cancel),
      onDeleted: () {
        widget.onDeleted();
      },
    );
  }
}
