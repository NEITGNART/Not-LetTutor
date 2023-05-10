import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/tutor/presentation/tutor_home_page.dart';

class MyTimePicker extends StatefulWidget {
  final String title;
  const MyTimePicker({super.key, required this.title});
  @override
  _MyTimePickerState createState() => _MyTimePickerState(title);
}

class _MyTimePickerState extends State<MyTimePicker> {
  final String label;
  TextEditingController dateInput = TextEditingController();
  _MyTimePickerState(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: TextField(
        controller: dateInput,
        //editing controller of this TextField
        decoration: InputDecoration(
            // adjust icon to the right
            suffixIcon:
                const Icon(Icons.calendar_today), //suffix icon of text field
            border: InputBorder.none,
            labelText: label),
        readOnly: true,
        //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2024));

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
