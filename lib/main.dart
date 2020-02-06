import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HTTP Get example",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final String url = "https://swapi.co/api/people";
  List data;
  @override
  void initState(){
    super.initState();
    this.getJson();
  }

  Future<String> getJson () async{
      var response =  await http.get(
        Uri.encodeFull(url),
        headers: {"accept": "application/json"}
      );
      print(response.body);
      setState(() {
        var myData = json.decode(response.body);
        data = myData["results"];
      });
      return "success";
  }


  Widget CustomCard(var display_data){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
          child: RaisedButton(
            color: Colors.white,
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text(
                        "Details"
                      ),
                      content: Container(
                        alignment: Alignment.topLeft,
                        height: 100,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                 display_data["name"],
                               ),
                            Text(
                                display_data["gender"],
                            ),
                            Text(
                                display_data["height"]
                            ),
                            Text(
                                display_data["mass"]
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            },
            child: Text(
              display_data["name"]
            ),
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HTTP Get"
        ),
      ),
      body: ListView.builder(
          itemCount: data ==  null? 0: data.length,
          itemBuilder: (BuildContext context, int index){
            return CustomCard(data[index]);
        },
      )
    );
  }
}


