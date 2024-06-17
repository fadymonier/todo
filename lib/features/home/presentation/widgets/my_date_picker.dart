import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class MyDataPicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  const MyDataPicker({
    required this.selectedDate,
    required this.onDateChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      height: 90.h,
      DateTime.now(),
      initialSelectedDate: selectedDate,
      selectionColor: AppColors.backgroundColor,
      selectedTextColor: AppColors.secColor,
      onDateChange: (date) {
        onDateChange(date);
      },
    );
  }
}
