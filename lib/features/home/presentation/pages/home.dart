import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/config/routes/routes.dart';
import 'package:todo/config/theme/textStyles.dart';

import 'package:todo/core/network/firebase_functions.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/features/home/data/models/task_model.dart';

import '../widgets/bottom_sheet.dart';
import '../widgets/my_date_picker.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesName.login);
            },
            child: Icon(
              Icons.logout_rounded,
              size: 26.sp,
              color: AppColors.secColor,
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
        title: Text(
          'Taskaty',
          style: GoogleFonts.elMessiri(
            textStyle: TextStyles.appName,
          ),
        ),
        //  Text(
        //   "Taskaty",
        //   style: TextStyles.font24textW500,
        // ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 110.h,
                color: AppColors.mainColor,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.r, left: 10.r, bottom: 10.r),
                child: MyDataPicker(
                  selectedDate: selectedDate,
                  onDateChange: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFunctions.getTasks(selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.secColor,
                  ));
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Something Went Wrong!"));
                }
                List<TaskModel> tasksList =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

                if (tasksList.isEmpty) {
                  return Center(
                      child: Text(
                    "No Tasks!",
                    style: TextStyles.appName,
                  ));
                }
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskItem(model: tasksList[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15.h,
                  ),
                  itemCount: tasksList.length,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16.0.r),
        child: FloatingActionButton(
          isExtended: true,
          backgroundColor: AppColors.secColor,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const MyBottomSheet(),
                );
              },
            );
          },
          child: Icon(
            Icons.add,
            size: 28.sp,
            color: AppColors.backgroundColor,
          ),
        ),
      ),
    );
  }
}
