// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/config/routes/routes.dart';
import 'package:todo/core/enums/screen_status.dart';
import 'package:todo/features/login/data/datasource/remote/remote_login_ds_impl.dart';
import 'package:todo/features/login/data/respository/login_repo_impl.dart';
import 'package:todo/features/login/domain/usecases/login_usecase.dart';

import '../../../../config/theme/textStyles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_button.dart';
import '../../../../core/utils/app_text_formfield.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(LoginUseCase(LoginRepoImpl(RemoteLoginDSImpl()))),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == RequestStatus.loading) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (state.status == RequestStatus.success) {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutesName.home, (route) => false);
          } else if (state.status == RequestStatus.failure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Error"),
                content: Text(state.failures?.message ?? ""),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: AppBar(
                backgroundColor: AppColors.mainColor,
                title: Text(
                  'Taskaty',
                  style: GoogleFonts.elMessiri(
                    textStyle: TextStyles.appName,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyles.appName,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppTextFormField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppTextFormField(
                      hintText: "Password",
                      isObscureText: true,
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    AppTextButton(
                        buttonText: "Login",
                        textStyle: TextStyles.buttonStyle,
                        onPressed: () {
                          // BlocProvider.of<LoginBloc>(context).add(
                          //     LoginButtonEvent("emily.johnson@x.dummyjson.com",
                          //         "emilyspass"));
                          Navigator.pushReplacementNamed(
                              context, RoutesName.home);
                        }),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
