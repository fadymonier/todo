// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_task/config/routes/routes.dart';
import 'package:promina_task/core/api/api_manager.dart';
import 'package:promina_task/core/enums/screen_status.dart';
import 'package:promina_task/features/home/data/data_sources/home_ds_impl.dart';
import 'package:promina_task/features/home/data/repositories/home_repo_impl.dart';
import 'package:promina_task/features/home/domain/use_cases/get_gallery_usecase.dart';
import 'package:promina_task/features/home/presentation/bloc/home_bloc.dart';
import '../../data/models/gallery_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showContainer = false;
  File? file;
  Future<void> pickerCamera() async {
    final myFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (myFile != null) {
      setState(() {
        file = File(myFile.path);
      });
    }
  }

  Future<void> pickerGallery() async {
    final myFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (myFile != null) {
      setState(() {
        file = File(myFile.path);
      });
    }
  }

  Future uploadImage() async {
    if (file == null) return;
    String base64 = base64Encode(file!.readAsBytesSync());

    String imageName = file!.path.split("/").last;
  }

  void toggleContainer() {
    setState(() {
      _showContainer = !_showContainer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/homeBG.png"),
        ),
      ),
      child: BlocProvider(
        create: (context) => HomeBloc(
          GetGalleryUseCase(
            HomeRepoImpl(HomeDSImpl(ApiManager())),
          ),
        )..add(GetGalleryEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.status == RequestStatus.loading) {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(28.0.r),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome",
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff4A4A4A),
                                  ),
                                ),
                                Text(
                                  "Mina",
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff4A4A4A),
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              maxRadius: 32.r,
                              child: Image.asset("assets/images/mina.png"),
                            ),
                          ],
                        ),
                        SizedBox(height: 50.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RoutesName.login);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                width: 120.w,
                                height: 45.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/redbtn.png"),
                                    Text(
                                      "Log out   ",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff4A4A4A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: toggleContainer,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                width: 120.w,
                                height: 45.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/yellowbtn.png",
                                      width: 32.w,
                                    ),
                                    Text(
                                      "  upload ",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff4A4A4A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        state.galleryModel != null
                            ? galleryItem(
                                (state.galleryModel?.data as List<Data>?) ?? [])
                            : SizedBox(
                                height: 280.h,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                      ],
                    ),
                  ),
                  if (_showContainer)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 20.0, sigmaY: 20.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 300.w,
                                    height: 250.h,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 320.w,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 30.0.r),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: pickerGallery,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xffEFD8F9),
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          width: 150.w,
                                          height: 60.h,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/gallery.png",
                                                width: 32.w,
                                              ),
                                              Text(
                                                "   Gallery",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff4A4A4A),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      InkWell(
                                        onTap: pickerCamera,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xffEBF6FF),
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          width: 150.w,
                                          height: 60.h,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/camera.png",
                                                width: 60.w,
                                              ),
                                              Text(
                                                "Camera",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff4A4A4A),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget galleryItem(List<Data> data) {
    return Container(
      height: 288.h,
      margin: EdgeInsets.only(left: 16.w),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, dataIndex) {
          // Check if images list is null or empty
          if (data[dataIndex].images.isEmpty) {
            return const SizedBox();
          }

          // Map over the images list and create image widgets
          return Column(
            children: (data[dataIndex].images).map((imageUrl) {
              return Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
