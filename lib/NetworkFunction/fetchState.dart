import 'dart:convert';
import '../Api/api.dart';
import 'package:http/http.dart' as http;

import '../Model/state_model.dart';

Future<List<StateModel>> fetchState() async{


  var response = await http.get(
      Uri.parse("https://tdtlworld.com/bharatAI-backend/bharatai/get_states/"),
  );

  try{
    final resp = json.decode(response.body);
    List<StateModel> listOfStateName=[];
    if( response.statusCode==200) {
      listOfStateName = resp['data'].map<StateModel>((item) {
        return StateModel.fromJson(item);
      }).toList();
      print(listOfStateName);
    }
    return listOfStateName;
  }catch(e){
    print(e);
    rethrow;
  }
}