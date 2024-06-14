import 'dart:convert';

import 'package:course_travel/core/error/exception.dart';
import 'package:course_travel/data/models/destination_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cacheAllDestinationKey = 'all_destination';

abstract class DestinationLocalDatasource {
  Future<List<DestinationModel>> getAll();
  Future<bool> cacheAll(List<DestinationModel> list);
}

class DestinationLocalDatasourceImpl implements DestinationLocalDatasource {
  final SharedPreferences pref;

  DestinationLocalDatasourceImpl({required this.pref});

  @override
  Future<bool> cacheAll(List<DestinationModel> list) async{
    List<Map<String,dynamic>> listMap = list.map((e) => e.toJson()).toList();
    String allDestination = jsonEncode(listMap);
    return pref.setString(cacheAllDestinationKey, allDestination);
  }

  @override
  Future<List<DestinationModel>> getAll() async{
    String? alldestinations = pref.getString(cacheAllDestinationKey); 
    if (alldestinations != null) {
      List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>.from(jsonDecode(alldestinations));
      return listMap.map((e) => DestinationModel.fromJson(e)).toList();
    }

    throw CachedException();
  }

}