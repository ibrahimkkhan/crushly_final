class UniversityList {
  late List<University> uniList;

  UniversityList({
    required this.uniList,
  });

  UniversityList.fromJson(Map<String, dynamic> json) {
    List<University> uniList=[];

    json['results'].forEach((value) {
      uniList.add(University.fromJson(value));
    });
  }
}

class University {
  String? name;
  String? placeId;
  double? lat;
  double? lng;

  University({
    this.name,
    this.lat,
    this.lng,
    this.placeId,
  });

  University.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    placeId = json['id'];
    lat = json['geometry']['location']['lat'];
    lng = json['geometry']['location']['lng'];
  }
}
