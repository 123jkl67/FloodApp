import 'dart:async';
import 'dart:convert';
import 'package:infineon_floodmonitoring/models/data_models/floodData.dart';
import 'package:http/http.dart' as http;

//latest stage of development is alphaStage
final String apiStage = "alphaStage"; //set the stage of the api gateway
final String apiLink =
    "Set the api gateway invoke url here"; // set the api link for the apiGateway

// this is to fetch flood data from the api gateway
Future<List<FloodData>> fetchFloodData(String location) async {
  //final List<FloodData> _emptyDataList = [];
  final List<FloodData> _fetchDataList = [];
  try {
    //headers for new API
    Map<String, String> headers = {
      "address": "$location",
      "Content-Type": "application/json"
    };

    ///This is for the new testing api
    http.Response response =
        await http.get("$apiLink/$apiStage/flood", headers: headers);

    //This is for the legacy api //does not work anymore broken

    // http.Response response = await http.get(
    //     "$apiLink/FirstStage/flood/$location");
    //print(json.decode(response.body));

    //print(productListData["flood"]);
    //print(productListData.runtimeType)l;
    // print(productListData["flood"].runtimeType);

    //This is for legacy API version
    // final Map<String, dynamic> productListData = json.decode(response.body);
    // List<dynamic> testData = productListData["floodMonitoring"];

    //This is for the new API Version
    final Map<String, dynamic> productListData = json.decode(response.body);
    List<dynamic> testData = json.decode(productListData["body"]);

    testData.forEach((dynamic floodData) {
      //print(key.runtimeType);
      //print(data.toString());
      final FloodData product = FloodData(
          floodId: floodData["floodId"],
          time: floodData['time'],
          pressure: floodData['pressure'],
          temperature: floodData['temperature'],
          //location: floodData['coordinates'], //fetch the coordinates
          address: floodData['address'], //fetch the named coordiantes address.
          coordinates: floodData['coordinates'],
          waterLevel: floodData['waterLevel']);
      _fetchDataList.add(product);
    });
    print("printing list");
    print(_fetchDataList.toString());
    //store.dispatch(FetchDataSuccess(_fetchDataList));
    _fetchDataList.sort((m1, m2) {
      var r = m1.time.compareTo(m2.time);
      return r;
    });

    return _fetchDataList.reversed.toList();
  } catch (error) {
    print("erroris " + error.toString());
    return Future.error(error);
    //return _emptyDataList;
  }
}

//fetch search results for the app
Future<List<String>> fetchSearchData() async {
  //final List<FloodData> _emptyDataList = [];
  final List<String> _fetchDataList = [];
  try {
    http.Response response = await http.get("$apiLink/$apiStage/groups");
    //print(json.decode(response.body));
    final Map<String, dynamic> productListData = json.decode(response.body);
    //print(productListData["flood"]);
    //print(productListData.runtimeType)l;
    // print(productListData["flood"].runtimeType);
    //change this to the table name i think
    List<dynamic> testData =
        productListData["searchData"]; //changed to searchData
    testData.forEach((dynamic searchData) {
      //print(key.runtimeType);
      //print(data.toString());
      _fetchDataList.add(searchData["location"]);
    });
    //print("printing list");
    //print(_fetchDataList.toString());
    //store.dispatch(FetchDataSuccess(_fetchDataList));
    _fetchDataList.sort((m1, m2) {
      var r = m1.compareTo(m2);
      return r;
    });

    return _fetchDataList;
  } catch (error) {
    print("erroris " + error.toString());
    return Future.error(error);
    //return _emptyDataList;
  }
}
