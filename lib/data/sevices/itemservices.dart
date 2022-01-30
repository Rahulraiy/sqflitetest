import 'dart:convert';

import 'package:sqflitetest/data/model/itemresponse.dart';

import 'base_http.dart';

class ItemServices extends AppHttpClient {

  Future<List<ItemResponse>?> loadItems() async {
    try {
      var response = await super.fetch('photos');

      if (response.statusCode == 200) {
        var d = (jsonDecode(response.body) as List)
            .map((e) => ItemResponse.fromJson(e))
            .toList();

        return d;
       // log(d.toString());
      }
    } catch (e) {
      // throw e;
    }

    return null;
  }


}