import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/widget/detail_review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common_widget/pagination.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/constants.dart';
import '../model/tutor_review.dart';
import 'controller/tutor_detail_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewPage extends StatefulWidget {
  final String tutorId;
  const ReviewPage({super.key, required this.tutorId});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    DetailTutorController c = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.review)),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () {
                    if (c.reviews == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (c.reviews.isEmpty) {
                      return Center(
                          child: Image.asset('asset/images/empty.png'));
                    }
                    return ListView.builder(
                      itemCount: c.reviews.length,
                      itemBuilder: (context, index) {
                        return Rewiew(feedback: c.reviews[index]);
                      },
                    );
                  },
                ),
              ),
            ),
            Obx(() {
              if (c.totalPage.value == 0) {
                return const SizedBox();
              }
              int currentPage = c.page.value.page;
              return PaginationWidget(
                  totalPage: c.totalPage.value,
                  show: c.totalPage.value > 3 ? 2 : c.totalPage.value - 1,
                  currentPage: currentPage,
                  cb: (number) {
                    c.getReviewAtPage(widget.tutorId, number);
                    setState(() {});
                  });
            })
          ],
        ),
      ),
    );
  }
}

class Rewiew extends StatelessWidget {
  const Rewiew({Key? key, required this.feedback}) : super(key: key);

  final TutorReview feedback;

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
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    getAvatar(feedback.firstInfo?.avatar),
                  ),
                ),
                gapW12,
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          feedback.firstInfo?.name ?? "",
                          style: kCardTitleStyle.copyWith(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        if (feedback.rating?.floor() != null) ...{
                          getStarsWidget(
                            5,
                            feedback.rating!.floor(),
                          )
                        }
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: feedback.content!.isNotEmpty
                    ? Text(feedback.content ?? "", style: kSubtitleStyle)
                    : null),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.yMEd().add_jm().format(
                      DateFormat("yyyy-MM-dd").parse(feedback.createdAt ?? "")),
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
