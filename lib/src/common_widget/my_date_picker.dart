import 'package:beatiful_ui/src/features/profile/presentation/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            lastDate: DateTime(2100));
        if (birthday != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(birthday);
          setState(() {
            c.dateController.text =
                formattedDate; //set output date to TextField value.
          });
        } else {}
      },
    );
  }
}
