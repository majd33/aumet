import 'dart:convert';

import 'package:aumet_task/models/uni.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class UniData extends ChangeNotifier{
  List<University> uniList=[];

  Future getData(String country)async{

    var res= await http.get(Uri.parse("http://universities.hipolabs.com/search?country=$country"));
    var bodyJson= jsonDecode(res.body);
    bodyJson.forEach((element) {
      uniList.add(University.fromJson(element));
    });

    notifyListeners();
  }
}