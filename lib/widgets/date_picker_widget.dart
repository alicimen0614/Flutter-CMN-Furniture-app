import 'package:flutter/material.dart';

Future<DateTime?> datePickerWidget(
    BuildContext context, String helpText, DateTime initialDate) {
  return showDatePicker(
    locale: const Locale("tr"),
    helpText: helpText,
    cancelText: 'İptal',
    confirmText: 'Tamam',
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2022),
    lastDate: DateTime(2024),
    builder: (context, child) {
      return Theme(
          data: Theme.of(context).copyWith(
              colorScheme:
                  const ColorScheme.light(primary: Colors.amberAccent)),
          child: child!);
    },
  );
}
