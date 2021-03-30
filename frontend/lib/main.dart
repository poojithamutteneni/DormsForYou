// @dart=2.9
import 'package:dorms_for_you/di.dart';
import 'package:dorms_for_you/features/authentication/cubit/authentication_cubit.dart';
import 'package:dorms_for_you/features/dorms/bloc/dorm_bloc.dart';
import 'package:dorms_for_you/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setup();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark, // navigation bar color
    statusBarColor: Colors.blue, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              lazy: false,
              create: (context) =>
                  getIt.get<AuthenticationCubit>()..authenticate()),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  getIt.get<DormBloc>()..add(const GetHostelsNearBy()))
        ],
        child: Scaffold(
          body: Home(),
        ),
      ),
    );
  }
}
