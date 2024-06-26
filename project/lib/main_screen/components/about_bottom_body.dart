import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/url_launchable_icon_item.dart';
import '../../components/url_launchable_item.dart';

class AboutBottomBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = MediaQuery.of(context).size.width < 850;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            Container(
              width: size.width / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "FCT NOVA",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Faculdade de Ciências e Tecnologia\n2829-516 Caparica\nPortugal",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Telefone: (+351) 212 948 300\nFax: (+351) 212 954 461",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            UrlLaunchableItem(
                              text: "Website",
                              url: "https://www.fct.unl.pt/",
                              color: Colors.white,
                            ),
                            UrlLaunchableItem(
                              text: "Facebook",
                              url: "https://www.facebook.com/fct.nova",
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              UrlLaunchableItem(
                                text: "Instagram",
                                url: "https://www.instagram.com/fctnova",
                                color: Colors.white,
                              ),
                              UrlLaunchableItem(
                                text: "Twitter",
                                url: "https://www.twitter.com/FCTNOVA",
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              UrlLaunchableItem(
                                text: "LinkedIn",
                                url:
                                "https://pt.linkedin.com/school/nova-school-of-science-and-technology/",
                                color: Colors.white,
                              ),
                              UrlLaunchableItem(
                                text: "Youtube",
                                url: "https://www.youtube.com/user/fctunltv",
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              UrlLaunchableItem(
                                text: "Whatsapp",
                                url: "https://wa.me/+351924008005",
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            if(!isSmallScreen)
            Container(
              width: size.width / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 150),
                  Text(
                    "© 2023 Todos os direitos reservados",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            if(!isSmallScreen)
            Container(
              width: size.width / 3.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "UniVerse ּ FCT NOVA",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () => context.go('/about/us'),
                      child: Text.rich(
                        TextSpan(
                          text: "Descobre mais sobre nós ",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'aqui.',
                              style: TextStyle(decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Encontra e segue-nos:",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            UrlLaunchableItem(
                              text: "Website",
                              url: "https://universe-fct.oa.r.appspot.com",
                              color: Colors.white,
                            ),
                            UrlLaunchableItem(
                              text: "Instagram",
                              url: "https://www.instagram.com/universe.fct",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          "Powered by:",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset("assets/images/capi_logo.png", scale: 8),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}