// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/core/network/firebase_functions.dart';

import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/home/presentation/widgets/edit_task_bottom_sheet.dart';

import '../../../../config/theme/textStyles.dart';

class TaskItem extends StatefulWidget {
  TaskModel model;

  TaskItem({super.key, required this.model});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    // Initialize the isDone state from the model's initial value
    isDone = widget.model.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDone ? Colors.blue : AppColors.mainColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunctions.deleteTask(widget.model.id);
              },
              label: "Delete",
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
            ),
            SlidableAction(
              onPressed: (context) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: EditTaskBottomSheet(
                        task: widget.model,
                      ),
                    );
                  },
                );
              },
              label: "Edit",
              icon: Icons.edit,
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Container(
                height: 70.h,
                width: 4.w,
                decoration: BoxDecoration(
                  color: AppColors.secColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              Expanded(
                child: ListTile(
                  isThreeLine: false,
                  title: Text(
                    widget.model.title,
                    style: isDone
                        ? TextStyles.font18TextW500
                            .copyWith(color: Colors.white)
                        : TextStyles.font18TextW500,
                  ),
                  subtitle: Text(
                    widget.model.description,
                    style: isDone
                        ? TextStyles.font14TextW400
                            .copyWith(color: Colors.white)
                        : TextStyles.font14TextW400,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      markTaskAsDone();
                    },
                    child: Container(
                      height: 35.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      decoration: BoxDecoration(
                        color: isDone ? Colors.green : Colors.blue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.done,
                        size: 28.sp,
                        color:
                            isDone ? Colors.white : AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void markTaskAsDone() {
    setState(() {
      isDone = !isDone;
    });

    // Update the task's isDone status in Firebase
    FirebaseFunctions.markTaskAsDone(widget.model.id, isDone);
  }
}
