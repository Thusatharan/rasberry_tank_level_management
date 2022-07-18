import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TankAreaRainfall extends StatefulWidget {
  const TankAreaRainfall({Key? key}) : super(key: key);

  @override
  State<TankAreaRainfall> createState() => _TankAreaRainfallState();
}

class _TankAreaRainfallState extends State<TankAreaRainfall> {
  String output = "";
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formkey = GlobalKey();
    TextEditingController _humidityController = TextEditingController();
    TextEditingController _temperatureController = TextEditingController();
    TextEditingController _windspeedController = TextEditingController();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromRGBO(129, 193, 123, 1),
            Color.fromRGBO(156, 231, 97, 1),
          ],
        ),
      ),
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Tank Area Roundfall Prediction'),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white54,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text('Enter following data to predict roundfall'),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _humidityController,
                    decoration: const InputDecoration(
                      focusColor: Colors.white,
                      suffixText: '%',
                      hintText: 'Enter Humidity',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.water,
                        color: Colors.green,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is requried';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _temperatureController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      focusColor: Colors.white,
                      suffixText: 'C',
                      hintText: 'Enter Temperature',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.device_thermostat_rounded,
                        color: Colors.green,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is requried';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _windspeedController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      focusColor: Colors.white,
                      suffixText: 'km/h',
                      hintText: 'Enter Wind Speed',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.air,
                        color: Colors.green,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is requried';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          if (int.parse(_humidityController.text) > 50 &&
                              int.parse(_temperatureController.text) < 50 &&
                              int.parse(_windspeedController.text) < 50) {
                            setState(() {
                              output = "Rainfall Expected";
                            });
                          } else {
                            output = "No chance of rain";
                          }
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    // title: Text('Your Current Location'),
                                    content: Container(
                                      height: 300,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 90,
                                          ),
                                          const Text(
                                            'Form Sucessfully Submitted',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            output,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.green),
                                          )
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
                        }
                      },
                      child: Text('Prediction')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
