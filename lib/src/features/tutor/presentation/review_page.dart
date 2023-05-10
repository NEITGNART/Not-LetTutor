import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/widget/detail_review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/feedback.dart';

class ReviewPage extends StatelessWidget {
  final String tutorId;
  const ReviewPage({super.key, required this.tutorId});

  @override
  Widget build(BuildContext context) {
    List<FeedBack>? feedbacks = Get.find(tag: tutorId) ?? [];
    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            feedbacks.isEmpty
                ? Center(child: SvgPicture.asset('asset/svg/ic_notfound.svg'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: feedbacks.length,
                      itemBuilder: (context, index) {
                        return Previews(feedback: feedbacks[index]);
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class Previews extends StatelessWidget {
  const Previews({Key? key, required this.feedback}) : super(key: key);

  final FeedBack feedback;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 15),
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    child: Image.network(
                      getAvatar(feedback.firstInfo.avatar),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          feedback.firstInfo.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        getStarsWidget(
                          5,
                          feedback.rating.floor(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: feedback.content.isNotEmpty
                    ? Text(feedback.content)
                    : null),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.yMEd().add_jm().format(
                      DateFormat("yyyy-MM-dd").parse(feedback.createdAt)),
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
