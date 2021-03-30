import 'package:dorms_for_you/di.dart';
import 'package:dorms_for_you/features/dorms/bloc/dorm_bloc.dart';
import 'package:flutter/material.dart';

enum Types { College, Hostels }

class RadioBtns extends StatefulWidget {
  @override
  _RadioBtnsState createState() => _RadioBtnsState();
}

class _RadioBtnsState extends State<RadioBtns> {
  bool isHostels = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isHostels = false;
              });
              getIt.get<DormBloc>().add(SetSearchType(isHostels));
            },
            child: Text(
              "Colleges",
              style: TextStyle(color: isHostels ? Colors.grey : Colors.blue),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isHostels = true;
              });
              getIt.get<DormBloc>().add(SetSearchType(isHostels));
            },
            child: Text(
              "Hostels",
              style: TextStyle(color: isHostels ? Colors.blue : Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
