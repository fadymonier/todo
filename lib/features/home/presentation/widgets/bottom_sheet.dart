// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo/core/network/firebase_functions.dart';
import 'package:todo/features/home/data/models/task_model.dart';

import '../../../../config/theme/textStyles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_button.dart';

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({super.key});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        color: AppColors.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0.r),
              child: Text(
                "Add Task",
                style: TextStyles.bottomSheet,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                style: const TextStyle(
                    color: AppColors.secColor), // Set text color
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Add Task Title";
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: const TextStyle(
                      color: AppColors.secColor), // Set label text color
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secColor), // Set enabled border color
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(color: AppColors.mainColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0.r),
              child: TextFormField(
                style: const TextStyle(
                    color: AppColors.secColor), // Set text color
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Add Task Description";
                  }
                  return null;
                },
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Task Description",
                  labelStyle: const TextStyle(
                      color: AppColors.secColor), // Set label text color
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secColor), // Set enabled border color
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(color: AppColors.secColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Select Time",
              style: TextStyles.bottomSheet,
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                selectDate(context);
              },
              child: Text(
                selectedDate.toString().substring(0, 10),
                style: TextStyles.bottomSheet,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.all(12.0.r),
              child: AppTextButton(
                buttonText: "Add Task",
                textStyle: TextStyles.buttonStyle,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel task = TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: DateUtils.dateOnly(selectedDate)
                            .millisecondsSinceEpoch);

                    FirebaseFunctions.addTask(task);
                      Navigator.pop(context);
                    
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }
}
