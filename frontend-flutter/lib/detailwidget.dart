import 'dart:convert';

import 'package:flutter/material.dart';

import 'models/worksites.dart';
import 'services/api_service.dart';
import 'editdatawidget.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget(this.worksites);

  final Worksites worksites;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  _DetailWidgetState();

  final ApiService api = ApiService();
  Image _photo;
  bool _isSet = false;

  Future<void> setPhoto(String source) async {
    if (!_isSet) {
      this.setState(() {
        this._photo = Image.memory(
          base64Decode(source),
          fit: BoxFit.cover,
        );
        this._isSet = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setPhoto(widget.worksites.photo);
    loadCase();
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('現場情報詳細'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Card(
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      width: 440,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '現場名称:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ])),
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(widget.worksites.name,
                                      style: Theme.of(context).textTheme.title)
                                ])),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '施工箇所:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ])),
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(widget.worksites.subName,
                                      style: Theme.of(context).textTheme.title)
                                ])),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Text('種別:',
                                      style: TextStyle(
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ])),
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(getTypeName(widget.worksites.type),
                                      style: Theme.of(context).textTheme.title)
                                ])),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    '担当者:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ])),
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(widget.worksites.staffName,
                                      style: Theme.of(context).textTheme.title)
                                ])),
                              ],
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('Gender:',
                          //           style: TextStyle(
                          //               color: Colors.black.withOpacity(0.8))),
                          //       Text(widget.cases.gender,
                          //           style: Theme.of(context).textTheme.title)
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('Age:',
                          //           style: TextStyle(
                          //               color: Colors.black.withOpacity(0.8))),
                          //       Text(widget.cases.age.toString(),
                          //           style: Theme.of(context).textTheme.title)
                          //     ],
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Text('現場写真:',
                                      style: TextStyle(
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ])),
                                Container(
                                    child: Row(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 300, child: this._photo),
                                  ),
                                ])),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Text('住所:',
                                      style: TextStyle(
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ])),
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(widget.worksites.address,
                                      style: Theme.of(context).textTheme.title)
                                ])),
                              ],
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('City:',
                          //           style: TextStyle(
                          //               color: Colors.black.withOpacity(0.8))),
                          //       Text(widget.cases.city,
                          //           style: Theme.of(context).textTheme.title)
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('Country:',
                          //           style: TextStyle(
                          //               color: Colors.black.withOpacity(0.8))),
                          //       Text(widget.cases.country,
                          //           style: Theme.of(context).textTheme.title)
                          //     ],
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Text('ステータス:',
                                      style: TextStyle(
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ])),
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(getStatusName(widget.worksites.status),
                                      style: Theme.of(context).textTheme.title)
                                ])),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Text('開始日:',
                                      style: TextStyle(
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ])),
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(getDateDisplay(widget.worksites.startAt),
                                      style: Theme.of(context).textTheme.title)
                                ])),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Text('終了日:',
                                      style: TextStyle(
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ])),
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(getDateDisplay(widget.worksites.endAt),
                                      style: Theme.of(context).textTheme.title)
                                ])),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    child: RaisedButton(
                                      splashColor: Colors.red,
                                      onPressed: () {
                                        _navigateToEditScreen(
                                            context, widget.worksites);
                                      },
                                      child: Text('編集する',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(8),
                                      child: RaisedButton(
                                        splashColor: Colors.red,
                                        onPressed: () {
                                          _confirmDialog();
                                        },
                                        child: Text('削除する',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.grey,
                                      )),
                                ])),
                              ],
                            ),
                          ),
                        ],
                      ))),
            ),
          ),
        ));
  }

  Future<void> loadCase() {
    Future<Worksites> futureCases =
        api.getWorksiteById(widget.worksites.id.toString());
    futureCases.then((value) {
      setState(() {
        this.widget.worksites.id = value.id;
        this.widget.worksites.name = value.name;
        this.widget.worksites.subName = value.subName;
        this.widget.worksites.type = value.type;
        this.widget.worksites.staffName = value.staffName;
        this.widget.worksites.address = value.address;
        this.widget.worksites.status = value.status;
        this.widget.worksites.startAt = value.startAt;
        this.widget.worksites.endAt = value.endAt;
      });
    });
  }

  _navigateToEditScreen(BuildContext context, Worksites worksites) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataWidget(worksites)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('本当にこの現場情報を削除しますか？'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('はい'),
              onPressed: () {
                api.deleteWorksite(widget.worksites.id);
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            FlatButton(
              child: const Text('いいえ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String getStatusName(String status) {
    switch (widget.worksites.status) {
      case '1':
        return '1: 未着手';
        break;
      case '2':
        return '2: 進行中';
        break;
      case '3':
        return '3: 保留';
        break;
      case '4':
        return '4: 完了';
        break;
      default:
    }
    return '';
  }

  String getTypeName(String type) {
    switch (widget.worksites.type) {
      case '1':
        return '1: 新築';
        break;
      case '2':
        return '2: 改築';
        break;
      case '3':
        return '3: その他';
        break;
      default:
    }
    return '';
  }

  String getDateDisplay(String date) {
    if (date == null) return '未定';
    return date;
  }
}
