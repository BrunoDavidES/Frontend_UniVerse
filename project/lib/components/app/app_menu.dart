class Menu {
  String? text;
}
/*
if(index == 0)
                return MenuCard(text: 'APAGAR', description: '', icon: Icons.delete, press: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Error500WithBar(i: 1, title: Image.asset("assets/app/report.png", scale: 6,),)));
                },);
                else if(index==1)
                  return MenuCard(text: 'Comprovativo', description: 'Acede ao comprovativo da tua vinculação com a FCT NOVA.',icon: Icons.card_membership_outlined, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProofScreen()));

                  });
                else if(index==2)
                  return MenuCard(text: 'Reportar', description: 'Reporta um problema que encontraste no campus.',icon: Icons.report_outlined, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportPageApp()));
                  });
                else if(index==3)
                  return MenuCard(text: 'Fóruns', description: 'Acede a fóruns informativos do que se passa na FCT',icon: Icons.message_outlined, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreenApp()));
                  });
                else if(index==4)
                  return MenuCard(text: 'APAGAR', description: '',icon: Icons.delete, press: () { });
                else if(index==5)
                  return MenuCard(text: 'Feedback', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                else if(index==6)
                  return MenuCard(text: 'Inquéritos', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                else if(index==7)
                  return MenuCard(text: 'Estatísticas', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                else if(index==8)
                  return MenuCard(text: 'APAGAR', description: '',icon: Icons.delete, press: () { });
                else if(index==9)
                  return MenuCard(text: 'Calendário', description: 'Vê tudo o que tens para fazer no teu calendário',icon: Icons.calendar_month_outlined, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarPageApp()));
                  });
                else if(index==10)
                  return MenuCard(text: 'O meu perfil', description: 'Vê o teu perfil',icon: Icons.person_outline, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePageApp()));
                  });
                else if(index==11)
                  return MenuCard(text: 'Organizar evento', description: 'Organiza um evento na faculdade de forma fácil e rápida',icon: Icons.event_available_outlined, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppPublishPage()));
                  });
                else if(index==12)
                  return MenuCard(text: 'Apagar Conta', description: '',icon: Icons.delete, press: () {
    showDialog(
    context: context,
    builder: (_) => ConfirmDialogBox(descriptions: "Tens a certeza que pretendes eliminar a tua conta?", press: () {
    final response = User.delete();
    if(response == 200)
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AppHomePage()));
    else showDialog(
    context: context,
    builder: (_) => CustomDialogBox(
    title: "Ups!",
    descriptions: "Parece que a tua sessão expirou. Inicia sessão novamente para conseguires aceder à UniVerse.",
    text: "OK",
    press: () {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPageApp()));
    }
    )
    );
    },));
                  });
 */