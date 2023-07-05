import 'package:UniVerse/consts/api_consts.dart';

class Management {

  /*Future<void> addMemberToDepartment(String id, DepartmentData data) async {
    final String apiUrl = '$baseUrl/department/add/member/$id';

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
  }*/

  /*Future<void> deleteMembersDepartment(String token, String id, DepartmentData data) async {
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
  }*/

  /*Future<void> editMembersDepartment(String token, String id, DepartmentData data) async {
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
  }*/


}