import 'package:sqflitetest/data/sevices/itemservices.dart';

import 'database_helper.dart';
import 'model/item.dart';
import 'model/itemresponse.dart';

class ItemRepository{

  final Itemservice = ItemServices();

  Future<List<ItemResponse>> fetchItemFromApiAndDatabase() async {
  try {
  final items = await Itemservice.loadItems();

  if (items != null) {
  await insertItemsIntoDatabse(items);
  }
  } catch (e) {}

  return await fetchItemsFromDatabse();

}

  Future insertItemsIntoDatabse(List<ItemResponse> items) async{

    final dbUsers = items
        .map((e) => Item(
        id: e.id,
        title: e.title,
        ))
        .toList();
    await DatabaseHelper.instance.insertBasicInfo(dbUsers);

  }

  Future<List<ItemResponse>> fetchItemsFromDatabse() async{

    final dbUsers = await DatabaseHelper.instance.getInfo();

    return List.generate(
        dbUsers.length,
            (index) => ItemResponse(
            id: dbUsers[index].id,
            title: dbUsers[index].title));
  }
  }