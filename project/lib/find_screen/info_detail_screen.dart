import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class InfoDetailScreen extends StatefulWidget {
  InfoDetailScreen( {super.key});

  @override
  State<StatefulWidget> createState() => InfoDetailState();
}

class InfoDetailState extends State<InfoDetailScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(left:10, top:40, bottom: 10, right: 10),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
              color: cHeavyGrey,
          ),
          boxShadow: [ BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0,0),
          ),
          ],
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage("assets/web/foto.jpg"),
              fit: BoxFit.cover),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
                color: cDirtyWhiteColor.withOpacity(0.6)
        ),
              child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {Navigator.pop(context);},
                  color: cHeavyGrey),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 5),
              child: Text(
                "Divisão de Eventos e Apoio ao Estudante Diplomado",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: cDirtyWhiteColor,
                    fontSize: 25
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              width: double.infinity,
              height: size.height/2.25,
              decoration: BoxDecoration(
                  boxShadow: [ BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0,0),
                  ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: cDirtyWhiteColor.withOpacity(0.60)
              ),
              child:SingleChildScrollView(
                child: Text(
                    "OLÁ",
                    textAlign: TextAlign.justify,
                  )
              ),
            ),
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