import 'package:flutter/material.dart';
import 'package:flutter_restapi/adddatawidget.dart';
import 'dart:async';
import 'package:flutter_restapi/services/api_service.dart';
import 'package:flutter_restapi/worksiteslist.dart';

import 'models/worksites.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '現場管理アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '現場情報一覧'),
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
  final ApiService api = ApiService();
  List<Worksites> worksitesList;

  @override
  Widget build(BuildContext context) {
    if(worksitesList == null) {
      worksitesList = List<Worksites>();
    }

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: new Container(
        child: new Center(
            child: new FutureBuilder(
              future: loadList(),
              builder: (context, snapshot) {
                return worksitesList.length > 0? new WorksitesList(worksites: worksitesList):
                new Center(child:
                new Text('データがみつかりません。＋ ボタンを押すことでデータを追加できます', style: Theme.of(context).textTheme.title));
              },
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }

  Future loadList() {
    Future<List<Worksites>> futureWorksites = api.getWorksites();
    futureWorksites.then((worksitesList) {
      setState(() {
        this.worksitesList = worksitesList;
      });
    });
    return futureWorksites;
  }

  _navigateToAddScreen (BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}
