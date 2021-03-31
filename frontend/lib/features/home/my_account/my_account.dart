import 'package:dorms_for_you/di.dart';
import 'package:dorms_for_you/features/authentication/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = getIt.get<AuthenticationCubit>().state.user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hello, ${user.name}",
                          style: TextStyle(
                            fontSize: 32,
                          )),
                      Text(
                        "${user.email}",
                      ),
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Booked Hostels",
                style: TextStyle(color: Colors.blue),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Booking ID: 12"),
                                const Text("Hostel Name: "),
                                const Text("from 23rd to 25th od OCT")
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
