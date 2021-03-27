import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      
        ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          const Text("Nearby Hostel"),
                      const Text("1 km"),],
                      ),
                      const Icon(Icons.account_circle_outlined)
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 25,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Text("Data $index");
                },
                ),
     
    ),
          ],
        );
}
}