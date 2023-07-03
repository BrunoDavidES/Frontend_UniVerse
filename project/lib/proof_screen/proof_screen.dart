import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class ProofScreen extends StatelessWidget {
  ProofScreen( {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(left:10, top:40, bottom: 10, right: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [ BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0,0),
          ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {Navigator.pop(context);},
                    color: cHeavyGrey.withOpacity(0.5)),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Faculdade de Ciências e Tecnologia",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:5),
                      child: Text(
                        "Universidade Nova de Lisboa",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer()
              ],
            ),
            SizedBox(height: 5,),
            Image.asset("assets/app/logo_nova_horiz.png", scale: 11,),
            SizedBox(height: 20,),
            Row(
              children: [
                Spacer(),
                Text(
                  "Ano letivo   ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                    color: cHeavyGrey
                  ),
                ),
                Text(
                  "2022/23",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10,)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: size.width/3,
                  height: size.height/4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          scale: 3,
                          fit: BoxFit.fill,
                          image: AssetImage("assets/bill.jpg",)
                      )
                  ),
                ),
                Container(
                  width: size.width/2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bruno Miguel Matias David",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "ALUNO",
                        style: TextStyle(
                            fontSize: 17
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "cc 99999999",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 17
                        ),
                      ),
                      Text(
                        "nº 70000",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 17
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:15, bottom: 5),
              child: Text(
                "Mestrado Integrado em Engenharia Informática",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17
                ),
              ),
            ),
            Image.asset("assets/img.png", scale: 3,),
          ],
        ),

        /*Container(
                      height: 190,
                      child: Column(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {Navigator.pop(context);},
                              color: cDirtyWhiteColor),
                        ],
                      ),
                    )
                  ]
              ),
              Padding(
                padding: const EdgeInsets.only(top:5, left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.data.date!,
                      style: TextStyle(
                          fontSize: 13,
                          color: cHeavyGrey
                      ),
                    ),
                    Spacer(),
                    Text(
                      "autoria de "+widget.data.author!,
                      style: TextStyle(
                          fontSize: 13,
                          color: cHeavyGrey
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left:10, bottom: 5),
                child: Text(
                  widget.data.title!.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.data.text!,
                      textAlign: TextAlign.justify,
                    ),
                    //SizedBox(height: 10,)
                  ),
                ),
              ),
            ],*/
      ),
    );
  }
}