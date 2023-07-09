import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

import '../consts/color_consts.dart';
import '../utils/user/user_data.dart';

class FCTTodayWebCard extends StatelessWidget {
  const FCTTodayWebCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  Future<String> fetchTextFile() async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref('hojenafct.txt');
      final response = await ref.getData();
      return String.fromCharCodes(response as Iterable<int>);
    } catch (e) {
      print('Error fetching text file: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: cHeavyGrey.withOpacity(0.4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        height: size.height / 3,
        width: size.width / 2.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 13, bottom: 5),
              child: Text(
                "Hoje na FCT",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder<String>(
              future: fetchTextFile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error fetching file');
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
                    child: Text(
                      snapshot.data ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: cDirtyWhite.withOpacity(0.75),
                        fontSize: 20,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}