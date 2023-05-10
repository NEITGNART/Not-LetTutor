import 'package:flutter/material.dart';

class HistoryBanner extends StatelessWidget {
  const HistoryBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        // child: Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     SizedBox(
        //       width: 120,
        //       height: 120,
        //       child: SvgPicture.network(
        //           'https://sandbox.app.lettutor.com/static/media/history.1e097d10.svg'),
        //     ),
        //     gapW16,
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text('History', style: kTitle1Style),
        //           gapH12,
        //           const BlockQuote(
        //             blockColor: Colors.grey,
        //             child: Text(
        //                 '''The following is a list of lessons you have attended\n\nYou can review the details of the lessons you have attended'''),
        //           ),
        //           // create blockquote using flutter-quill
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
