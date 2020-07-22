import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/global.dart';
import 'models/Student.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            myLocationButtonEnabled: false,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 400),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                height: 50,
                width: 300,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "What are you looking for?",
                      hintStyle: TextStyle(fontFamily: 'Gotham', fontSize: 15),
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 550, bottom: 50),
            child: ListView(
              padding: EdgeInsets.only(left: 20),
              children: getStudentsInArea(),
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      )),
    );
  }

  List<Student> getTechies() {
    List<Student> techies = [];
    for (int i = 0; i < 10; i++) {
      AssetImage profilePic = new AssetImage("lib/assets/profile.png");
      Student myTechy = new Student(
          "Aditya TG",
          "7904939805",
          "First road 23 elm street",
          529.3,
          4,
          "Available",
          profilePic,
          "2nd year");
      techies.add(myTechy);
    }
    return techies;
  }

  List<Widget> getStudentsInArea() {
    List<Student> techies = getTechies();
    List<Widget> cards = [];
    for (Student techy in techies) {
      cards.add(StudentCard(techy));
    }
    return cards;
  }
}

Map statusStyles = {
  'Available': statusAvailableStyle,
  'Unavailable': statusUnavailableStyle
};

Widget StudentCard(Student Student) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(right: 20),
    width: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
      boxShadow: [
        new BoxShadow(
          color: Colors.grey,
          blurRadius: 20.0,
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: CircleAvatar(
                backgroundImage: Student.profilePic,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Student.name,
                  style: techCardTitleStyle,
                ),
                Text(
                  Student.occupation,
                  style: techCardSubTitleStyle,
                )
              ],
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            children: <Widget>[
              Text(
                "Status:  ",
                style: techCardSubTitleStyle,
              ),
              Text(Student.status, style: statusStyles[Student.status])
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Rating: " + Student.rating.toString(),
                    style: techCardSubTitleStyle,
                  )
                ],
              ),
              Row(children: getRatings(Student))
            ],
          ),
        )
      ],
    ),
  );
}

List<Widget> getRatings(Student techy) {
  List<Widget> ratings = [];
  for (int i = 0; i < 5; i++) {
    if (i < techy.rating) {
      ratings.add(new Icon(Icons.star, color: Colors.yellow));
    } else {
      ratings.add(new Icon(Icons.star_border, color: Colors.black));
    }
  }
  return ratings;
}
