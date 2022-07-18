import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intelligence_tank_management_system/models/record.dart';

import 'package:http/http.dart' as http;

class PastRecords extends StatefulWidget {
  const PastRecords({Key? key}) : super(key: key);

  @override
  State<PastRecords> createState() => _PastRecordsState();
}

class _PastRecordsState extends State<PastRecords> {
  late Future<List<Record>> futureRecords;
  Future<List<Record>> fetchRecords() async {
    final response = await http.get(Uri.parse(
        'https://testing-api-laravel.herokuapp.com/api/getTankLevel'));

    if (response.statusCode == 200) {
      List usersList = jsonDecode(response.body);
      return usersList.map((data) => Record.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    futureRecords = fetchRecords();
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(40),
                margin: EdgeInsets.all(10),
                child: Text(
                  'Past Records',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FutureBuilder<List<Record>>(
                future: futureRecords,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data![index].id.toString()),
                                  Text(snapshot.data![index].value.toString()),
                                  Text(tankString(snapshot.data![index].value)),
                                ],
                              ));
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      const Text('Fetching data from the server'),
                    ],
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
