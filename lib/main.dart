import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:promina_task/core/cache/shared_prefs.dart';
import 'package:promina_task/core/utils/observer.dart';
import 'package:promina_task/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}
