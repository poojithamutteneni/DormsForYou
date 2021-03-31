import 'package:dorms_for_you/di.dart';
import 'package:dorms_for_you/features/authentication/auth_screen/auth_screen.dart';
import 'package:dorms_for_you/features/authentication/auth_screen/cubit/login_cubit.dart';
import 'package:dorms_for_you/features/authentication/cubit/authentication_cubit.dart';
import 'package:dorms_for_you/features/home/my_account/my_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowMoreOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isauth =
        getIt.get<AuthenticationCubit>().state.user.isAuthenticated;
    return Wrap(
      children: [
        ListTile(
          title: Center(
              child: isauth ? const Text("My account") : const Text("SignIn")),
          onTap: () {
            if (isauth) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyAccount()));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => getIt.get<LoginCubit>(),
                          child: AuthScreen())));
            }
          },
        ),
        isauth
            ? ListTile(
                title: Center(child: const Text("Logout")),
                onTap: () {
                  getIt.get<AuthenticationCubit>().logout();
                  Navigator.pop(context);
                },
              )
            : const SizedBox(),
        ListTile(
          title: Center(child: const Text("Want to register your hostel?")),
          onTap: () {
            Navigator.pop(context);
            //TODO
          },
        ),
      ],
    );
  }
}
