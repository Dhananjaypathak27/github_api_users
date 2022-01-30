import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://api.github.com/users";
  List? data;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  Future<String?> getJsonData() async {
    var response = await http.get(Uri.parse(url));
    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("github api"),
      ),
      body: ListView.builder(
        itemCount: data?.length ?? 0,
        itemBuilder: (BuildContext contex, int index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text("${data?[index]["login"]}"),
                  subtitle: Text("${data?[index]["url"]}"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
