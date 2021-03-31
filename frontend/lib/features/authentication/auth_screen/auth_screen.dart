import 'package:dorms_for_you/features/authentication/auth_screen/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final showErrors = context.watch<LoginCubit>().state.showErrors;
    final isSignUp = context.watch<LoginCubit>().state.isSignUp;
    return Scaffold(
      body: Form(
        autovalidateMode:
            showErrors ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Container(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
          child: Column(
            children: [
              Flexible(child: Header()),
              ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  isSignUp
                      ? TextFormField(
                          validator: (val) {
                            return context
                                .read<LoginCubit>()
                                .checkConfirmPassword(val ?? "");
                          },
                          decoration: InputDecoration(labelText: "Full Name"),
                        )
                      : const SizedBox(
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
                              InputDecoration(labelText: "DOB dd/mm/yyyy"),
                        )
                      : const SizedBox(
                          height: 8,
                        ),
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
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().sign();
                      },
                      child: isSignUp
                          ? const Text("SignUp")
                          : const Text("Login")),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black),
                      child: InkWell(
                          onTap: () {
                            context.read<LoginCubit>().isSignUp();
                          },
                          child: isSignUp
                              ? const Text("Already registered? Signin")
                              : const Text("Not registered? SignUp")),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              )
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

    return DefaultTextStyle(
      style: TextStyle(fontSize: 34, color: Colors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          isSignUp ? const Text("Signup") : const Text("Signin")
        ],
      ),
    );
  }
}
