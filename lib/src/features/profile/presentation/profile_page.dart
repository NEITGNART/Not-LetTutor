import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/features/profile/presentation/controller/user_controller.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants.dart';
import '../../../common/presentation/my_date_picker.dart';
import '../../../common/presentation/sidebar/presentation/drop_down_button.dart';
import '../../../utils/countries_list.dart';
import 'widget/avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            if (c.user == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AvatarProfile(
                        imagePath: getAvatar(c.user?.avatar), onClicked: () {}),
                    gapH16,
                    Text(c.user?.email ?? "",
                        style: kHeadlineLabelStyle.copyWith(
                          fontSize: 16,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name', style: kHeadlineLabelStyle),
                        gapH4,
                        InputFieldWidget(
                            controller: c.nameController,
                            type: TextInputType.name),
                        gapH12,
                        Text('Birdday', style: kHeadlineLabelStyle),
                        gapH4,
                        const MyDatePicker(),
                        gapH12,
                        Text('Phone number', style: kHeadlineLabelStyle),
                        gapH4,
                        InputFieldWidget(
                            controller: c.phoneController,
                            type: TextInputType.number),
                        gapH12,
                        Text('Country', style: kHeadlineLabelStyle),
                        gapH4,
                        CustomDropdownButton2(
                          hint: 'Please select your country',
                          dropdownItems: countryList.keys.toList(),
                          map: countryList,
                          onChanged: (value) {
                            c.updateCountry(value!);
                          },
                          value: c.user?.country,
                        ),
                        gapH12,
                        Text('Level', style: kHeadlineLabelStyle),
                        gapH4,
                        CustomDropdownButton2(
                          hint: 'Please select your level',
                          dropdownItems: levelList.keys.toList(),
                          map: levelList,
                          onChanged: (value) {
                            c.updateLevel(value!);
                          },
                          value: c.user?.level,
                        ),
                        gapH12,
                        Text('Want to learn', style: kHeadlineLabelStyle),
                        gapH4,
                      ]),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     context.pop();
                //   },
                //   child: const Text('Go Back'),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget(
      {super.key, required this.controller, required this.type});

  final TextEditingController controller;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade50),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade50),
          borderRadius: BorderRadius.circular(15),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
    );
  }
}
