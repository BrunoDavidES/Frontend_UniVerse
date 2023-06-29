import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:UniVerse/tester/consts/api_consts.dart';

import 'package:UniVerse/tester/utils/FeedData.dart';
import 'package:UniVerse/tester/utils/ReportData.dart';

class Tester {
  Future<String> register(String email, String name, String password, String confirmation) async {
    try {
      final url = Uri.parse(registerUrl);
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'name': name,
          'password': password,
          'confirmation': confirmation,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        await FirebaseAuth.instance.currentUser?.sendEmailVerification();
        return('Registration successful');
      } else {
        return('Registration failed: ${response.body}');
      }
    } catch (error) {
      return('Error occurred during registration: $error');
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return('User not found');
      } else if (e.code == 'wrong-password') {
        return('Wrong password');
      }
    }
    return "Error";
  }

  Future<String> logout() async {
    await FirebaseAuth.instance.signOut();
    return("User logged out.");
  }

  Future<String?> displayToken() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    return token;
  }

  Future<String> sendMessage(String sender, List<String> recipientIds, String message) async {
    try {
      final url = Uri.parse(sendMsgUrl);
      final response = await http.post(
        url,
        body: json.encode({
          'senderId': sender,
          'recipientIds': recipientIds.toList(),
          'message': message,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return ('Message sent successfully');
      } else {
        return ('Failed to send message: ${response.body}');
      }
    } catch (error) {
      return ('Error occurred while sending message: $error');
    }
  }

  Future<void> postFeed(String token, String kind, FeedData data) async {
    final String apiUrl = '$feedsUrl/post/$kind';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Post successful with ID: $id');
      } else {
        print('Post failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while posting feed: $e');
    }
  }

  Future<void> editFeed(String token, String kind, String id, FeedData data) async {
    final String apiUrl = '$feedsUrl/edit/$kind/$id';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final http.Response response = await http.patch(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Update successful with ID: $id');
      } else {
        print('Update failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while updating feed: $e');
    }
  }

  Future<void> deleteFeed(String token, String kind, String id) async {
    final String apiUrl = '$feedsUrl/delete/$kind/$id';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Delete successful with ID: $id');
      } else {
        print('Delete failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while deleting feed: $e');
    }
  }

  Future<void> queryFeed(String token, String kind, String limit, String offset, Map<String, String> filters) async {
    final String apiUrl = '$feedsUrl/query/$kind';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final Uri uri = Uri.parse(apiUrl);
    final Map<String, String> queryParameters = {
      if (limit.isNotEmpty) 'limit': limit,
      if (offset.isNotEmpty) 'offset': offset,
      ...filters.map((key, value) => MapEntry(key, value.toString())),
    };

    try {
      final http.Response response = await http.get(
        uri.replace(queryParameters: queryParameters),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        print('Query results: $results');
      } else {
        print('Query failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while querying feed: $e');
    }
  }

  Future<void> countQueryFeed(String token, String kind, Map<String, String> filters) async {
    final String apiUrl = '$feedsUrl/query/$kind';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final Uri uri = Uri.parse(apiUrl);
    final Map<String, String> queryParameters = {
      ...filters.map((key, value) => MapEntry(key, value.toString())),
    };

    try {
      final http.Response response = await http.get(
        uri.replace(queryParameters: queryParameters),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        print('Count Query results: $results');
      } else {
        print('Count Query failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while counting query feed: $e');
    }
  }

  Future<void> postReport(String token, ReportData data) async {
    const String apiUrl = '$reportUrl/post';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Post successful with ID: $id');
      } else {
        print('Post failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while posting report: $e');
    }
  }

  Future<void> editReport(String token, String id) async {
    final String apiUrl = '$reportUrl/edit/$id';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Edit successful with ID: $id');
      } else {
        print('Edit failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while editing report: $e');
    }
  }

  Future<void> statusReport(String token, String id, String status) async {
    final String apiUrl = '$reportUrl/status/$id/$status';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Status edit successful with ID: $id');
      } else {
        print('Status Eedit failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while editing status report: $e');
    }
  }

  Future<void> queryReports(String token, String limit, String offset, Map<String, String> filters) async {
    const String apiUrl = '$feedsUrl/query';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(filters);

    final Uri uri = Uri.parse(apiUrl);
    final Map<String, String> queryParameters = {
      if (limit.isNotEmpty) 'limit': limit,
      if (offset.isNotEmpty) 'offset': offset,
    };

    try {
      final http.Response response = await http.post(
        uri.replace(queryParameters: queryParameters),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        print('Query results: $results');
      } else {
        print('Query failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while querying reports: $e');
    }
  }

  Future<void> countUnresolvedReports(String token) async {
    const String apiUrl = '$feedsUrl/unresolved';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        print('Unresolved reports count results: $results');
      } else {
        print('Unresolved reports count failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while counting unresolved reports: $e');
    }
  }

}
