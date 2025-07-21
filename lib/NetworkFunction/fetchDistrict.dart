import 'dart:convert';
import '../Api/api.dart';
import 'package:http/http.dart' as http;
import '../Model/district_model.dart';
import '../Model/state_model.dart';

Future<List<DistrictModel>> fetchDistrict() async{

  var response = await http.get(
    Uri.parse("https://tdtlworld.com/bharatAI-backend/bharatai/get_district/"),
  );

  try{
    final resp = json.decode(response.body);
    List<DistrictModel> listOfDistrictName=[];
    if( response.statusCode==200) {
      listOfDistrictName = resp['data'].map<DistrictModel>((item) {
        return DistrictModel.fromJson(item);
      }).toList();

    }
    return listOfDistrictName;
  }catch(e){
    print(e);
    rethrow;
  }
}