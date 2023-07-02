import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';
import '../../utils/users/user_data.dart';

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            !User.isVerified()
                ?"Para poderes fazer parte do Universo, precisamos que confirmes a tua conta. Enviámos um e-mail de confirmação para o endereço de e-mail que indicaste no registo!"
                :"A tua conta encontra-se suspensa e, por isso, não tens acesso àquilo que o Universo te oferece...",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: cHeavyGrey
            ),
          ),
        ),
        Icon(Icons.dangerous_outlined, color: cHeavyGrey, size: 100,)
      ],
    );
  }
}