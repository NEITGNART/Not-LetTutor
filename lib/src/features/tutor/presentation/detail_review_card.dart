import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants.dart';

class ReviewCard extends StatelessWidget {
  Widget getStarsWidget(int totalStart, int goldenStars) {
    assert(totalStart >= goldenStars);
    return Row(
      children: [
        ...List.generate(
            goldenStars,
            (i) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 15,
                )),
        ...List.generate(
            totalStart - goldenStars,
            (i) => const Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 15,
                )),
        const SizedBox(width: 5.0),
      ],
    );
  }

  const ReviewCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(right: 10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                    radius: 50.0,
                    // width: 100,
                    // height: 100,
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4',
                    )),
                const SizedBox(width: 15.0),
                IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'John Pham',
                        style: kHeadlineLabelStyle,
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          getStarsWidget(5, 5),
                          Text('(88)', style: kSearchPlaceholderStyle),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          SvgPicture.network(
                            'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg',
                            width: 20,
                          ),
                          const SizedBox(width: 5.0),
                          Text('Viet Nam', style: kSearchPlaceholderStyle),
                          const SizedBox(width: 5.0),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ],
            ),
            gapH12,
            Text(
                'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
                style: kSearchPlaceholderStyle),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    // set padding = 0
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.blue),
                    // not display shadow and border
                    elevation: MaterialStateProperty.all(0.0),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.favorite_outline),
                      Text('Favarite'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.blue),
                    // not display shadow and border
                    elevation: MaterialStateProperty.all(0.0),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.report_outlined),
                      Text('Report'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.blue),
                    // not display shadow and border
                    elevation: MaterialStateProperty.all(0.0),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.star_border_sharp),
                      Text('Review'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
