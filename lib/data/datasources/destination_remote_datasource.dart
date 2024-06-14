import 'dart:convert';

import 'package:course_travel/api/urls.dart';
import 'package:course_travel/core/error/exception.dart';
import 'package:course_travel/data/models/destination_model.dart';
import 'package:http/http.dart' as http;

abstract class DestinationRemoteDatasource {
  Future<List<DestinationModel>> all();
  Future<List<DestinationModel>> top();
  Future<List<DestinationModel>> search(String query);
}

class DestincationRemoterDarasourceImpl implements DestinationRemoteDatasource {
  final http.Client client;

  DestincationRemoterDarasourceImpl({required this.client});

  @override
  Future<List<DestinationModel>> all() async{
    Uri url = Uri.parse('${URLs.base}/destination/all.php');
    final responses = await client.get(url).timeout(const Duration(seconds: 5));
    if (responses.statusCode == 200) {
      List lists = jsonDecode(responses.body);
      return lists.map((e) => DestinationModel.fromJson(e)).toList();
    } else if (responses.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DestinationModel>> search(String query) async{
    Uri url = Uri.parse('${URLs.base}/destination/search.php');
    final responses = await client.post(url, body: {
      'query': query
    }).timeout(const Duration(seconds: 5));
    if (responses.statusCode == 200) {
      List lists = jsonDecode(responses.body);
      return lists.map((e) => DestinationModel.fromJson(e)).toList();
    } else if (responses.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DestinationModel>> top() async{
    Uri url = Uri.parse('${URLs.base}/destination/top.php');
    final responses = await client.get(url).timeout(const Duration(seconds: 5));
    if (responses.statusCode == 200) {
      List lists = jsonDecode(responses.body);
      return lists.map((e) => DestinationModel.fromJson(e)).toList();
    } else if (responses.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}