import 'package:dorms_for_you/di.dart';
import 'package:dorms_for_you/features/dorms/bloc/dorm_bloc.dart';
import 'package:dorms_for_you/features/home/hostel_college_card.dart';
import 'package:dorms_for_you/features/home/radios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final bool isLoading = context.watch<DormBloc>().state.isLoading;
    // final nearByHostels =
    //     context.select((DormBloc value) => value.state.nearbyHostels);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      //TODO
                    },
                    child: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<DormBloc, DormState>(
                          builder: (context, state) {
                        if (state.isLoading) {
                          return const CircularProgressIndicator();
                        } else if (state.nearbyHostels.isEmpty) {
                          return const Text("No Nearby Hostels");
                        } else if (state.nearbyHostels.isNotEmpty) {
                          return HostelCard(state.nearbyHostels.first);
                        } else {
                          return Container();
                        }
                      }),
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
                onChanged: (val) {
                  if (val.length >= 3)
                    getIt.get<DormBloc>().add(GetCollgesByName(val));
                },
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
            RadioBtns(),
            BlocBuilder<DormBloc, DormState>(
              builder: (context, state) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.isSearchHostels
                      ? state.hostels.length
                      : state.colleges.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (state.isSearchHostels) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, top: 8, bottom: 8),
                        child: HostelSmallCard(state.hostels[index]),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, top: 8, bottom: 8),
                      child: CollegeSmallCard(state.colleges[index]),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
