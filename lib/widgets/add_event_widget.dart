import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AddEventDialog extends StatefulWidget {
  const AddEventDialog({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  late DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    _selectedDate = widget.selectedDate;

    return AlertDialog(
      title: Text(
        '일정 추가',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Divider(),
            hourMinute15Interval(),
            Divider(),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(hintText: '일정'),
            ),
            TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(hintText: '장소'),
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {},
          child: Text('OK'),
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text('CANCEL'),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Widget hourMinute15Interval() {
    return TimePickerSpinner(
      time: _selectedDate,
      is24HourMode: false,
      isForce2Digits: true,
      minutesInterval: 15,
      alignment: Alignment.center,
      highlightedTextStyle: TextStyle(
        fontSize: 24,
        color: Colors.black87,
      ),
      normalTextStyle: TextStyle(
        fontSize: 24,
        color: Colors.black45,
      ),
      onTimeChange: (time) {
        setState(() {
          _selectedDate = time;
        });
      },
    );
  }
}
