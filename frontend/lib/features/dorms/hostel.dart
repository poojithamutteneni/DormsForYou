import 'package:database_provider/database_provider.dart';
import 'package:dorms_for_you/features/authentication/auth_screen/auth_screen.dart';
import 'package:dorms_for_you/features/authentication/auth_screen/cubit/login_cubit.dart';
import 'package:dorms_for_you/features/authentication/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../di.dart';

class HostelScreen extends StatelessWidget {
  final Hostel hostel;

  const HostelScreen({Key? key, required this.hostel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 18, color: Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    hostel.name.toUpperCase(),
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                Center(
                    child: Text("${hostel.address}",
                        style: TextStyle(fontSize: 18))),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: HostelImages()),
                Center(
                  child: Card(
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            Text("Price - ₹${hostel.roomPrice}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                                "Rooms Available : ${hostel.availableRoomCount}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                                "Students/Persons per room : ${hostel.roomMateCount}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Description : ${hostel.description}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Contact : ${hostel.contact}")
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              onPressed: () {
                if (getIt
                    .get<AuthenticationCubit>()
                    .state
                    .user
                    .isAuthenticated) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 150,
                          child: AlertDialog(
                            title: const Text("Booking status"),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Booking ID : #12"),
                                const Text("Booked room successfully"),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                              create: (context) => getIt.get<LoginCubit>(),
                              child: AuthScreen())));
                }
              },
              child: const Text("Book")),
        ],
      ),
    );
  }
}

class HostelImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return InteractiveViewer(
              scaleEnabled: true,
              maxScale: 5,
              minScale: 1,
              child: new Image.network(
                "https://pix10.agoda.net/hotelImages/5404174/0/efe83e8f54e41ebfb4366f8649ba5813.jpg?s=1024x768",
                fit: BoxFit.fitHeight,
              ),
            );
          },
          itemCount: 2,
          physics: const BouncingScrollPhysics(),
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        )),
      ],
    );
  }
}
