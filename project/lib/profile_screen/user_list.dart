import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserListPage extends StatefulWidget {

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UniverseUser> publicUsers = [];
  String cursor = "EMPTY";

  @override
  void initState() {
    super.initState();
    fetchPublicUsers();
  }

  Future<void> fetchPublicUsers() async {
    final limit = '10';
    String token = await Authentication.getTokenID();
    final response = await UniverseUser.queryPublicUsers(token, limit, cursor);

    setState(() {
      publicUsers.addAll(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Users'),
      ),
      body: ListView.builder(
        itemCount: publicUsers.length + 1, // Add 1 for the loading indicator
        itemBuilder: (context, index) {
          if (index < publicUsers.length) {
            return ListTile(
              title: Text(publicUsers[index].email),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
