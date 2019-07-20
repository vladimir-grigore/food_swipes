import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder<List<Response>>(
            future: fetchResponse(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.network(snapshot.data[index].res["recipe"]["image"], height: 100.0,),
                            Text(snapshot.data[index].res["recipe"]["label"].toString()),
                          ],
                        ),
                        Divider(),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class Response {
  LinkedHashMap<String, dynamic> res;

  Response({this.res});
}

Future<List<Response>> fetchResponse() async {
  final response = await http.get('https://api.edamam.com/search?q=chicken&app_id=920ad99d&app_key=c72ed1dd6f491f0dd48abc8ff7b1905f');
  // print(response.body);
  LinkedHashMap<String, dynamic> responseJson = json.decode(response.body.toString());
  List<Response> responseList = createResponseList(responseJson);

  return responseList;
}

List<Response> createResponseList(LinkedHashMap<String, dynamic> data) {
  List<Response> list = new List();
  List hits = data["hits"];

  for(int i=0; i < hits.length; i++) {
    Response resp = new Response(res: hits[i]);
    list.add(resp);
  }

  return list;
}