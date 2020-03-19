import 'package:infineon_floodmonitoring/models/data_models/floodData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FloodCard extends StatelessWidget {
  final FloodData _floodData;
  FloodCard(this._floodData);

  Widget _buildTempPressRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            //temperature
            child: Text("Temperature: ${_floodData.temperature}"),
          ),
          Flexible(
            child: SizedBox(
              width: 8.0,
            ),
          ),
          Flexible(
            child: Text("Pressure is: ${_floodData.pressure}"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(_floodData.time);
    final int unixstamp = int.parse(_floodData.time);

    final f = new DateFormat('yyyy-MM-dd hh:mm a');
    String time;

    //Text(f.format(new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000)));
    time = f.format(
        new DateTime.fromMillisecondsSinceEpoch(unixstamp * 1000)); //* 1000

    //print("unixTime stamo is : " + unixstamp.toString());
    // final currentTime =
    //     DateTime.fromMillisecondsSinceEpoch(unixstamp, isUtc: true);
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
                'Sensor location is at ${_floodData.address}'), //named address previously known as location
            padding: EdgeInsets.all(20.0),
          ),
          _buildTempPressRow(),
          SizedBox(height: 10.0),
          Text("Time Recorded: $time"),
          SizedBox(
            height: 10.0,
          ),
          Text("Coordinates is : ${_floodData.coordinates}")
        ],
      ),
    );
  }
}
