import 'dart:collection';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:food_swipes/Api/ApiResponse.dart';

Future<List<ApiResponse>> fetchResponse(query) async {
  var appId = DotEnv().env['APP_ID'];
  var appKey = DotEnv().env['APP_KEY'];

  final response = await http.get('https://api.edamam.com/search?q=$query&app_id=$appId&app_key=$appKey');
  
  if(response.statusCode == 200) {
    LinkedHashMap<String, dynamic> responseJson = json.decode(response.body.toString());
    List<ApiResponse> responseList = createResponseList(responseJson);
    return responseList;
  } else {
    throw Exception('Failed to get recipes');
  }
}

List<ApiResponse> createResponseList(LinkedHashMap<String, dynamic> data) {
  List<ApiResponse> list = new List();
  List hits = data["hits"];

  for(int i=0; i < hits.length; i++) {
    ApiResponse resp = new ApiResponse(res: hits[i]);
    list.add(resp);
  }

  return list;
}