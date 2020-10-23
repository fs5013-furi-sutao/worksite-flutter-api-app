import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter_restapi/models/worksites.dart';

class ApiService {
  final String apiUrl = "http://10.0.2.2:8080/api/v1/worksites"; // for emulator
  // final String apiUrl = "http://localhost:8080/api/v1/worksites";  // Android 実機用

  Future<List<Worksites>> getWorksites() async {
    Response res = await get(apiUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(res.bodyBytes));
      List<Worksites> cases =
          body.map((dynamic item) => Worksites.fromJson(item)).toList();
      return cases;
    }
    throw "現場情報一覧の取得に失敗しました";
  }

  Future<Worksites> getWorksiteById(String id) async {
    final res = await get('$apiUrl/$id');

    if (res.statusCode == 200) {
      return Worksites.fromJson(json.decode((utf8.decode(res.bodyBytes))));
    } else {
      throw Exception('ID による現場情報の読み込みに失敗しました');
    }
  }

  Future<Worksites> createWorksite(Worksites worksites) async {
    Map data = {
      'name': worksites.name,
      'subName': worksites.subName,
      'type': worksites.type,
      'staffName': worksites.staffName,
      'photo': worksites.photo,
      'address': worksites.address,
      'status': worksites.status,
      'startAt': worksites.startAt,
      'endAt': worksites.endAt,
    };

    final Response res = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (res.statusCode == 200) {
      return Worksites.fromJson(json.decode((utf8.decode(res.bodyBytes))));
    }
    throw Exception('現場情報を登録しました');
  }

  Future<Worksites> updateWorksite(int id, Worksites worksites) async {
    Map data = {
      'id': worksites.id,
      'name': worksites.name,
      'subName': worksites.subName,
      'type': worksites.type,
      'staffName': worksites.staffName,
      'photo': worksites.photo,
      'address': worksites.address,
      'status': worksites.status,
      'startAt': worksites.startAt,
      'endAt': worksites.endAt,
    };

    final Response res = await put(
      '$apiUrl/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (res.statusCode == 200) {
      return Worksites.fromJson(json.decode((utf8.decode(res.bodyBytes))));
    }
    throw Exception('現場情報の更新に失敗しました');
  }

  Future<void> deleteWorksite(int id) async {
    Response res = await delete('$apiUrl/$id');

    if (res.statusCode == 200) {
      print('現場情報を削除しました（現場 ID: $id）');
      return;
    }
    throw "現場情報の削除に失敗しました（現場 ID: $id）";
  }
}
