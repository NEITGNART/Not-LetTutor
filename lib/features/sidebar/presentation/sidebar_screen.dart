import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../models/sidebar.dart';
import '../data/sidebar_repository.dart';

class SideBarScreen extends StatelessWidget {
  const SideBarScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kSidebarBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(34.0),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 30.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/63442323?s=400&u=6c7e39388a72491c2099a069ec7a5cb4698ab73e&v=4')),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Pham',
                    style: kHeadlineLabelStyle,
                  ),
                  const SizedBox(height: 5.0),
                  Text('Software Engineer', style: kSearchPlaceholderStyle),
                ],
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ...sidebarItem
              .map((item) => Column(
                    children: [
                      SideBarRow(sideBarItem: item),
                      const SizedBox(height: 20.0),
                    ],
                  ))
              .toList(),
          const Spacer(),
          Row(
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                'Log Out',
                style: kCalloutLabelStyle,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SideBarRow extends StatelessWidget {
  final SidebarItem sideBarItem;
  const SideBarRow({
    super.key,
    required this.sideBarItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50.0,
          height: 50.0,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: sideBarItem.background,
          ),
          child: sideBarItem.icon,
        ),
        const SizedBox(width: 10.0),
        Text(
          sideBarItem.title,
          style: kCalloutLabelStyle,
        )
      ],
    );
  }
}
