import 'dart:convert';
import 'dart:io';
import 'package:UniVerse/bars/dialog_test.dart';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/users/users_local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/users/User.dart';

class Report {
  static bool isCompliant(String title, String location, String description) {
    return title.isEmpty || location.isEmpty || description.isEmpty ? false : true;
  }

  /*static bool fileExists(File image) {

  }*/

  static Future<int> send(String title, String location, String description) async {
    final response = await http.post(
      Uri.parse(baseUrl + reportUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Cookie': 'token=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3VuaXZlcnNlLWZjdC5vYS5yLmFwcHNwb3QuY29tLyIsImp0aSI6ImM3M2E2OThlLWQ1MDYtNDVmNi1hMjM5LTBkYWNiODQ2NGVhZiIsImlhdCI6MTY4NzAyMTk2NiwiZXhwIjoxNjg3MDI5MTY2LCJyb2xlIjoiQk8iLCJuYW1lIjoiQmFuYW5hIiwidXNlciI6IjY2NjY2In0.AeASSsPLrSRkbOrF3MyVZvZg7AMpRx_QZ_2SZ2jvHX6SYZauNXYoh-a2lIgWKCfLGDWEEmTsXIcCMMZgPg0VnW5JJBtJV4O1NX-Vkyt857jeq21wOltLiJ74jhMw2yArce-E2aGyR9OCgtc4pjCC1uaa9VCl1r0X69yFRu1vzPpY3UGMpyHixv5VDgfCb-7_-fNdR3bC4MEydeGQ7077IMlNBtsL89pU7OIHXuBQvbxmw5dXNssXa4SYD4R9ExJ1cLj7MyxiB8yf5JrXoq_aRdXPUQAmHUxjZ1YjrW7UTSCWaMEySvmKLGrz6q4uL_E4RqRqel4YyfbnyW08YRcCJA; Path=/rest/login; HttpOnly; Expires=Sat, 17 Jun 2023 17:22:47 GMT;',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'location': location,
      }),
    );
    if (response.statusCode == 200) {
      var id = response.body;
       //create buckets do file
      }
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

}
