import '../resources/UniApi.dart';
import '../models/University.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class UserSearchDelegate extends SearchDelegate<University> {
  Function(University) setUniName;
  UniApi uniApi = new UniApi();
  UserSearchDelegate(this.setUniName);

  @override
  String get searchFieldLabel => 'University Name';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: pink,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: pink,
      ),
      onPressed: () {
        close(context,University());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (query.length > 2) {
      return StreamBuilder(
          stream: uniApi.getUniList(query),
          builder: (context, AsyncSnapshot<UniversityList?> snap) {
            UniversityList? universityList = snap.data;
            if (snap.connectionState == ConnectionState.waiting) {
              return Container(
                  height: size.height * 0.003,
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(lightBlue),
                    backgroundColor: Colors.white12,
                  ));
            }

            if (snap.hasData) {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        indent: size.width * 0.07,
                        endIndent: size.width * 0.07,
                        color: lightGrey,
                      ),
                  itemCount: universityList!.uniList.length,
                  itemBuilder: (context, index) {
                    University university = universityList.uniList[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.15, right: size.width * 0.05),
                      child: ListTile(
                        onTap: () {
                          close(context, setUniName(university));
                        },
                        title: Text(
                          university.name!,
                          style: TextStyle(color: lightBlue),
                        ),
                      ),
                    );
                  });
            } else {
              return Container(
                child: Center(
                    child: Text(
                  "No result",
                  style:
                      TextStyle(color: lightBlue, fontSize: size.width * 0.05),
                )),
              );
            }
          });
    } else {
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (query.length > 2) {
      return StreamBuilder(
          stream: uniApi.getUniList(query),
          builder: (context,AsyncSnapshot<UniversityList?> snap) {
            UniversityList? universityList = snap.data;
            if (snap.connectionState == ConnectionState.waiting) {
              return Container(
                  height: size.height * 0.003,
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(lightBlue),
                    backgroundColor: Colors.white12,
                  ));
            }
            if (snap.hasData) {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        indent: size.width * 0.07,
                        endIndent: size.width * 0.07,
                        color: lightGrey,
                      ),
                  itemCount: universityList!.uniList.length,
                  itemBuilder: (context, index) {
                    University university = universityList.uniList[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.15, right: size.width * 0.05),
                      child: ListTile(
                        onTap: () {
                          close(context, setUniName(university));
                        },
                        title: Text(
                          university.name!,
                          style: TextStyle(color: lightBlue),
                        ),
                      ),
                    );
                  });
            } else {
              return Container(
                child: Center(
                    child: Text(
                  "No result",
                  style:
                      TextStyle(color: lightBlue, fontSize: size.width * 0.05),
                )),
              );
            }
          });
    } else {
      return Container();
    }
  }
}
