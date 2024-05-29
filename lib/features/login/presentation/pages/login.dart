// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/config/routes/routes.dart';
import 'package:promina_task/core/enums/screen_status.dart';
import 'package:promina_task/features/login/data/data_source/remote/remote_login_ds_impl.dart';
import 'package:promina_task/features/login/data/repository/login_repo_impl.dart';
import 'package:promina_task/features/login/domain/usecases/login_usecase.dart';
import 'package:promina_task/features/login/presentation/bloc/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/loginBG.png"))),
      child: BlocProvider(
        create: (context) =>
            LoginBloc(LoginUseCase(LoginRepoImpl(RemoteLoginDSImpl()))),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == RequestStatus.loading) {
              showDialog(
                context: context,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
            }
            if (state.status == RequestStatus.success) {
              Navigator.pushNamed(context, RoutesName.home);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200.h,
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 350.w,
                              height: 420.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 320.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0.r),
                            child: Column(
                              children: [
                                Text(
                                  "LOG IN",
                                  style: TextStyle(
                                      color: const Color(0xff4A4A4A),
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      label: const Text("User Name"),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      label: const Text("Password"),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Container(
                                  height: 60.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: const Color(0xff7BB3FF)),
                                  child: MaterialButton(
                                    onPressed: () {
                                      BlocProvider.of<LoginBloc>(context).add(
                                          LoginButtonEvent(
                                              "gladys.green@example.net",
                                              "password"));
                                    },
                                    child: Text("SUBMIT",
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
