import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/models/worksites.dart';
import 'detailwidget.dart';
import 'services/api_service.dart';

class WorksitesList extends StatefulWidget {
  final List<Worksites> worksites;
  WorksitesList({Key key, this.worksites}) : super(key: key);

  @override
  _CasesListState createState() => _CasesListState();
}

class _CasesListState extends State<WorksitesList> {
  _CasesListState();

  final ApiService api = ApiService();
  List<dynamic> _isSet;
  List<dynamic> _image;
  int _itemLength = 0;

  @override
  Widget build(BuildContext context) {
    if (this._itemLength != widget.worksites.length) {
      setState(() {
        this._itemLength = widget.worksites.length;
        this._isSet = new List.generate(this._itemLength, (i) => false);
        this._image = []..length = this._itemLength;
      });
    }

    return ListView.builder(
        itemCount: widget.worksites == null ? 0 : widget.worksites.length,
        itemBuilder: (BuildContext context, int index) {
          if (!_isSet[index]) {
            _image[index] = Image.memory(
              base64Decode(widget.worksites[index].photo),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            );
            _isSet[index] = true;
          }

          return Card(
              child: InkWell(
            onTap: () {
              var result = Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailWidget(widget.worksites[index])),
              );
              result.then((value) => {
                    if (value)
                      {
                        print(value),
                        setState(() {
                          this._isSet = null;
                          this._isSet =
                              new List.generate(this._itemLength, (i) => false);
                          this.build(context);
                        })
                      }
                  });
            },
            child: ListTile(
              // leading: Icon(Icons.person),
              leading: _image[index] != null ? _image[index] : null,
              title: Text(widget.worksites[index].name),
              subtitle: Text(widget.worksites[index].staffName),
            ),
          ));
        });
  }
}
