// // this is to fetch flood datta from the api gateway
// Future<List<FloodData>> fetchFloodData(String location) async {
//   //final List<FloodData> _emptyDataList = [];
//   final List<FloodData> _fetchDataList = [];
//   try {
//     //headers for new API
//     // Map<String, String> headers = {
//     //   "address": "$location",
//     //   "Content-Type": "application/json"
//     // };

//     ///This is for the beta testing api
//     // http.Response response = await http.get(
//     //     "https://7imfq2kmml.execute-api.us-east-1.amazonaws.com/betaStage/flood",
//     //     headers: headers);

//     //This is for the legacy api
//     http.Response response = await http.get(
//         "https://7imfq2kmml.execute-api.us-east-1.amazonaws.com/FirstStage/flood/$location");
//     //print(json.decode(response.body));

//     //print(productListData["flood"]);
//     //print(productListData.runtimeType)l;
//     // print(productListData["flood"].runtimeType);

//     //This is for legacy API version
//     final Map<String, dynamic> productListData = json.decode(response.body);
//     List<dynamic> testData = productListData["floodMonitoring"];

//     //This is for the new beta API Version
//     // final Map<String, dynamic> productListData = json.decode(response.body);
//     // List<dynamic> testData = json.decode(productListData["body"]);

//     testData.forEach((dynamic floodData) {
//       //print(key.runtimeType);
//       //print(data.toString());
//       final FloodData product = FloodData(
//           floodId: floodData["floodId"],
//           time: floodData['time'],
//           pressure: floodData['pressure'],
//           temperature: floodData['temperature'],
//           //location: floodData['coordinates'], //fetch the coordinates
//           address: floodData['address'], //fetch the named coordiantes address.
//           coordinates: floodData['coordinates'],
//           waterLevel: floodData['waterLevel']);
//       _fetchDataList.add(product);
//     });
//     print("printing list");
//     print(_fetchDataList.toString());
//     //store.dispatch(FetchDataSuccess(_fetchDataList));
//     _fetchDataList.sort((m1, m2) {
//       var r = m1.time.compareTo(m2.time);
//       return r;
//     });

//     return _fetchDataList.reversed.toList();
//   } catch (error) {
//     print("erroris " + error.toString());
//     return Future.error(error);
//     //return _emptyDataList;
//   }
// }
