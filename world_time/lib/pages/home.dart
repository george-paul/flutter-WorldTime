// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = (data.isNotEmpty)
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    print(data);

    return Scaffold(
      backgroundColor: (data['isDayTime']) ? Colors.white : Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 128, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDayTime': result['isDayTime'],
                      'flag': result['flag'],
                    };
                  });
                },
                icon: Icon(Icons.edit_location_alt_outlined),
                label: Text("Edit Location"),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: GlowIcon(
                  (data['isDayTime'])
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_outlined,
                  color:
                      (data['isDayTime']) ? Colors.yellow[800] : Colors.white60,
                  size: 100,
                  blurRadius: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                      color: (data['isDayTime']) ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                data['time'],
                style: TextStyle(
                  color: (data['isDayTime']) ? Colors.black : Colors.white,
                  fontSize: 66,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
