import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';

class OrganizationsInfoWeb extends StatelessWidget {
  final String id;
  final List<String> data;

  const OrganizationsInfoWeb({super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var containerHeight = size.height/1.5;
    var containerWidth = size.width/1.5;
    return Container(
      height: containerHeight,
      width: containerWidth,
      color: cDirtyWhite,
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: cHeavyGrey),
            boxShadow: [ BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0,0),
            ),
            ],
            color: cDirtyWhiteColor
        ),
        child: Row(
            children: [
        Container(
        width: containerWidth-containerWidth/3.5-15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15, top: 15, bottom:5),
                child: Text(
                  data[0],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: cHeavyGrey,
                      fontSize: 25
                  ),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(left:15),
                width: double.infinity,
                height: containerHeight/1.5,
                child:SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "OLÁ",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
          Spacer(),
          Container(
              width: containerWidth/3.5-15,
              decoration: BoxDecoration(
              image: DecorationImage(
              image: NetworkImage(data[1]),
          fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(15),
    ),
    ),
            ],
    )
    ),
    );
  }
}