import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    super.key,
    required this.totalPage,
    required this.show,
    required this.currentPage,
    required this.cb,
  });

  final int totalPage;
  final int show;
  final int currentPage;
  final Function cb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Pagination(
        paginateButtonStyles: PaginateButtonStyles(
            activeTextStyle: const TextStyle(color: Colors.blue),
            activeBackgroundColor: Colors.white),
        prevButtonStyles: PaginateSkipButton(
            buttonBackgroundColor: Colors.blue.shade400,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
        nextButtonStyles: PaginateSkipButton(
            buttonBackgroundColor: Colors.blue.shade400,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        onPageChange: (number) {
          cb(number);
        },
        useGroup: false,
        totalPage: totalPage,
        show: show,
        currentPage: currentPage,
      ),
    );
  }
}
