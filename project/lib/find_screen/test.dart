import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            color: Colors.black,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 10.0),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'TEST',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 60.0,
                  ),

                  //User INFO

                  SingleChildScrollView(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 180.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(75.0),
                              topRight: Radius.circular(75.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 20.0,
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 30.0,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      //greeting text
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'TEST',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      //app work

                                      Column(
                                        children: <Widget>[
                                          Container(
                                            height: 150,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 150,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 150,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 150,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 150,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 150,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 150,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      )

                                      //add button
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}