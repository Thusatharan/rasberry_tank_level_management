import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intelligence_tank_management_system/screens/components/chat_screen.dart';

import 'components/get_rasberry_data.dart';
import 'components/tank_area_rainfall.dart';
import 'components/tank_level_management.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(40),
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'Intelligence Tank Management System',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width / 2,
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetRasberry())),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 55, 168, 3)
                                      .withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Color.fromARGB(255, 3, 167, 16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Icon(
                                    Icons.water,
                                    size: 70,
                                    color: Color.fromARGB(255, 26, 229, 243),
                                  ),
                                ),
                                Text(
                                  'Tank Level',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            )),
                      ),
                    ),
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width / 2,
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetLocationScreen())),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 167, 16)
                                      .withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Color.fromARGB(255, 3, 167, 16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Icon(
                                    Icons.pin_drop_rounded,
                                    size: 70,
                                    color: Color.fromARGB(255, 235, 182, 182),
                                  ),
                                ),
                                Text(
                                  'Location Based Flood Detection',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width / 2,
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TankAreaRainfall())),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 167, 16)
                                      .withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Color.fromARGB(255, 3, 167, 16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Icon(
                                    Icons.air,
                                    size: 70,
                                    color: Color.fromARGB(255, 241, 216, 73),
                                  ),
                                ),
                                Text(
                                  'Tank Rainfall',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            )),
                      ),
                    ),
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width / 2,
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen())),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 167, 16)
                                      .withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Color.fromARGB(255, 3, 167, 16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Icon(
                                    Icons.chat,
                                    size: 70,
                                    color: Color.fromARGB(255, 253, 253, 253),
                                  ),
                                ),
                                Text(
                                  'Chat',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
