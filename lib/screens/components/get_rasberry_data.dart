import 'dart:async';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intelligence_tank_management_system/api/get_data.dart';
import 'package:intelligence_tank_management_system/models/Tank.dart';
import 'package:intelligence_tank_management_system/screens/components/past_records.dart';

class GetRasberry extends StatefulWidget {
  const GetRasberry({Key? key}) : super(key: key);

  @override
  State<GetRasberry> createState() => GetRasberryState();
}

class GetRasberryState extends State<GetRasberry> {
  StreamController<Tank> _streamController = StreamController();
  late Future<Tank> futureTank;
  late String tankLevel;

  String tankString(distance) {
    if (distance > 12) {
      return "Tank is empty";
    } else if (distance > 7) {
      return "Tank is almost half";
    } else if (distance > 3) {
      return "Tank is almost full";
    } else {
      return "Tank is full, Open Doors";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      fetchTank(_streamController);
    });
    // futureTank = fetchTank();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
                child: StreamBuilder<Tank>(
                    stream: _streamController.stream,
                    builder: (context, snapdata) {
                      if (!snapdata.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        print(snapdata.data!.distance.toString());
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(40),
                              margin: EdgeInsets.all(10),
                              child: Text(
                                'Tank Level',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width * 3 / 4,
                              color: Color.fromARGB(179, 53, 86, 32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapdata.data!.distance.toString(),
                                    style: TextStyle(
                                        fontSize: 50,
                                        color:
                                            Color.fromARGB(255, 246, 246, 246),
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    tankString(snapdata.data!.distance),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 49, 188, 231),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '31.4 Celcius',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(
                                          255,
                                          254,
                                          254,
                                          254,
                                        ),
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PastRecords()));
                                },
                                child: Text('Past Records')),
                            Spacer(),
                          ],
                        );
                      }
                    })),
          ),
        ],
      ),
    );
  }
}
