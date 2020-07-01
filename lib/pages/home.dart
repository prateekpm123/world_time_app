import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print('data from the world_time page is $data');

    // set background

    String bgImage = data['isDay'] ? 'day.jpg' : 'night.jpg';
    Color bgColor = data['isDay'] ? Colors.blue[200] : Colors.blueGrey[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120 ,0, 0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'isDay': result['isDay'],
                        };
                      });
                    }, 
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color:  Color.fromRGBO(123, 123, 112, 0.5),
                    padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 30.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),                    
                    ], 
                  ),
                  SizedBox(height: 20),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 60,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}