import 'package:beatiful_ui/src/features/profile/presentation/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../features/tutor/presentation/tutor_home_page.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key});
  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  UserController c = Get.find();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: c.dateController,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade50),
          borderRadius: BorderRadius.circular(15),
        ),
        suffixIcon: const Icon(Icons.calendar_today),
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
      //set it true, so that user will not able to edit text
      readOnly: true,
      onTap: () async {
        DateTime? birthday = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));
        // String bdArg =
        //     "${birthday!.year.toString()}-${birthday.month.toString().padLeft(2, "0")}-${birthday.day..toString().padLeft(2, "0")}";
        // c.dateController.text = bdArg;
        if (birthday != null) {
          logger.i(
              birthday); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(birthday);
          logger.i(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          setState(() {
            c.dateController.text =
                formattedDate; //set output date to TextField value.
          });
        } else {}
      },
    );
  }
}
