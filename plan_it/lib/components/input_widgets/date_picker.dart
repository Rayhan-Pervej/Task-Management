import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime initialDate;
  final void Function(DateTime selectedDate) onDateSelected;
  const DateTimePicker(
      {super.key, required this.initialDate, required this.onDateSelected});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateSelected(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Date:',
          style: TextDesign().fieldLabel,
        ),
        InkWell(
          onTap: () => _selectDate(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 5.0),
            child: Text(
              DateFormat('dd-MM-yy').format(_selectedDate),
              style: TextDesign().buttonText.copyWith(
                    color: MyColor.buttonBlue,
                    fontSize: 14,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
