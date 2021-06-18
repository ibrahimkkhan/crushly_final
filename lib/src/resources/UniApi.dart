import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/University.dart';

class UniApi {
  String key = "AIzaSyBJSRyWpqYnpdDSLJmn5cqA0ufWqveOhmo";
  Stream<UniversityList> getUniList(query) async* {
    String api =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&fields=name,geometry&type=university&region=us&key=$key";
    print('query uni is $query');
    var res = await http.get(Uri.parse(api));
    var content = res.body;
    print('content uni is $content');
    try {
      if (res.statusCode == 200) {
        UniversityList universityList =
            UniversityList.fromJson(jsonDecode(content));
        yield universityList;
      }
    } catch (e) {
      print(e);
    }
  }
}
