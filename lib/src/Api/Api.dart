import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:crushly/models/BaseOtherUser.dart';
import 'package:crushly/models/BasePeople.dart';
import 'package:crushly/models/BasePhoto.dart';
import 'package:crushly/models/BaseSearch.dart';
import 'package:crushly/models/BaseUser.dart';
import 'package:crushly/models/Message.dart';
import 'package:crushly/models/Ring.dart';
import 'package:crushly/models/User.dart';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'dart:io';

class Api {
  Api._();

  static final Api apiClient = Api._();
  static final http.Client _httpClient = http.Client();

  static const BaseUrl =
      "http://ec2-18-222-51-32.us-east-2.compute.amazonaws.com:3000";

  // when open the app if the user is already sign in then get the user info
  Future<Map<String, dynamic>> fetchUser(String id) async {
    try {
      final response = await _httpClient.get(BaseUrl + "/person/$id");

      if (response.statusCode == 200) {
        print(response.body);
        final baseResponse = BaseUser.fromJson(jsonDecode(response.body));
        if (baseResponse.person != null) {
          return {
            "person": baseResponse.person,
            "myfollowees": baseResponse.myfollowees
          };
        } else {
          return Future.error(
              "person is null , response is : $baseResponse"); //this must chang
        }
      }
      if (response.statusCode == 400) {
        return Future.error("user not exist 400");
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e);
    }
  }

// to get info about other user profile
  Future<Map<String, dynamic>> fetchOtherUser(String myId, String id) async {
    try {
      final response = await _httpClient.get(BaseUrl + "/person/$myId/$id");
      if (response.statusCode == 200) {
        print(response.body);
        final baseResponse = BaseOtherUser.fromJson(jsonDecode(response.body));
        if (baseResponse.person != null) {
          return {
            "person": baseResponse.person,
            "orginalUserId": baseResponse.orginalUserId,
            "followed": baseResponse.followed,
            "isDate": baseResponse.isDate,
            "ringStatus": baseResponse.ringStatus,
            "ringStatusOther": baseResponse.ringStatusOther,
            "presentlySecret": baseResponse.presentlySecret
          };
        } else {
          return Future.error(
              "person is null , response is : $baseResponse"); //this must chang
        }
      }
      if (response.statusCode == 400) {
        return Future.error("user not exist");
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e);
    }
  }

  // create new user
  Future<Map<String, dynamic>> newUser(String name, String token) async {
    final data = {"name": name, "deviceToken": token};
    try {
      final response = await _httpClient.post(BaseUrl + "/person", body: data);
      // print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        final baseResponse = BaseUser.fromJson(jsonDecode(response.body));
        if (baseResponse.person != null) {
          return {
            "person": baseResponse.person,
            "myfollowees": baseResponse.myfollowees
          };
        } else {
          return Future.error("Error"); //this must chang
        }
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException catch (e) {
      return Future.error(e.toString());
    } on http.ClientException catch (e) {
      print(e.message);
      return Future.error(e.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<User>> search(String query, String myId) async {
    try {
      final response =
          await _httpClient.get(BaseUrl + "/search/$myId?query=$query");
      if (response.statusCode == 200) {
        print(response.body);
        final baseResponse = BaseSearch.fromJson(jsonDecode(response.body));
        if (baseResponse.result != null) {
          return baseResponse.result;
        } else {
          return Future.error("Error"); //this must chang
        }
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> setPhoto(File image, String id) async {
    try {
      String extention = p.extension(image.path);
      extention = extention.substring(1);
      print(extention);

      final response = await _httpClient
          .get(BaseUrl + "/photo/upload/$id?contentType=image/$extention");
      if (response.statusCode == 200) {
        print(response.body);
        final baseResponse = BasePhoto.fromJson(jsonDecode(response.body));
        if (baseResponse.url != null) {
          final http.Response d = await _httpClient.put(baseResponse.url,
              headers: {"Content-Type": "image/$extention"},
              body: image.readAsBytesSync());

          if (d.statusCode == 200) {
            final patchResponse = await _httpClient.patch(
                BaseUrl + "/person/$id",
                body: {"profilePhoto": baseResponse.key});
            print(patchResponse.statusCode);
            print(patchResponse.body);
            return BaseUser.fromJson(jsonDecode(patchResponse.body))
                .person
                .profilePhoto;
          }
        } else {
          return Future.error("Error"); //this must chang
        }
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } on http.ClientException {
      //this in case internet problems
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> follow(
      String myId, String otherID, String secret) async {
    final data = {"secret": secret.trim().toLowerCase()};
    bool orginalySecret;
    bool presentlySecret;
    bool otherHadSecret;
    String newName;
    try {
      final response = await _httpClient
          .post(BaseUrl + "/follow/$myId/$otherID", body: data);
      //-1 error
      // 0 followed
      //1 follwed and match
      print(response.body);
      if (response.statusCode == 201) {
        orginalySecret = jsonDecode(response.body)["orignallySecret"] ?? false;
        presentlySecret = jsonDecode(response.body)["presentlySecret"] ?? false;
        otherHadSecret = jsonDecode(response.body)["otherHadSecret"] ?? false;
        newName = jsonDecode(response.body)["name"] ?? "";

        /**this when match{"message":"success","isDate":true,"otherHadSecret":true,"revealTime":1569857769693,"presentlySecret":false,"name":"test1"} */
        /**this when no match{{"message":"success","isDate":false,"orignallySecret":true,"presentlySecret":true,"createdAt":1569858653397}} */
        return {
          "isDate": jsonDecode(response.body)["isDate"],
          "orignallySecret": orginalySecret,
          "presentlySecret": presentlySecret,
          "otherHadSecret": otherHadSecret,
          "newName": newName
        };
      }
      return Future.error("error from network");
    } catch (e) {
      return Future.error("error from network :" + e.toString());
    }
  }

  //this api not used in the app yet
  Future<List<User>> getPeople(String myId) async {
    try {
      final response = await _httpClient.get(BaseUrl + "/people/$myId");

      if (response.statusCode == 200) {
        final baseResponse = BasePeople.fromJson(jsonDecode(response.body));
        if (baseResponse.people != null) {
          return baseResponse.people;
        } else {
          return Future.error("Error");
        }
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException catch (e) {
      print(e.message);
      return Future.error(e.toString());
    } on http.ClientException catch (e) {
      print(e.message);
      return Future.error(e.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> offerRing(String ownerId, String recieverId) async {
    try {
      final response =
          await _httpClient.post(BaseUrl + "/ring/offer/$ownerId/$recieverId");
      print(response.statusCode);

      return response.statusCode == 201;
    } on SocketException {
      return false;
    } on http.ClientException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> acceptRing(
      String reciever, String ringId, String isAccept) async {
    try {
      final response = await _httpClient
          .get(BaseUrl + "/ring/offer/$isAccept/$reciever/$ringId");
      print(response.statusCode);

      return response.statusCode == 200;
    } on SocketException {
      return false;
    } on http.ClientException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelOffer(String ownerId, String recieverId) async {
    try {
      final response = await _httpClient
          .delete(BaseUrl + "/ring/offer/$ownerId/$recieverId");

      return response.statusCode == 200;
    } on SocketException {
      return false;
    } on http.ClientException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> askBackRing(String ownerId, String recieverId) async {
    try {
      final response =
          await _httpClient.patch(BaseUrl + "/ring/offer/$ownerId/$recieverId");
      print(response.body + response.statusCode.toString());
      return true;
    } on SocketException {
      return false;
    } on http.ClientException {
      return false;
    } catch (e) {
      return false;
    }
  }

  //get info about the ring
  Future<Ring> getRing(String ownerId) async {
    try {
      final response = await _httpClient.get(BaseUrl + "/ring/$ownerId");
      print(response.body);
      final Ring ring = Ring.fromJson(jsonDecode(response.body)["ring"]);
      if (ring != null) {
        return ring;
      } else {
        return Future.error("Error"); //this must chang
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> returnRing(String reciverId, String ringId) async {
    try {
      final response =
          await _httpClient.post(BaseUrl + "/ring/return/$reciverId/$ringId");
      print(response.body);

      return true;
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //get the unread messages when the user become online
  Future<Map<String, dynamic>> getQueues(String myId) async {
    try {
      final response = await _httpClient.get(BaseUrl + "/dequeue?id=$myId");
      print(response.body);
      final json = jsonDecode(response.body);

      final List<Message> messages = (json['queues']['messageQueue'] as List)
          ?.map((e) => e == null
              ? null
              : Message(
                  (e as Map<String, dynamic>)["message"],
                  12546845, //! what thissssssssssssssssssssssssssssssssssssssssssss
                  (e as Map<String, dynamic>)["isRead"],
                  (e as Map<String, dynamic>)["Author"],
                  (e as Map<String, dynamic>)["reciever"]))
          ?.toList();
      final List<User> followees = (json['queues']['followeeQueue'] as List)
          ?.map((e) => e == null
              ? null
              : User(
                  id: (e as Map<String, dynamic>)["_id"],
                  name: (e as Map<String, dynamic>)["name"],
                  orignallySecret:
                      (e as Map<String, dynamic>)["orignallySecret"],
                  presentlySecret:
                      (e as Map<String, dynamic>)["presentlySecret"],
                  notify: (e as Map<String, dynamic>)["notify"]))
          ?.toList();
      final List<User> revealList = (json['queues']['revealQueue'] as List)
          ?.map((e) => e == null
              ? null
              : User(
                  id: (e as Map<String, dynamic>)["_id"],
                  name: (e as Map<String, dynamic>)["name"],
                  orignallySecret:
                      (e as Map<String, dynamic>)["orignallySecret"],
                  presentlySecret:
                      (e as Map<String, dynamic>)["presentlySecret"],
                  revealTime: (e as Map<String, dynamic>)["revealTime"],
                  nickName: (e as Map<String, dynamic>)["nickName"],
                  notify: (e as Map<String, dynamic>)["notify"]))
          ?.toList();
      final List<User> dateList = (json['queues']['dateQueue'] as List)
          ?.map((e) => e == null
              ? null
              : User(
                  id: (e as Map<String, dynamic>)["_id"],
                  name: (e as Map<String, dynamic>)["name"],
                  orignallySecret:
                      (e as Map<String, dynamic>)["orignallySecret"],
                  presentlySecret:
                      (e as Map<String, dynamic>)["presentlySecret"],
                  notify: (e as Map<String, dynamic>)["notify"]))
          ?.toList();
      if (messages != null && followees != null) {
        return {
          "messages": messages,
          "followees": followees,
          "reveal": revealList,
          "date": dateList
        };
      } else {
        return Future.error("Error");
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> newStory(String userId, String text, bool forever,
      String imagePath, ByteData imageData) async {
    try {
      String extention = p.extension(imagePath);
      extention = extention.substring(1);
      final response = await _httpClient
          .get(BaseUrl + "/photo/upload/$userId?contentType=image/$extention");
      if (response.statusCode == 200) {
        print(response.body);
        final baseResponse = BasePhoto.fromJson(jsonDecode(response.body));
        if (baseResponse.url != null) {
          final http.Response d = await _httpClient.put(baseResponse.url,
              headers: {"Content-Type": "image/$extention"},
              body: imageData.buffer.asUint8List());

          print(d.statusCode);
          var map = {
            "text": text,
            "url": baseResponse.key,
            "forever": "$forever"
          };
          if (d.statusCode == 200) {
            final response = await _httpClient
                .post(BaseUrl + "/post/new/$userId", body: map);
            print(response.statusCode);

            if (response.statusCode == 200) {
              return true;
            } else {
              return Future.error("Error"); //this must chang
            }
          }
          return Future.error("Error");
        }
        return Future.error("Error");
      }
      return Future.error("Error");
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> reveal(String myId, String revealTo) async {
    try {
      final response = await _httpClient
          .post(BaseUrl + "/person/revealation/$myId/$revealTo");
      print(response.body);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return false;
      // return Future.error(e.toString());
    }
  }

  Future<String> block(String myId, String blockId) async {
    try {
      final response =
          await _httpClient.post(BaseUrl + "/person/block/$myId/$blockId");
      print(response.body);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return Future.error("Error"); //this must chang
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
