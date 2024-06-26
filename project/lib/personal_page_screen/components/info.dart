import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';
import '../../utils/user/user_data.dart';

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: kIsWeb ?size.width/2 :size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              !UniverseUser.isVerified()
                  ?"Para poderes fazer parte do Universo, precisas de confirmar a tua conta. Enviámos um e-mail de confirmação para o endereço de e-mail que indicaste no registo!"
                  :"A tua conta encontra-se suspensa e, por isso, o teu acesso àquilo que a UniVerse te oferece está bloqueado.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: cHeavyGrey
              ),
            ),
          ),
          Icon(Icons.dangerous_outlined, color: cHeavyGrey, size: 100,)
        ],
      ),
    );
  }
}