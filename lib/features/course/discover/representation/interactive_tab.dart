import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InteractiveTab extends StatelessWidget {
  const InteractiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
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
    ));
  }
}
