import '../resources/Api.dart';
import '../models/User.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';

class BlockListPage extends StatefulWidget {
  final String myId;

  const BlockListPage( this.myId);

  @override
  _BlockListPageState createState() => _BlockListPageState();
}

class _BlockListPageState extends State<BlockListPage> {
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Block List"),),
      body: FutureBuilder<List<User>>(
        future: Api.apiClient.getBlockList(widget.myId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(capitalizeNames(snapshot.data![index].name!)),
                    trailing: FlatButton(
                      child: Text("UnBlock"),
                      onPressed: () async {
                        await Api.apiClient
                            .unBlock(snapshot.data![index].id);
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("no Blocked Users"),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
