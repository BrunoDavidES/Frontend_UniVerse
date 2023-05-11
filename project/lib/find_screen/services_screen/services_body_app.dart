
import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';

import '../../components/default_button_simple.dart';
import '../../components/list_button_simple.dart';

class ServicesBodyApp extends StatelessWidget {

  const ServicesBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: cDirtyWhiteColor,
          title: Image.asset("assets/app/services.png", scale: 6),
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {Navigator.pop(context);},
                    color: cDarkBlueColorTransparent);
              }
          ),
          leadingWidth: 20,
          elevation: 0,
          pinned: true,
          stretch: true,
          expandedHeight: 200,
          flexibleSpace: const FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
            ],
            background: Image(
                image: AssetImage("assets/web/FCT-NOVA.jpg"),
                fit: BoxFit.fill
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 14,
              (BuildContext context, int index) {
              if(index==0)
                return ListButtonSimple(text: "Divisão Académica", press: (){});
              else if(index==1)
              return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==2)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==3)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==4)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==5)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==6)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==7)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==8)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==9)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==10)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==11)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==12)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              else if(index==13)
                return ListButtonSimple(text: "Divisão de Acompanhamento de Parcerias", press: (){});
              }

          ),
        ),
      ],
      )
    );
  }

}