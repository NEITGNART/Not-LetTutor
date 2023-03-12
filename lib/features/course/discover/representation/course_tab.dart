import 'dart:async';
import 'package:beatiful_ui/common/app_sizes.dart';
import 'package:beatiful_ui/common/breakpoint.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/repository.dart';
import '../model/course.dart';
import '../model/course_category.dart';

class CourseTab extends StatefulWidget {
  const CourseTab({Key? key}) : super(key: key);
  @override
  State<CourseTab> createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  List<Course> _results = [];
  final TextEditingController _controller = TextEditingController();
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
    final response = await CourseFunctions.getAllCourseCategories();
    if (mounted) {
      setState(() {
        categories = response!;
        isLoadingCategories = false;
      });
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
    List<Course>? response = await CourseFunctions.getListCourseWithPagination(
        page, size,
        categoryId: category, q: search);
    if (mounted) {
      setState(() {
        _results.addAll(response!);
        isLoading = false;
      });
    }
  }

  void loadMore() async {
    if (_scrollController.position.extentAfter < page * perPage) {
      setState(() {
        isLoadMore = true;
        page++;
      });

      try {
        List<Course>? response =
            await CourseFunctions.getListCourseWithPagination(page, perPage,
                categoryId: category, q: search);
        if (mounted) {
          setState(() {
            _results.addAll(response!);
            isLoadMore = false;
          });
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Không thể tải thêm nữa'),
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
                  showModal(context);
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
                  showModal(context);
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
                  showModal(context);
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
        Row(
          children: [
            MyInputChip(label: 'Any Level', onDeleted: () {}),
            gapW12,
            MyInputChip(label: 'Level increasing', onDeleted: () {}),
            gapW12,
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
                child: _results.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                      )
                    : getCourseCard()),
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

  void showModal(context) {
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

class GridViewCard extends StatelessWidget {
  const GridViewCard({
    super.key,
    required List<Course> results,
    required ScrollController scrollController,
    required this.listLevels,
    this.gridNum = 2,
  })  : _results = results,
        _scrollController = scrollController;

  final List<Course> _results;
  final ScrollController _scrollController;
  final Map<String, String> listLevels;
  final int gridNum;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _results.length,
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridNum,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) =>
          CourseCard(results: _results, listLevels: listLevels, index: index),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required List<Course> results,
    required this.listLevels,
    required this.index,
  }) : _results = results;

  final List<Course> _results;
  final Map<String, String> listLevels;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CourseDetailScreen(
        //             courseId: _results[index].id)));
      },
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: _results[index].imageUrl,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _results[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 15),
                        child: Text(
                          _results[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              listLevels[_results[index].level] as String,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[800]),
                            ),
                            Text(
                              '${_results[index].topics.length}',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard({
    super.key,
    required List<Course> results,
    required ScrollController scrollController,
    required this.listLevels,
  })  : _results = results,
        _scrollController = scrollController;

  final List<Course> _results;
  final ScrollController _scrollController;
  final Map<String, String> listLevels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _results.length,
      controller: _scrollController,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => CourseDetailScreen(
            //             courseId: _results[index].id)));
          },
          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: _results[index].imageUrl,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _results[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 15),
                          child: Text(
                            _results[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[800]),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listLevels[_results[index].level] as String,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[800]),
                              ),
                              Text(
                                '${_results[index].topics.length}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
