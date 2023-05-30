// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/history.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../constants/constants.dart';

class HistoryExpandCard extends StatelessWidget {
  final HistoryInfo historyInfo;
  const HistoryExpandCard({
    super.key,
    required this.isExpanded,
    required this.historyInfo,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: historyBackground,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Column(
            children: [
              historyInfo.requestContent == null
                  ? EmptyExpansionTile(title: 'No request for lesson'.tr)
                  : CustomExpansionTile(
                      isExpanded: isExpanded,
                      content: historyInfo.requestContent!,
                      title: 'Request for lesson'),
              historyInfo.reviewContent == null
                  ? EmptyExpansionTile(title: 'No review from tutor'.tr)
                  : CustomExpansionTile(
                      isExpanded: isExpanded,
                      content: historyInfo.reviewContent!,
                      title: 'Review from tutor'.tr),
              ListTile(
                leading: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {},
                  child: Text('Add a Rating'.tr,
                      style: kSearchPlaceholderStyle.copyWith(
                          color: Colors.blue, fontSize: 14)),
                ),
                trailing: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Edit request'.tr,
                    style: kSearchPlaceholderStyle.copyWith(
                        color: Colors.blue, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.isExpanded,
    required this.content,
    required this.title,
  });

  final bool isExpanded;
  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: isExpanded,
      title: Text(title, style: kBodyLabelStyle.copyWith(fontSize: 14)),
      backgroundColor: historyBackground,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 32,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(width: 0.5, color: Color(0xFFE5E5E5)),
            ),
          ),
          child: Text(
            content,
            style: kSearchPlaceholderStyle.copyWith(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class EmptyExpansionTile extends StatelessWidget {
  final String title;
  const EmptyExpansionTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: ExpansionTile(
        title: Text(title, style: kBodyLabelStyle.copyWith(fontSize: 14)),
        trailing: const SizedBox(),
        backgroundColor: Colors.white,
        children: [
          Container(),
        ],
      ),
    );
  }
}
