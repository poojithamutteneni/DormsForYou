import 'package:database_provider/database_provider.dart';
import 'package:dorms_for_you/di.dart';
import 'package:dorms_for_you/features/dorms/bloc/dorm_bloc.dart';
import 'package:dorms_for_you/features/dorms/hostel.dart';
import 'package:flutter/material.dart';

class HostelCard extends StatelessWidget {
  final Hostel hostel;

  HostelCard(this.hostel);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Nearest Hostel to you is"),
        Text(
          "${hostel.name}".toUpperCase(),
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(
          "${hostel.address}",
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HostelScreen(
                                hostel: hostel,
                              )));
                },
                child: const Text(
                  "Details",
                  style: TextStyle(color: Colors.white),
                )),
            OutlinedButton(
                onPressed: () {
                  getIt.get<DormBloc>().add(OpenMaps(
                      hostel.latitude.toString(), hostel.longitude.toString()));
                },
                child: const Text("Open in Maps",
                    style: TextStyle(color: Colors.white))),
          ],
        )
      ],
    );
  }
}

class HostelSmallCard extends StatelessWidget {
  final Hostel hostel;

  HostelSmallCard(this.hostel);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${hostel.name}  |  ${hostel.address}",
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HostelScreen(
                                  hostel: hostel,
                                )));
                  },
                  child: const Text(
                    "Details",
                  )),
              OutlinedButton(
                  onPressed: () {
                    getIt.get<DormBloc>().add(OpenMaps(
                        hostel.latitude.toString(),
                        hostel.longitude.toString()));
                  },
                  child: const Text(
                    "Open in Maps",
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class CollegeSmallCard extends StatelessWidget {
  final College college;

  CollegeSmallCard(this.college);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${college.name}  |  ${college.address}",
          ),
          const SizedBox(
            height: 16,
          ),
          OutlinedButton(
              onPressed: () {
                getIt.get<DormBloc>().add(GetHostelsByCID(college.id));
              },
              child: const Text(
                "Find all hostels nearby",
              )),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
