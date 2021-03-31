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
          padding: const EdgeInsets.all(16.0),
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
                const SizedBox(
                  height: 32,
                ),
                Text("Price - ₹${hostel.roomPrice}"),
                const SizedBox(
                  height: 8,
                ),
                Text("Rooms Available : ${hostel.availableRoomCount}"),
                const SizedBox(
                  height: 8,
                ),
                Text("Students/Persons per room : ${hostel.roomMateCount}"),
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
                  //TODO
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
                "https://images.unsplash.com/photo-1582721478779-0ae163c05a60?ixid=MXwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8Ym84alFLVGFFMFl8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
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
