import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as hp;

void main() {
  runApp(MaterialApp(
    home: GetJson(),
  ));
}

class GetJson extends StatefulWidget {
  @override
  _GetJsonState createState() => _GetJsonState();
}

class _GetJsonState extends State<GetJson> {
  var isLoading = true;
  final exp = new List<Models>();
  _getJson() async {
    exp.clear();
    final response =
        await hp.get("https://jsonplaceholder.typicode.com/photos");
    final data = jsonDecode(response.body);
    data.forEach((e) {
      final ep = new Models(
          e['albumId'], e['id'], e['title'], e['url'], e['thumbnailUrl']);
      exp.add(ep);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: exp.length,
              itemBuilder: (context, i) {
                final baru = exp[i];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          baru.url,
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          baru.title,
                          style: TextStyle(fontSize: 20.0),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class Models {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Models(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);
}
