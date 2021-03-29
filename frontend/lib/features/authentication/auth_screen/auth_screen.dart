import 'package:dorms_for_you/features/authentication/auth_screen/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final showErrors =
        context.select((LoginCubit bloc) => bloc.state.showErrors);
    final isSignUp = context.select((LoginCubit bloc) => bloc.state.isSignUp);
    return Scaffold(
      body: Form(
        autovalidateMode:
            showErrors ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
          child: Column(
            children: [
              Header(),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (val) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val ?? "");
                  if (!emailValid) return "Invalid mail address!";
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Empty password";
                  } else if (val.length < 6) {
                    return "Password must be atleast 6 characters";
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              isSignUp
                  ? TextFormField(
                      validator: (val) {
                        return context
                            .read<LoginCubit>()
                            .checkConfirmPassword(val ?? "");
                      },
                      decoration:
                          InputDecoration(labelText: "Confirm Password"),
                    )
                  : const SizedBox(
                      height: 8,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isSignUp = context.select((LoginCubit bloc) => bloc.state.isSignUp);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Login"),
        isSignUp
            ? TextButton(onPressed: () {}, child: const Text("SignIn"))
            : TextButton(onPressed: () {}, child: const Text("SignUp"))
      ],
    );
  }
}
