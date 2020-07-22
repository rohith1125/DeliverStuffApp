import 'package:flutter/material.dart';

class Student {
  String name;
  String phoneNum;
  String blockNum;
  double rate;
  String status;
  int rating;
  AssetImage profilePic;
  String occupation;

  Student(this.name, this.phoneNum, this.blockNum, this.rate, this.rating,
      this.status, this.profilePic);
}
