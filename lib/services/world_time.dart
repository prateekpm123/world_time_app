import 'package:http/http.dart';          // An API to talk to websites
import 'dart:convert';                    // Helps convert the json object
import 'package:intl/intl.dart';          // a package to format date and time 

class WorldTime {

  String location;  // location name for the UI
  String time;      // The time in that location  
  String url;       // location url for calling the api like '/london/berlin'
  String flag;      // url to an asset flag icon
  bool isDay;

  WorldTime({ this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from the data 
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      String offsetHrs = data['utc_offset'].substring(1,3);
      String offsetMins = data['utc_offset'].substring(4,6);
      print('Date time is '+datetime);
      print('Offset is '+offset);
      print('offsetMins is '+offsetMins);
      print('offsetHrs is '+offsetHrs);


      // create a Date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHrs), minutes: int.parse(offsetMins)));
      print(now);

      // set the time property
      isDay = now.hour > 6 && now.hour < 20 ? true : false; 
      time = DateFormat.jm().format(now);  // a time package 'intl' to format the date, time
    }
    catch(e) {
      print('OOPS! Looks like we caught an error $e');
      time = "There was an error and we could'nt get time";
    }

    
        
  }


}