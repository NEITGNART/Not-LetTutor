import 'dart:io';

import 'package:beatiful_ui/src/common/app_sizes.dart';
import 'package:beatiful_ui/src/features/profile/presentation/controller/user_controller.dart';
import 'package:beatiful_ui/src/features/profile/presentation/widget/textfield.dart';
import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:beatiful_ui/src/utils/learning_topics.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../common/constants.dart';
import '../../../common/presentation/my_date_picker.dart';
import '../../../common/presentation/sidebar/presentation/drop_down_button.dart';
import '../../../utils/countries_list.dart';
import '../../authentication/presentation/controller/login_controller.dart';
import 'widget/avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker picker = ImagePicker();
  final c = Get.put(UserController());
  final loginC = Get.find<LoginPageController>();
  File? avatar;

  @override
  // start
  void initState() {
    super.initState();
    c.getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
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
                        image: avatar,
                        isEdit: true,
                        imagePath: getAvatar(c.user?.avatar),
                        onClicked: () async {
                          var pickedFile = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 50);
                          if (pickedFile != null) {
                            setState(
                              () {
                                avatar = File(pickedFile.path);
                                c.avatar = avatar;
                              },
                            );
                          }
                        }),
                    gapH16,
                    Text(
                      c.user?.email ?? "",
                      style: kHeadlineLabelStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
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
                        c.user!.isPhoneActivated! == false
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.green, width: 1),
                                        color: Colors.green[50],
                                        borderRadius: BorderRadius.circular(4)),
                                    child: const Text(
                                      "Verified",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
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
                            print(value);
                            c.updateLevel(value!);
                          },
                          value: c.user?.level,
                        ),
                        gapH12,
                        Text('Want to learn', style: kHeadlineLabelStyle),
                        gapH4,
                        Text(
                          'Subject',
                          style: kHeadlineLabelStyle.copyWith(
                              color: Colors.grey, fontSize: 14),
                        ),
                        gapH4,
                        if (c.topics.value.isNotEmpty) ...{
                          ChipsChoice<String>.multiple(
                            padding: const EdgeInsets.all(0),
                            value: c.newTopics,
                            onChanged: (List<String> val) {
                              Logger().e(val);
                              c.newTopics.assignAll(val);
                              setState(() {});
                            },
                            choiceItems: C2Choice.listFrom<String, String>(
                              source: topicsList.keys.toList(),
                              value: (i, v) => v,
                              label: (i, v) => v,
                            ),
                            wrapped: true,
                            // choiceCheckmark: true,
                            choiceStyle: C2ChipStyle.outlined(
                              color: Colors.blue,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                              selectedStyle: C2ChipStyle.filled(
                                  color: Colors.blue,
                                  foregroundColor: Colors.white),
                            ),
                          )
                        },
                        Text(
                          'Test preparation',
                          style: kHeadlineLabelStyle.copyWith(
                              color: Colors.grey, fontSize: 14),
                        ),
                        gapH4,
                        if (c.preparations.value.isNotEmpty) ...{
                          ChipsChoice<String>.multiple(
                            padding: const EdgeInsets.all(0),
                            value: c.newPreparation,
                            onChanged: (List<String> val) {
                              c.newPreparation.assignAll(val);
                              setState(() {});
                            },
                            choiceItems: C2Choice.listFrom<String, String>(
                              source: prepareList.keys.toList(),
                              value: (i, v) => v,
                              label: (i, v) => v,
                            ),
                            wrapped: true,
                            // choiceCheckmark: true,
                            choiceStyle: C2ChipStyle.outlined(
                              color: Colors.blue,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                              selectedStyle: C2ChipStyle.filled(
                                  color: Colors.blue,
                                  foregroundColor: Colors.white),
                            ),
                          )
                        },
                        gapH4,
                        TextFieldWidget(
                          // label: lang.schedule,
                          hintText: 'Write your schedule here',
                          maxLines: 5,
                          text: c.schedule.value,
                          onChanged: (value) {
                            c.schedule.value = value;
                          },
                          label: 'Schedule',
                        ),
                        gapH12,
                        Padding(
                          padding: const EdgeInsets.only(right: 40, left: 40),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final userInfo = await c.updateUserInfo();
                                    if (userInfo != null) {
                                      loginC.updateUser(userInfo.avatar,
                                          userInfo.name, userInfo.email);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text('Save',
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        gapH8,
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
