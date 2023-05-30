import 'dart:async';

import 'package:beatiful_ui/src/features/schedule/upcomming/presentation/schedule_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/breakpoint.dart';
import '../data/repository.dart';
import '../model/Ebook.dart';
import '../model/course_category.dart';

class BookTab extends StatefulWidget {
  const BookTab({Key? key}) : super(key: key);

  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  List<Ebook> _results = [];
  final TextEditingController _controller = TextEditingController();
  final listLevels = {
    '0': 'Any level',
    '1': 'Beginner',
    '2': 'High Beginner',
    '3': 'Pre-Intermediate',
    '4': 'Intermediate',
    '5': 'Upper-Intermediate',
    '6': 'Advanced',
    '7': 'Proficiency'
  };
  Timer? _debounce;
  String category = '';
  String search = '';
  bool isLoading = true;
  bool isLoadingCategories = true;
  bool isLoadMore = false;
  int page = 1;
  int perPage = 10;
  late ScrollController _scrollController;
  List<CourseCategory> categories = [];

  void getCategories() async {
    final response = await CourseFunctions.getAllCourseCategories();
    if (response != null && mounted) {
      setState(() {
        categories = response;
        isLoadingCategories = false;
      });
    }
  }

  List<Widget> _generateChips(List<CourseCategory> categories) {
    return categories
        .map(
          (chip) => GestureDetector(
            onTap: () {
              if (category == chip.id) {
                setState(() {
                  category = '';
                  _results = [];
                  page = 1;
                  isLoading = true;
                });
              } else {
                setState(() {
                  category = chip.id;
                  _results = [];
                  page = 1;
                  isLoading = true;
                });
              }
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

  void getListEbook(int page, int size) async {
    final response = await EbookFunctions.getListEbookWithPagination(page, size,
        categoryId: category, q: search);
    if (response != null && mounted) {
      setState(() {
        _results.addAll(response);
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
        List<Ebook>? response = await EbookFunctions.getListEbookWithPagination(
            page, perPage,
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
      getListEbook(1, 10);
    }
    if (isLoadingCategories) {
      getCategories();
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          child: TextField(
            style: TextStyle(fontSize: 12, color: Colors.grey[900]),
            controller: _controller,
            onChanged: (value) {
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
                    'asset/svg/ic_search.svg',
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
                hintText: 'Search Ebook...'),
          ),
        ),
        isLoadingCategories
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _generateChips(categories).length,
                  itemBuilder: (context, index) {
                    return _generateChips(categories)[index];
                  },
                  shrinkWrap: true,
                ),
              ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: _results.isEmpty
                    ? const MyEmptyResult(text: "No data")
                    : getCourseCard(),
              ),
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

  Widget getCourseCard() {
    if (MediaQuery.of(context).size.width < Breakpoint.tablet) {
      return ListEBookCard(
          results: _results,
          scrollController: _scrollController,
          listLevels: listLevels);
    } else if (MediaQuery.of(context).size.width < Breakpoint.desktop) {
      return GridEBookCard(
          results: _results,
          scrollController: _scrollController,
          listLevels: listLevels);
    }
    return GridEBookCard(
        results: _results,
        scrollController: _scrollController,
        listLevels: listLevels,
        gridNum: 3);
  }
}

class GridEBookCard extends StatelessWidget {
  const GridEBookCard(
      {super.key,
      required List<Ebook> results,
      required ScrollController scrollController,
      required this.listLevels,
      this.gridNum = 2})
      : _results = results,
        _scrollController = scrollController;

  final List<Ebook> _results;
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
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.77,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            // if (await canLaunchUrl(Uri.parse(_results[index].fileUrl))) {
            //   await launchUrl(Uri.parse(_results[index].fileUrl));
            // }
          },
          child: Card(
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.width * 0.45,
                    width: double.infinity,
                    imageUrl: _results[index].imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
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
                        Text(
                          listLevels[_results[index].level] ?? 'Any level',
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ListEBookCard extends StatelessWidget {
  const ListEBookCard({
    super.key,
    required List<Ebook> results,
    required ScrollController scrollController,
    required this.listLevels,
  })  : _results = results,
        _scrollController = scrollController;

  final List<Ebook> _results;
  final ScrollController _scrollController;
  final Map<String, String> listLevels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _results.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(_results[index].fileUrl))) {
                await launchUrl(Uri.parse(_results[index].fileUrl));
              }
            },
            child: Card(
              elevation: 8,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl: _results[index].imageUrl,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
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
                          Text(
                            listLevels[_results[index].level] ?? 'Any level',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[800]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
