import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../features/tutor/tutor_home_page.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key});
  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: TextField(
        // hidden divider
        controller: dateInput,
        //editing controller of this TextField
        decoration: const InputDecoration(
            // adjust icon to the right
            suffixIcon: Icon(Icons.calendar_today), //suffix icon of text field
            labelText: "Select a day", //label text of field
            border: InputBorder.none),
        readOnly: true,
        //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2100));

          if (pickedDate != null) {
            logger.i(
                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            logger.i(
                formattedDate); //formatted date output using intl package =>  2021-03-16
            setState(() {
              dateInput.text =
                  formattedDate; //set output date to TextField value.
            });
          } else {}
        },
      ),
    );
  }
}
