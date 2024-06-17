import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/home/data/models/task_model.dart';

import '../../../../config/theme/textStyles.dart';
import '../../../../core/network/firebase_functions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_button.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final TaskModel task;

  const EditTaskBottomSheet({required this.task, super.key});

  @override
  State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  late GlobalKey<FormState> formKey;
  late DateTime selectedDate;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.task.date);
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
  }

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
                "Edit Task",
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
                buttonText: "Update Task",
                textStyle: TextStyles.buttonStyle,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.task.title = titleController.text;
                    widget.task.description = descriptionController.text;
                    widget.task.date =
                        DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch;

                    FirebaseFunctions.editTask(widget.task);
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
