import 'package:dorms_for_you/di.dart';
import 'package:dorms_for_you/features/dorms/bloc/dorm_bloc.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Nearest Hostel to you is"),
                      const Text(
                        "SOME HOSTEL",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "5km away | Aushapur",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        spacing: 8,
                        children: [
                          OutlinedButton(
                              onPressed: () {},
                              child: const Text(
                                "Details",
                                style: TextStyle(color: Colors.white),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                getIt
                                    .get<DormBloc>()
                                    .add(OpenMaps("1.1", "1.1"));
                              },
                              child: const Text("Open in Maps",
                                  style: TextStyle(color: Colors.white))),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Search",
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, top: 8, bottom: 8),
                  child: Card(child: Center(child: Text("Hostel $index"))),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
