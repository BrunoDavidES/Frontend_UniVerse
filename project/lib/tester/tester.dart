import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:UniVerse/tester/consts/api_consts.dart';

import 'package:UniVerse/tester/utils/UserData.dart';
import 'package:UniVerse/tester/utils/FeedData.dart';
import 'package:UniVerse/tester/utils/ReportData.dart';
import 'package:UniVerse/tester/utils/DepartmentData.dart';
import 'package:UniVerse/tester/utils/ModifyAttributesData.dart';
import 'package:UniVerse/tester/utils/NucleusData.dart';
import 'package:UniVerse/tester/utils/PersonalEventsData.dart';

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

  Future<void> oldLogin(UserData data) async {
    const url = loginUrl;

    final headers = {
      'Content-Type': 'application/json',
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: requestBody
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('User logged in with ID: $id');
      } else {
        print('Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
    print('Error occurred while logging in: $e');
    }
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
        body: requestBody
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

    final String requestBody = jsonEncode(filters);

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody
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

  Future<void> registerDepartment(String token, DepartmentData data) async {
    const String apiUrl = '$departmentUrl/register';

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
        print('Register successful with ID: $id');
      } else {
        print('Register failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while registering department: $e');
    }
  }

  Future<void> modifyDepartment(String token, DepartmentData data) async {
    const String apiUrl = '$departmentUrl/modify';

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
        print('Modify successful with ID: $id');
      } else {
        print('Modify failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while modifying department: $e');
    }
  }

  Future<void> deleteDepartment(String token, String id) async {
    final String apiUrl = '$departmentUrl/delete/$id';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Delete successful with ID: $id');
      } else {
        print('Delete failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while deleting department: $e');
    }
  }

  Future<void> queryDepartment(String token, String limit, String offset, Map<String, String> filters) async {
    const String apiUrl = '$departmentUrl/query';

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
      print('Error occurred while querying department: $e');
    }
  }

  Future<void> addMemberDepartment(String token, String id, DepartmentData data) async {
    final String apiUrl = '$departmentUrl/add/member/$id';

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
        print('Add member successful with ID: $id');
      } else {
        print('Add member failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while adding member to department : $e');
    }
  }

  Future<void> deleteMembersDepartment(String token, String id, DepartmentData data) async {
    final String apiUrl = '$departmentUrl/delete/member/$id';

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
        print('Remove member successful with ID: $id');
      } else {
        print('Remove member failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while removing member from department : $e');
    }
  }

  Future<void> editMembersDepartment(String token, String id, DepartmentData data) async {
    final String apiUrl = '$departmentUrl/edit/member/$id';

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
        print('Edit member successful with ID: $id');
      } else {
        print('Edit member failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while editing member from department : $e');
    }
  }

  Future<void> modifyAttributesUser(String token, ModifyAttributesData data) async {
    const String apiUrl = '$modifyUrl/attributes';

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
        print('Modify user attributes successful with ID: $id');
      } else {
        print('Modify user attributes failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while modifying user attributes: $e');
    }
  }

  Future<void> modifyRoleUser(String token, ModifyAttributesData data) async {
    const String apiUrl = '$modifyUrl/role';

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
        print('Modify user role successful with ID: $id');
      } else {
        print('Modify role user failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while modifying user role: $e');
    }
  }

  Future<void> deleteUser(String token, ModifyAttributesData data) async {
    const String apiUrl = '$modifyUrl/delete';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Delete user successful with ID: $id');
      } else {
        print('Delete user failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while deleting user: $e');
    }
  }
  Future<void> registerNucleus(String token, NucleusData data) async {
    const String apiUrl = '$nucleusUrl/register';

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
        print('Register successful with ID: $id');
      } else {
        print('Register failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while registering nucleus: $e');
    }
  }

  Future<void> modifyNucleus(String token, NucleusData data) async {
    const String apiUrl = '$nucleusUrl/modify';

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
        print('Modify successful with ID: $id');
      } else {
        print('Modify failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while modifying nucleus: $e');
    }
  }

  Future<void> deleteNucleus(String token) async {
    const String apiUrl = '$departmentUrl/delete';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.delete(
          Uri.parse(apiUrl),
          headers: headers
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Delete successful with ID: $id');
      } else {
        print('Delete failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while deleting nucleus: $e');
    }
  }

  Future<void> queryNucleus(String token, String limit, String offset, Map<String, String> filters) async {
    const String apiUrl = '$nucleusUrl/query';

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
      print('Error occurred while querying nucleus: $e');
    }
  }

  Future<void> addMembersNucleus(String token, String id, NucleusData data) async {
    final String apiUrl = '$nucleusUrl/add/members/$id';

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
        print('Add members successful with ID: $id');
      } else {
        print('Add members failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while adding members to nucleus : $e');
    }
  }

  Future<void> deleteMembersNucleus(String token, String id, NucleusData data) async {
    final String apiUrl = '$nucleusUrl/delete/members/$id';

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
        print('Remove members successful with ID: $id');
      } else {
        print('Remove members failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while removing members from nucleus : $e');
    }
  }

  Future<void> getProfile(String token, String username) async {
    final String apiUrl = '$profileUrl/$username';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Get profile successful with ID: $id');
      } else {
        print('Get profile failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while getting profile : $e');
    }
  }

  Future<void> addPersonalEvent(String token, String id, PersonalEventsData data) async {
    const String apiUrl = '$profileUrl/personalEvent/add';

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
        print('Add personal event successful with ID: $id');
      } else {
        print('Add personal event failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while adding personal event : $e');
    }
  }

  Future<void> getPersonalEvent(String token, String title) async {
    final String apiUrl = '$profileUrl/personalEvent/get/$title';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Get personal event successful with ID: $id');
      } else {
        print('Get personal event failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while getting personal event : $e');
    }
  }

  Future<void> editPersonalEvent(String token, String id, String oldTitle, PersonalEventsData data) async {
    final String apiUrl = '$profileUrl/personalEvent/edit/$oldTitle';

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
        print('Edit personal event successful with ID: $id');
      } else {
        print('Edit personal event failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while editing personal event : $e');
    }
  }

  Future<void> deletePersonalEvent(String token, String id, String oldTitle) async {
    final String apiUrl = '$profileUrl/personalEvent/edit/$oldTitle';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.patch(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Delete personal event successful with ID: $id');
      } else {
        print('Delete personal event failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while deleting personal event : $e');
    }
  }

  Future<void> queryUsers(String token, String limit, String offset, Map<String, String> filters) async {
    const String apiUrl = '$profileUrl/query';

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
      print('Error occurred while querying profiles: $e');
    }
  }

  Future<void> countQueryUsers(String token, Map<String, String> filters) async {
    const String apiUrl = '$profileUrl/query';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(filters);

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        print('Query count results: $results');
      } else {
        print('Query count failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while counting query profiles: $e');
    }
  }


}
