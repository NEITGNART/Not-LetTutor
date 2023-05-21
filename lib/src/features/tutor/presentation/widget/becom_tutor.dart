import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BecomeTutor extends StatelessWidget {
  const BecomeTutor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.becomeTutor),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'asset/svg/smile.svg',
                height: 100,
                width: 100,
                color: Colors.blue,
              ),
              gapH24,
              Text(AppLocalizations.of(context)!.becomeTutor)
            ],
          ),
        ),
      ),
    );
  }
}
