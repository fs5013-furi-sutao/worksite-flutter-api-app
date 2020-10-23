import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'my_text_field_date_picker.dart';
import 'services/api_service.dart';
import 'models/worksites.dart';

enum Types { news, renovation, others }
enum Status { waiting, working, pending, completed }

class AddDataWidget extends StatefulWidget {
  AddDataWidget();

  @override
  _AddDataWidgetState createState() => _AddDataWidgetState();
}

class _AddDataWidgetState extends State<AddDataWidget> {
  _AddDataWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id;
  final _nameController = TextEditingController();
  final _subNameController = TextEditingController();
  String types = '1: 新築';
  Types _types = Types.news;
  final _staffNameController = TextEditingController();
  final _addressController = TextEditingController();
  String status = '1: 未着手';
  Status _status = Status.waiting;
  String _startAt;
  String _endAt;

  File _image;
  final picker = ImagePicker();

  Image _photo;
  bool _isSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('現場追加'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child: Row(children: <Widget>[
                                Text('現場名'),
                              ])),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: '現場名称を入力してください',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '現場名称を入力してください';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child: Row(children: <Widget>[
                                Text('施工箇所'),
                              ])),
                              TextFormField(
                                controller: _subNameController,
                                decoration: const InputDecoration(
                                  hintText: '施工箇所を入力してください',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '施工箇所を入力してください';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child: Row(children: <Widget>[
                                Text('種別'),
                              ])),
                              ListTile(
                                title: const Text('1: 新築'),
                                leading: Radio(
                                  value: Types.news,
                                  groupValue: _types,
                                  onChanged: (Types value) {
                                    setState(() {
                                      _types = value;
                                      types = '1';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('2: 新築'),
                                leading: Radio(
                                  value: Types.renovation,
                                  groupValue: _types,
                                  onChanged: (Types value) {
                                    setState(() {
                                      _types = value;
                                      types = '2';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('3: その他'),
                                leading: Radio(
                                  value: Types.others,
                                  groupValue: _types,
                                  onChanged: (Types value) {
                                    setState(() {
                                      _types = value;
                                      types = '3';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child: Row(children: <Widget>[
                                Text('担当者'),
                              ])),
                              TextFormField(
                                controller: _staffNameController,
                                decoration: const InputDecoration(
                                  hintText: '担当者を入力してください',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '担当者を入力してください';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: Row(children: <Widget>[
                                Text('現場写真'),
                              ])),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: 300,
                                    child: _image == null
                                        ? Text('写真が選択されていません')
                                        : Image.file(_image)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FloatingActionButton(
                                    onPressed: getImageFromCamera,
                                    tooltip: 'カメラから画像を取得',
                                    child: Icon(Icons.add_a_photo),
                                  ),
                                  //           FloatingActionButton(
                                  //             onPressed:
                                  //                 getImageFromGallery,
                                  //             tooltip: 'ギャラリーから画像を取得',
                                  //             child: Icon(Icons.photo_library),
                                  //           ),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Text('Gender'),
                        //       ListTile(
                        //         title: const Text('Male'),
                        //         leading: Radio(
                        //           value: Gender.male,
                        //           groupValue: _gender,
                        //           onChanged: (Gender value) {
                        //             setState(() {
                        //               _gender = value;
                        //               gender = 'male';
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       ListTile(
                        //         title: const Text('Female'),
                        //         leading: Radio(
                        //           value: Gender.female,
                        //           groupValue: _gender,
                        //           onChanged: (Gender value) {
                        //             setState(() {
                        //               _gender = value;
                        //               gender = 'female';
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Text('Age'),
                        //       TextFormField(
                        //         controller: _ageController,
                        //         decoration: const InputDecoration(
                        //           hintText: 'Age',
                        //         ),
                        //         keyboardType: TextInputType.number,
                        //         validator: (value) {
                        //           if (value.isEmpty) {
                        //             return 'Please enter age';
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (value) {},
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child: Row(children: <Widget>[
                                Text('住所'),
                              ])),
                              TextFormField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  hintText: '住所を入力してください',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '住所を入力してください';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Text('City'),
                        //       TextFormField(
                        //         controller: _cityController,
                        //         decoration: const InputDecoration(
                        //           hintText: 'City',
                        //         ),
                        //         validator: (value) {
                        //           if (value.isEmpty) {
                        //             return 'Please enter city';
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (value) {},
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Text('Country'),
                        //       TextFormField(
                        //         controller: _countryController,
                        //         decoration: const InputDecoration(
                        //           hintText: 'Country',
                        //         ),
                        //         validator: (value) {
                        //           if (value.isEmpty) {
                        //             return 'Please enter country';
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (value) {},
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child: Row(children: <Widget>[
                                Text('ステータス'),
                              ])),
                              ListTile(
                                title: const Text('1: 未着手'),
                                leading: Radio(
                                  value: Status.waiting,
                                  groupValue: _status,
                                  onChanged: (Status value) {
                                    setState(() {
                                      _status = value;
                                      status = '1';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('2: 進行中'),
                                leading: Radio(
                                  value: Status.working,
                                  groupValue: _status,
                                  onChanged: (Status value) {
                                    setState(() {
                                      _status = value;
                                      status = '2';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('3: 保留'),
                                leading: Radio(
                                  value: Status.pending,
                                  groupValue: _status,
                                  onChanged: (Status value) {
                                    setState(() {
                                      _status = value;
                                      status = '3';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('4: 完了'),
                                leading: Radio(
                                  value: Status.completed,
                                  groupValue: _status,
                                  onChanged: (Status value) {
                                    setState(() {
                                      _status = value;
                                      status = '4';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Column(children: <Widget>[
                              MyTextFieldDatePicker(
                                labelText: "開始日（予定日）",
                                prefixIcon: Icon(Icons.date_range),
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                lastDate: DateTime.parse('2030-10-01'),
                                firstDate: DateTime.parse('1990-10-01'),
                                initialDate: _startAt == null
                                    ? null
                                    : DateTime.parse(_startAt),
                                onDateChanged: (selectedDate) {
                                  DateFormat outputFormat =
                                      DateFormat("yyyy-MM-dd");
                                  this._startAt = outputFormat
                                      .format(selectedDate); // 2019-08-18
                                },
                              ),
                            ])),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                            child: Column(children: <Widget>[
                              MyTextFieldDatePicker(
                                labelText: "終了日（予定日）",
                                prefixIcon: Icon(Icons.date_range),
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                lastDate: DateTime.parse('2030-10-01'),
                                firstDate: DateTime.parse('1990-10-01'),
                                initialDate: _endAt == null
                                    ? null
                                    : DateTime.parse(_endAt),
                                onDateChanged: (selectedDate) {
                                  DateFormat outputFormat =
                                      DateFormat("yyyy-MM-dd");
                                  this._endAt = outputFormat
                                      .format(selectedDate); // 2019-08-18
                                },
                              ),
                            ])),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Text('Status'),
                        //       ListTile(
                        //         title: const Text('Positive'),
                        //         leading: Radio(
                        //           value: Status.positive,
                        //           groupValue: _status,
                        //           onChanged: (Status value) {
                        //             setState(() {
                        //               _status = value;
                        //               status = 'positive';
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       ListTile(
                        //         title: const Text('Dead'),
                        //         leading: Radio(
                        //           value: Status.dead,
                        //           groupValue: _status,
                        //           onChanged: (Status value) {
                        //             setState(() {
                        //               _status = value;
                        //               status = 'dead';
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       ListTile(
                        //         title: const Text('Recovered'),
                        //         leading: Radio(
                        //           value: Status.recovered,
                        //           groupValue: _status,
                        //           onChanged: (Status value) {
                        //             setState(() {
                        //               _status = value;
                        //               status = 'recovered';
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (_addFormKey.currentState.validate()) {
                                    _addFormKey.currentState.save();

                                    List<int> imageBytes =
                                        _image.readAsBytesSync();
                                    String base64Image =
                                        base64Encode(imageBytes);

                                    api.createWorksite(Worksites(
                                      name: _nameController.text,
                                      subName: _subNameController.text,
                                      type: types,
                                      staffName: _staffNameController.text,
                                      photo: base64Image,
                                      address: _addressController.text,
                                      status: status,
                                      startAt: _startAt,
                                      endAt: _endAt,
                                    ));

                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('保存する',
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);

      List<int> imageBytes = _image.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      debugPrint(baseimage);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
}
