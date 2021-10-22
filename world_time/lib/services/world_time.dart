import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {
  String location = '';
  String time = '';
  String flag = ''; //url for a flag image
  String url = ''; //location url for api
  bool isDaytime = false;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //Make Request
      Response response =
          await get(Uri.https("worldtimeapi.org", "api/timezone/$url"));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDaytime = (now.hour > 6 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("caught error: $e");
      time = "Couldn't get time data";
    }
  }
}
