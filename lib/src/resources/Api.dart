import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../SharedPref/SharedPref.dart';
import '../models/BaseBlockList.dart';
import '../models/BaseDateList.dart';
import '../models/BaseFollowers.dart';
import '../models/BaseOtherUser.dart';
import '../models/BasePeople.dart';
import '../models/BasePhoto.dart';
import '../models/BaseSearch.dart';
import '../models/Message.dart';
import '../models/NickName.dart';
import '../models/Ring.dart';
import '../models/University.dart';
import '../models/User.dart';
import '../models/base_recommendations.dart';
import '../models/follow_response.dart';
import '../models/recommendation.dart';
import '../models/search_user.dart';
import '../models/settings.dart';
import '../models/profile_status.dart';
import '../models/upload_photo.dart';
import '../models/user_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';

import 'package:http/http.dart' as http;
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Api {
  Api._();

  static final Api apiClient = Api._();
  static final http.Client _httpClient = http.Client();

  static const testId = '5e1a0d7f1e0dd868dd225152';
  static const BaseUrl =
      "http://ec2-3-13-224-176.us-east-2.compute.amazonaws.com:3002";

  // when open the app if the user is already sign in then get the user info
  Future<User> fetchUser(String id) async {
    try {
      //TODO return the api call with the user id
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('jwt token is $token');
      final response = await _httpClient.get(Uri.parse(BaseUrl + "/person"),
          headers: {"Authorization": "Bearer $token"});
      print(id);
      print(response.body);
      if (response.statusCode == 200) {
        final baseResponse = User.fromJson(jsonDecode(response.body)["person"]);
        if (baseResponse != null) {
          return baseResponse;
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

  Future<User> getMyInfo() async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('jwt token is $token');

      final response = await _httpClient.get(Uri.parse(
        BaseUrl + "/person"),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('API => getMyInfo => statusCode     = ${response.statusCode}');
      print('API => getMyInfo => body           = ${response.body}');

      print(response.body);
      if (response.statusCode == 200) {
        final userResponse = User.fromJson(jsonDecode(response.body)["person"]);
        print(
            'API => getMyInfo => userResponse name       = ${userResponse.name}');
        print(
            'API => getMyInfo => userResponse university = ${userResponse.university}');
        print(
            'API => getMyInfo => userResponse birthday = ${userResponse.birthday}');
        if (userResponse != null) {
          print('API => getMyInfo => NOT NULL');
          return userResponse;
        } else {
          print('API => getMyInfo => NULL');
          return Future.error(
              "person is null , response is : $userResponse"); //this must chang
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
  Future<BaseOtherUser> fetchOtherUser(String id) async {
    try {
      print('fetchOtherUser => URL = ' + BaseUrl + "/person/$id");
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('jwt token is $token');
      final response = await _httpClient.get(Uri.parse(
        BaseUrl + "/person/$id"),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        final baseResponse = BaseOtherUser.fromJson(jsonDecode(response.body));
        print('baseREsponse $baseResponse');
        if (baseResponse != null) {
          return baseResponse;
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
      print('baseREsponse error $e');
      return Future.error(e);
    }
  }

  Future<User> relationWithOtherUser(String otherUserID) async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('other user ${otherUserID} tplem $token');
      print('$BaseUrl/relation/$otherUserID');
      final response = await _httpClient.get(Uri.parse(BaseUrl + "/relation/$otherUserID"),
          headers: {'Authorization': 'Bearer $token'});
      print(response.statusCode);
      print('respones is ${response.body}');
      print('respones is ${response.statusCode}');
      if (response.statusCode == 200) {
        final baseResponse = User.fromJson(jsonDecode(response.body));
        if (baseResponse != null) {
          baseResponse.id = otherUserID;
          return baseResponse;
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

  Future<User> loginUser({String email, String password, String token}) async {
    Map<String, dynamic> data = {};
    print('firebase token $token');
    if (token != null) {
      data = {
        "email": email.toLowerCase(),
        "deviceToken": token,
        "password": password,
      };
    } else {
      data = {
        "email": email.toLowerCase(),
        "deviceToken": "none",
        "password": password,
      };
    }
    print('data $data');
    try {
      final response =
          await _httpClient.post(Uri.parse(BaseUrl + "/authentication/login"), body: data);
      print(response.statusCode);
      print('respones is ${response.body}');
      print('respones is ${response.statusCode}');
      if (response.statusCode == 200) {
        final baseResponse = User.fromJson(jsonDecode(response.body)["result"]);
        if (baseResponse != null) {
          return baseResponse;
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

  // create new user
  Future<User> newUser({
    String firstName,
    String lastName,
    String email,
    String greekHouse,
    University university,
    String gender,
    String interestedIn,
    String token,
    String password,
    String dateOfBirth,
    double lat,
    double lng,
  }) async {
    print('date is date $dateOfBirth');
    Map<String, dynamic> data = {};
    if (token != null) {
      data = {
        "firstName": firstName.toLowerCase(),
        "lastName": lastName.toLowerCase(),
        "email": email.toLowerCase(),
        "gender": checkGender(gender.toLowerCase()),
        "intrestedIn": checkGender(interestedIn.toLowerCase()),
        "deviceToken": token.toLowerCase(),
        "dob": dateOfBirth,
        "password": password.toLowerCase(),
      };
    } else {
      data = {
        "firstName": firstName.toLowerCase(),
        "lastName": lastName.toLowerCase(),
        "email": email.toLowerCase(),
        "gender": checkGender(gender.toLowerCase()),
        "intrestedIn": checkGender(interestedIn.toLowerCase()),
        "deviceToken": "none",
        "dob": dateOfBirth,
        "password": password.toLowerCase(),
      };
    }
    if (university != null) {
      data.addAll({
        "university": university == null ? null : university.name.toLowerCase(),
        "placeId": university == null || null == university.placeId
            ? "0"
            : university.placeId,
        "uniLng": university == null || null == university.lng
            ? "0"
            : university.lng.toDouble().toString(),
        "uniLat": university == null || null == university.lat
            ? "0"
            : university.lat.toDouble().toString(),
      });
    }
    if (greekHouse != null && greekHouse.isNotEmpty)
      data.addAll({
        "greekHouse": greekHouse,
      });
    try {
      print('Sign Up Data: $data');
      final response = await _httpClient.post(Uri.parse(
        BaseUrl + "/authentication/register/email"),
        body: data,
      );
      print(response.statusCode);
      print('respones is ${response.body}');
      print('respones is ${response.statusCode}');
      if (response.statusCode == 200) {
        final baseResponse = User.fromJson(jsonDecode(response.body)["result"]);
        if (baseResponse != null) {
          return baseResponse;
        } else {
          return Future.error("Error"); //this must chang
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

  String checkGender(String name) {
    if (name.toLowerCase() == 'man') {
      return 'male';
    } else if (name.toLowerCase() == 'woman' || name.toLowerCase() == 'women') {
      return 'female';
    } else {
      return 'other';
    }
  }

  Future<List<SearchUser>> search(String query, int page) async {
    try {
      print('API => search => url = ' +
          BaseUrl +
          "/search?query=${query.toLowerCase()}&page=$page");

      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response = await _httpClient.get(Uri.parse(
        BaseUrl + "/search/?query=${query.toLowerCase()}&page=$page"),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('API => search => statusCode = ${response.statusCode}');
      print('API => search => response = $response');
      if (response.statusCode == 200) {
        print(response.body);
        try {
          final baseResponse = BaseSearch.fromJson(jsonDecode(response.body));

          if (baseResponse.result != null) {
            return baseResponse.result;
          } else {
            return Future.error("Error"); //this must chang
          }
        } catch (e) {
          print('e is $e');
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

  //converting asset to file
  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();
    print('byteData is : $byteData');

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    print('tempFile is : $tempFile');
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    print('File is : ${file.path}');
    return file;
  }

  Future<List<String>> setPhotos(List<UploadPhoto> uploadPhotos) async {
    final List<String> imagesURLs = [];
    Map<String, String> mapBody = {};
    Map<String, UploadPhoto> imagesBody = {};

    for (UploadPhoto uploadPhoto in uploadPhotos) {
      print('image name is ${uploadPhoto.image.name}');
      String extension = p.extension(uploadPhoto.image.name);
      extension = extension.substring(1);
      print(extension);
      if (extension.toLowerCase() == 'jpg') extension = 'jpeg';
      if (extension.toLowerCase() == 'heic' ||
          extension.toLowerCase() == 'heif') {
        extension = 'jpg';
        print("Heic type cached");
        File image = await getImageFileFromAssets(uploadPhoto.image);
        print('path is ${image.path}');
        String jpgVersion =
            await HeicToJpg.convert(image.path).catchError((err) {
          print('Error is : $err');
        });
        print("Heic format converted to JPG, $jpgVersion");
        uploadPhoto.image = File(jpgVersion);
        print('Converted upload photo is: ${uploadPhoto.image}');
      }
      mapBody['${uploadPhoto.index}'] = 'image/$extension';
      imagesBody['${uploadPhoto.index}'] = uploadPhoto;
    }
    final user = await SharedPref.pref.getUser();
    final token = user.jwtToken;
    // print('jwt token is $token');
    print('map body is $mapBody');
    print('images body is $imagesBody.');
    try {
      final response = await _httpClient.post(Uri.parse(
        BaseUrl + "/photo/upload"),
        body: mapBody,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('Photo Upload Response Code: ${response.statusCode}');
      print(response.body);
      if (response.statusCode == 200) {
        final List<BasePhoto> photosList = [];
        for (dynamic item in json.decode(response.body) as List<dynamic>) {
          final basePhoto = BasePhoto.fromJson(item);
          photosList.add(basePhoto);
          imagesURLs.add(basePhoto.url);
        }
        if (photosList != null && photosList.isNotEmpty) {
          for (BasePhoto basePhoto in photosList) {
            print('sending data extension ${mapBody['${basePhoto.number}']}');
            final buffer =
                (await imagesBody['${basePhoto.number}'].image.getByteData())
                    .buffer
                    .asUint8List();

            // final taskId = await uploader.enqueue(
            //   url: basePhoto.url,
            //   files: [
            //     FileItem(
            //       filename: uploadPhotos.elementAt(0).image.name,
            //       savedDir: uploadPhotos.elementAt(0).image,
            //       fieldname: "file",
            //     ),
            //   ],
            //   method: UploadMethod.PUT,
            //   headers: {
            //     "Content-Type": "image/${mapBody['${basePhoto.number}']}"
            //   },
            //   tag: "upload 1",
            // );

            final http.Response d = await _httpClient.put(
              Uri.parse(basePhoto.url),
              headers: {
                "Content-Type": "image/${mapBody['${basePhoto.number}']}"
              },
              body: buffer,
            );
            print('d status code is ${d.statusCode}');
            print('d data is ${d.body}');
            if (d.statusCode != 200) {
              return Future.error("Error"); //this must chang
            }
          }
          await SharedPref.pref.setImagesUploaded();
          print('images is ${imagesURLs}');
          return imagesURLs;
        } else {
          return Future.error("Error"); //this must chang
        }
      }
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
      print('image path is ${image.path}');
      String extension = p.extension(image.path);
      print('Extension is ${extension}');
      extension = extension.substring(1);
      print(extension);

      final response = await _httpClient
          .get(Uri.parse(BaseUrl + "/photo/upload/$id?contentType=image/$extension"));
      if (response.statusCode == 200) {
        print(response.body);
        final baseResponse = BasePhoto.fromJson(jsonDecode(response.body));
        if (baseResponse.url != null) {
          final http.Response d = await _httpClient.put(Uri.parse(baseResponse.url),
              headers: {"Content-Type": "image/$extension"},
              body: image.readAsBytesSync());

          if (d.statusCode == 200) {
            final patchResponse = await _httpClient.patch(Uri.parse(
                BaseUrl + "/person/$id"),
                body: {"profilePhoto": baseResponse.key});
            print(patchResponse.statusCode);
            print(patchResponse.body);
            return User.fromJson(jsonDecode(patchResponse.body)).profilePhoto;
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

// todo
  Future<FollowResponse> follow(
      String myId, String otherId, String isSecret) async {
    try {
      final data = {
        "secret": isSecret,
      };

      print('API => follow => URL = ${BaseUrl + "/follow/$otherId"}');
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response = await _httpClient
          .post(Uri.parse(BaseUrl + "/follow/$otherId"), body: data, headers: {
        'Authorization': 'Bearer $token',
      });
      print('API => follow => statusCode = ${response.statusCode}');
      print('API => follow => body       = ${response.body}');

      // -1 error
      // 0 followed
      // 1 followed and match
      print(response.body);
      if (response.statusCode == 201) {
        final followResponse =
            FollowResponse.fromJson(jsonDecode(response.body));
        print(
            'API => follow => deserialized successfully :), followResponse = $followResponse');
        return followResponse;
//        orginalySecret = jsonDecode(response.body)["orignallySecret"] ?? false;
//        presentlySecret = jsonDecode(response.body)["presentlySecret"] ?? false;
//        otherHadSecret = jsonDecode(response.body)["otherHadSecret"] ?? false;
//        newName = jsonDecode(response.body)["name"] ?? "";
//
//        /**this when match{"message":"success","isDate":true,"otherHadSecret":true,"revealTime":1569857769693,"presentlySecret":false,"name":"test1"} */
//        /**this when no match{{"message":"success","isDate":false,"orignallySecret":true,"presentlySecret":true,"createdAt":1569858653397}} */
//        return {
//          "isDate": jsonDecode(response.body)["isDate"],
//          "orignallySecret": orginalySecret,
//          "presentlySecret": presentlySecret,
//          "otherHadSecret": otherHadSecret,
//          "newName": newName
//        };
      }
      return Future.error("error from network");
    } catch (e) {
      print('API => follow => ERROR = $e');
      return Future.error("error from network :" + e.toString());
    }
  }

  //this api not used in the app yet
  Future<List<User>> getPeople(String myId) async {
    try {
      final response = await _httpClient.get(Uri.parse(BaseUrl + "/people/$myId"));

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
          await _httpClient.post(Uri.parse(BaseUrl + "/ring/offer/$ownerId/$recieverId"));
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
          .get(Uri.parse(BaseUrl + "/ring/offer/$isAccept/$reciever/$ringId"));
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
          .delete(Uri.parse(BaseUrl + "/ring/offer/$ownerId/$recieverId"));

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
          await _httpClient.patch(Uri.parse(BaseUrl + "/ring/offer/$ownerId/$recieverId"));
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

  Future<bool> logout() async {
    try {
      SharedPref.pref.setIntroShown(false);
      final token = (await SharedPref.pref.getUser()).jwtToken;
      final response =
          await _httpClient.post(Uri.parse(BaseUrl + '/authentication/logout'), headers: {
        'Authorization': 'Bearer $token',
      });
      print('response is ${response.statusCode}');
      print('response isss ${response.body}');
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      print('e is $e');
      return false;
    }
  }

  //get info about the ring
  Future<Ring> getRing(String ownerId) async {
    try {
      final response = await _httpClient.get(Uri.parse(BaseUrl + "/ring/$ownerId"));
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
          await _httpClient.post(Uri.parse(BaseUrl + "/ring/return/$reciverId/$ringId"));
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
      print('API => getQueues => connecting..');
      final response = await _httpClient.get(Uri.parse(BaseUrl + "/dequeue?id=$myId"));
      print('API => getQueues => statusCode = ${response.statusCode}');
      print('API => getQueues => body       = ${response.body}');

      final json = jsonDecode(response.body);

      final List<Message> messages = (json['queues']['messageQueue'] as List)
          ?.map((e) => e == null
              ? null
              : Message(
                  (e as Map<String, dynamic>)["message"],
                  DateTime.parse((e as Map<String, dynamic>)["createdAt"])
                      .millisecondsSinceEpoch,
                  (e as Map<String, dynamic>)["isRead"],
                  (e as Map<String, dynamic>)["author"],
                  (e as Map<String, dynamic>)["reciever"]))
          ?.toList();
      final List<User> followees = (json['queues']['followeeQueue'] as List)
          ?.map((e) => e == null
              ? null
              : User(
                  id: (e as Map<String, dynamic>)["_id"],
                  createdAt: DateTime.parse(
                      (e as Map<String, dynamic>)["createdAt"] as String),
                  name: (e as Map<String, dynamic>)["name"],
                  orignallySecret:
                      (e as Map<String, dynamic>)["orignallySecret"],
                  presentlySecret:
                      (e as Map<String, dynamic>)["presentlySecret"],
                  thumbnail: (e as Map<String, dynamic>)["thumbnail"],
                  notify: (e as Map<String, dynamic>)["notify"]))
          ?.toList();
      final List<User> revealList = (json['queues']['revealQueue'] as List)
          ?.map((e) => e == null
              ? null
              : User(
                  id: (e as Map<String, dynamic>)["revealerId"],
                  name: (e as Map<String, dynamic>)["name"],
                  orignallySecret:
                      (e as Map<String, dynamic>)["orignallySecret"],
                  presentlySecret:
                      (e as Map<String, dynamic>)["presentlySecret"],
                  createdAt: DateTime.parse(
                      (e as Map<String, dynamic>)["createdAt"] as String),
                  nickName: (e as Map<String, dynamic>)["nickName"],
                  thumbnail: (e as Map<String, dynamic>)["thumbnail"],
                  notify: (e as Map<String, dynamic>)["notify"]))
          ?.toList();
      final List<User> blockedList = (json['queues']['blockedByQueue'] as List)
          ?.map((e) =>
              e == null ? null : User(id: (e as Map<String, dynamic>)['_id']))
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
      print('API => getQueues => messages   = $messages');
      print('API => getQueues => followees  = $followees');
      print('API => getQueues => revealList = $revealList');
      print('API => getQueues => dateList   = $dateList');
      print('API => getQueues => dateList   = $blockedList');

      if (messages != null && followees != null) {
        return {
          "messages": messages,
          "followees": followees,
          "reveal": revealList,
          "date": dateList,
          "blocked": blockedList,
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
          .get(Uri.parse(BaseUrl + "/photo/upload/$userId?contentType=image/$extention"));
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
                .post(Uri.parse(BaseUrl + "/post/new/$userId"), body: map);
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

  Future<bool> blockUser(String otherUserID) async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      print('user id  is $otherUserID');
      final response = await _httpClient.post(
          Uri.parse(BaseUrl + "/block/$otherUserID"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('API => block => rstatusCode = ${response.statusCode}');
      print('API => block => body        = ${response.body}');

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

  Future<bool> reveal(String revealTo) async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response = await _httpClient
          .post(Uri.parse(BaseUrl + "/person/revealation/$revealTo"), headers: {
        'Authorization': 'Bearer $token',
      });
      print('API => reveal => rstatusCode = ${response.statusCode}');
      print('API => reveal => body        = ${response.body}');

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

//  Future<bool> block(String blockId) async {
//    try {
//      final user = await SharedPref.pref.getUser();
//      final token = user.jwtToken;
//      print('token is $token');
//      final response =
//          await _httpClient.post(BaseUrl + "/person/block/$blockId", headers: {
//        'Authorization': 'Bearer $token',
//      });
//      print(response.body);
//
//      if (response.statusCode == 200) {
//        return true;
//      } else {
//        return false; //this must chang
//      }
//    } on SocketException {
//      return Future.error("Network Error");
//    } on http.ClientException {
//      return Future.error("Network Error");
//    } catch (e) {
//      return Future.error(e.toString());
//    }
//  }

  Future<List<User>> getBlockList(String myId) async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response = await _httpClient.get(Uri.parse(BaseUrl + "/block"), headers: {
        'Authorization': 'Bearer $token',
      });
      print(response.body);

      if (response.statusCode == 200) {
        List<User> users =
            BaseBlockList.fromJson(jsonDecode(response.body)).list;
        if (users != null) {
          return users;
        }
        return Future.error(response.body);
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

  Future<bool> unBlock(String otherId) async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');

      final response =
          await _httpClient.delete(Uri.parse(BaseUrl + "/block/$otherId"), headers: {
        'Authorization': 'Bearer $token',
      });
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
      return Future.error(e.toString());
    }
  }

  Future<List<User>> getMyCrushes(int page) async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response = await _httpClient.get(
          Uri.parse(BaseUrl + "/search/follow?list=1&page=${page.toString()}"),
          headers: {
            'Authorization': 'Bearer $token',
          });
      print(response.body);
      if (response.statusCode == 200) {
        var result = BaseFollowers.fromJson(jsonDecode(response.body)["result"])
            .followList;
        return result ?? [];
      } else {
        return Future.error(response.statusCode);
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<User>> getCrushees(String myId, int page) async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response = await _httpClient.get(
          Uri.parse(BaseUrl + "/search/follow?list=2&page=${page.toString()}"),
          headers: {
            'Authorization': 'Bearer $token',
          });
      print(response.body);
      if (response.statusCode == 200) {
        return BaseFollowers.fromJson(jsonDecode(response.body)["result"])
                .myfollowees ??
            [];
      } else {
        return Future.error(response.statusCode);
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<User>> getDateUsers(int page) async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response = await _httpClient.get(
          Uri.parse(BaseUrl + "/search/follow?list=3&page=${page.toString()}"),
          headers: {
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        print(response.body);
        return BaseDateList.fromJson(jsonDecode(response.body)["result"])
                .dateList ??
            [];
      } else {
        return Future.error(response.statusCode);
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<User>> inListSearch(int listNum, int page, String query) async {
    print("page : $page");
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      if (query.isNotEmpty) {
        final response = await _httpClient.get(Uri.parse(
            BaseUrl +
                "/search/follow/?list=$listNum&page=${page.toString()}&query=${query.toLowerCase()}"),
            headers: {
              'Authorization': 'Bearer $token',
            });
        if (response.statusCode == 200) {
          print(response.body);
          if (listNum == 3) {
            return BaseDateList.fromJson(jsonDecode(response.body)["result"])
                    .dateList ??
                [];
          } else {
            return BaseFollowers.fromJson(jsonDecode(response.body)["result"])
                    .followList ??
                [];
          }
        } else {
          return Future.error(response.statusCode);
        }
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<NickName>> getNickNames(int amount) async {
    try {
      final response =
          await _httpClient.get(Uri.parse("https://uinames.com/api/?amount=$amount"));
      if (response.statusCode == 200) {
        print(response.body);
        var json = jsonDecode(response.body);
        return (json as List)
            ?.map((e) => e == null ? null : NickName.fromJson(e))
            ?.toList();
      } else {
        return Future.error(response.statusCode);
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Recommendation>> getRecommendations() async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response =
          await _httpClient.get(Uri.parse(BaseUrl + '/recommendation'), headers: {
        'Authorization': 'Bearer $token',
      });
      print('API => getRecommendations => response = ${response.body}');

      if (response.statusCode == 200) {
        final recommendations =
            BaseRecommendations.fromJson(jsonDecode(response.body))
                .recommendations;
        print('API => getRecommendations => parsed successfully :)');
        if (recommendations != null) {
          print(
              'API => getRecommendations => length = ${recommendations.length}');
          return recommendations;
        } else
          return Future.error("Error");
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      final response = await _httpClient.get(
          Uri.parse(BaseUrl + '/authentication/emailexists?email=${email.toLowerCase()}'));
      print('API => checkIfEmailExists => response = ${response.body}');

      if (response.statusCode == 200) {
        print('API => getRecommendations => parsed successfully :)');
        return true;
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<UserPreview> getUserPreview(String otherUserId) async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response =
          await _httpClient.get(Uri.parse(BaseUrl + '/follow/$otherUserId'), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final baseResponse = UserPreview.fromJson(jsonDecode(response.body));
        if (baseResponse != null) {
          return baseResponse;
        } else {
          return Future.error("Error");
        }
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<int> postResetEmailCheck(email) async {
    //check if email is exist
    Map<String, dynamic> data = {
      "email": email,
    };

    print('data $data');

    final response = await _httpClient.post(
        Uri.parse(Api.BaseUrl + "/authentication/sendotp"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: data);
    print('response ${response.statusCode}');
    print('response ${response.body}');
    try {
      return response.statusCode;
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<int> postOTP(otp, email) async {
    //check if email is exist
    Map<String, dynamic> data = {"email": email, "otp": otp};

    final response = await _httpClient.post(
        Uri.parse(Api.BaseUrl + "/authentication/verifyotp"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: data);
    try {
      print(response.body);
      return response.statusCode;
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<User> postSetNewPassword(email, otp, password) async {
    //check if email is exist
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String token = await _firebaseMessaging.getToken();
    Map<String, dynamic> data = {
      "email": email,
      "otp": otp,
      "password": password,
      "deviceToken": token
    };

    print('data is $data');

    final response = await _httpClient.post(
        Uri.parse(Api.BaseUrl + "/authentication/resetpassnlogin"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: data);
    print('test ${response.statusCode}');
    print('test ${response.body}');

    try {
      print(response.body);
      if (response.statusCode == 200) {
        final baseResponse = User.fromJson(jsonDecode(response.body)["result"]);
        if (baseResponse != null) {
          return baseResponse;
        } else {
          return Future.error("Error"); //this must chang
        }
      }
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<int> passwordReset(oldPassword, newPassword) async {
    Map<String, dynamic> data = {
      'currentPass': oldPassword,
      'newPass': newPassword,
    };
    print(data);
    final user = await SharedPref.pref.getUser();
    final token = user.jwtToken;
    final response =
        await _httpClient.post(Uri.parse(BaseUrl + "/authentication/changepassword"),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              'Authorization': 'Bearer $token',
            },
            body: data);
    try {
      print(response.body);
      return response.statusCode;
    } on SocketException {
      return Future.error("Network Error");
    } on http.ClientException {
      return Future.error("Network Error");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<ProfileStatus> getProfileStatus() async {
    try {
      final user = await SharedPref.pref.getUser();
      final token = user.jwtToken;
      print('token is $token');
      final response = await _httpClient.get(Uri.parse(BaseUrl + '/settings'), headers: {
        'Authorization': 'Bearer $token',
      });
      print('API => getProfileStatus => response = ${response.body}');

      if (response.statusCode == 200) {
        final profileStatus =
            Settings.fromJson(jsonDecode(response.body)).profileStatus;

        print('API => getProfileStatus => parsed successfully :)');
        // print('PROFILE STATUS: ${profileStatus.morePhotosRequired}');

        if (profileStatus != null) {
          return profileStatus;
        } else
          return Future.error("Error");
      }
      return Future.error("Server Error : ${response.statusCode}");
    } on SocketException {
      print('Status SocketException');
      return Future.error("Network Error");
    } on http.ClientException {
      print('Status ClientException');
      return Future.error("Network Error");
    } catch (e) {
      print('Status Other Exception');
      return Future.error(e.toString());
    }
  }
}
