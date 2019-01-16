import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JSON APP",
      home: new HomePage()
    );
  }  
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}
 
class HomePageState extends State<HomePage> {
  List data;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Contacts"),
      ),
      body: new Container( 
        child: new Center(
          child: new FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString("load_json/person.json"),
            builder: (context, snapshot) {
              //Decode Json
              var mydata = jsonDecode(snapshot.data.toString());
              
              return new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget> [ 
                        new FlatButton(
                          onPressed: () => {},
                          child: new ConstrainedBox(
                            constraints: new BoxConstraints.tightFor(),
                            child: Row(children: <Widget>[
                              new Image.network(mydata[index]["ico"], height: 30.0, width: 30.0 ),
                              new Text(mydata[index]["item"]+" : "+mydata[index]["price"])
                            ],)
                          )
                          
                        )
                      ]
                    ) 
                  );
                },
                itemCount: mydata == null ? 0: mydata.length,
              );
            }
          )
        )
      )
    );
  }
}