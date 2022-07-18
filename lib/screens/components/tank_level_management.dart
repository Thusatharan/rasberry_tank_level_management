import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class GetLocationScreen extends StatefulWidget {
  GetLocationScreen({Key? key}) : super(key: key);

  @override
  State<GetLocationScreen> createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  bool isGettingLocation = false;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  Location location = Location();
  String value = "";
  bool isShowResult = false;
  bool isLoading = false;

  Future _onPressCheckFloodLevel() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      setState(() {
        isGettingLocation = false;
      });
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });
    _locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
    });

    print(_locationData.longitude);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              // title: Text('Your Current Location'),
              content: Container(
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 90,
                    ),
                    Text(
                      'Your Location',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Latitude'),
                            Text(_locationData.latitude.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Longitude'),
                            Text(_locationData.longitude.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                )
              ],
            ));

    setState(() {
      isGettingLocation = false;
    });
    sendLocation(_locationData.latitude, _locationData.longitude);
  }

  Future<String> sendLocation(double? lat, double? long) async {
    isLoading = true;
    String result = "";
    Map data = {"lat": lat, "long": long};
    print(data);
    print("encoded--${json.encode(data)}");
    const url = "http://10.0.2.2:5000/land_analysis";
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print('response---${response.body}');
    // print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        result = json["output"] as String;
        print('---Success $result');

        setState(() {
          value = result;
          isShowResult = true;
          isLoading = false;
        });
        // Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => QuizResult(
        //             result: result,
        //           )),
        // );
        return result;
      }
    } catch (e) {
      // Navigator.pop(context);
      print(e);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromRGBO(30, 138, 0, 1),
            Color.fromRGBO(72, 156, 26, 1),
          ],
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Tank flood level management'),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(top: 150),
                transform: Matrix4.translationValues(55.0, 0.0, 0.0),
                child: Image.asset(
                  "assets/images/paddy.png",
                  height: 300,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      margin: EdgeInsets.only(top: 60),
                      child: Text(
                        'Click below button to check flood level in your current location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 220,
                      height: 100,
                      margin: EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isGettingLocation ? Colors.green : Colors.white,
                      ),
                      child: isGettingLocation
                          ? const Center(
                              child: Text(
                                'Getting Location',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: _onPressCheckFloodLevel,
                              child: const Text('Check Flood Level'),
                              style: ElevatedButton.styleFrom(
                                  elevation: 8.0,
                                  primary: Colors.white,
                                  onPrimary: Colors.green,
                                  shadowColor: Colors.black,
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20)),
                            ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    isLoading
                        ? Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.blue,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ))
                        : Text(
                            'Waiting for response',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
