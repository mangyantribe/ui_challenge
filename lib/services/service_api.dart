import '../models/House.dart';
import 'package:http/http.dart' as http;

class ServiceApi{

  final String baseURL = "http://115.84.243.173/amber/api";
  static var client = http.Client();


  Future<List<House>> getUpperHouses() async{
    final response = await client.get(Uri.parse("$baseURL/upper"), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    if(response.statusCode == 200){
      List<House> list = houseFromJson(response.body);
      return list;
    }else{
      return [];
    }
  }

  Future<List<House>> getHouses() async{
    final response = await client.get(Uri.parse("$baseURL/popular"), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    if(response.statusCode == 200){
      List<House> list = houseFromJson(response.body);
      return list;
    }else{
      return [];
    }
  }

}