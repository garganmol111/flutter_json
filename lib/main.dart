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
  String _filePath;
  void getFilePath() async {
    try {
        String filePath = await FilePicker.getFilePath(type: FileType.ANY);
        if (filePath == '') {
          return;
        }
        print("File path: " + filePath);
        setState((){this._filePath = filePath;});
    } on PlatformException catch (e) {
        print("Error while picking the file: " + e.toString());
      }
    }

  List data;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Contacts"),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getFilePath,
        tooltip: "Select file",
        child: new Icon(Icons.sd_storage),
      ),
      body: new Container( 
        child: new Center(
          child: new FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString(_filePath),
            builder: (context, snapshot) {
              //Decode Json
              var mydata = jsonDecode(snapshot.data.toString());
              
              return new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget> [ 
                        new Text("Name: "+mydata[index]['name']),
                        new Text("Contact no.: "+mydata[index]['cno']),
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