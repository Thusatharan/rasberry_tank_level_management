import 'dart:convert';

import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/chat_data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _lowstresschatController = TextEditingController();
  int? userId;
  List<ChatData> _chat_data = chat_data;

  // getUserId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   int? id = prefs.getInt('userid');
  //   setState(() {
  //     userId = id;
  //   });
  //   return userId;
  // }

  Future<String> sendMessage(BuildContext context, String text) async {
    String result = "";
    Map data = {"message": text};
    print(data);
    print("encoded--${json.encode(data)}");
    const url = "http://10.0.2.2:5000/chat_bot";
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
          _chat_data.add(ChatData(text: result, senderId: 2));
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
  void initState() {
    // getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 10,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: _chat_data.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: _chat_data[index].senderId == 1
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                _chat_data[index].text,
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      );
                    })),
            Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _lowstresschatController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type Message'),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _chat_data.add(ChatData(
                                    text: _lowstresschatController.text,
                                    senderId: 1));
                              });
                              sendMessage(
                                  context, _lowstresschatController.text);
                            },
                            icon: Icon(Icons.send),
                            color: Color.fromARGB(255, 74, 93, 169),
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
