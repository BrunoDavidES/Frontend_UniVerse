import 'package:UniVerse/components/faq_item.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

class FAQlist extends StatelessWidget {
  final String question;
  final bool starts;
  const FAQlist({super.key, required this.question, required this.starts});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
           children:[
             FAQbox(
               question: 'O que é a UniVerse?',
               answer: 'A UniVerse é a mais recente plataforma que vai trazer uma nova vida ao campus da tua faculdade!\nCom todo o Universo da NOVA FCT num só lugar, vai ser mais fácil encontrares informações básicas, avisos, eventos, organizares o teu dia-a-dia e muito mais. Junta-te já ao Universo!',
             ),
             FAQbox(
               question: 'É necessário criar uma conta?',
               answer: 'Não. Estamos a trabalhar no sentido de tornar a UniVerse mais acessível para ti e, por isso, por enquanto, se fazes parte da FCT NOVA é aconselhável registares-te para não perderes os benefícios que isso traz. Insere o teu e-mail institucional, nome e uma palavra-passe e está feito. Fazes agora parte da UniVerse!',
             ),
            FAQbox(
              question: 'A UniVerse e só para pessoas da faculdade?',
              answer: 'Não! Se não fazes parte da NOVA FCT, podes fazer parte do universo. Podes ver o que é que se passa e ver os próximos eventos que irão decorrer na faculdade. Podes também procurar por informação da FCT.',
            ),
            FAQbox(
              question: 'Quem é a CAPICREW?',
              answer: 'A CAPICREW são os criadores da UniVerse. São 5 estudantes do curso de informática (MIEI) da NOVA FCT.',
            ),
            FAQbox(
              question: 'Porque é que não me consigo registar?',
              answer: 'Se não pertences á NOVA FCT não vais conseguir registar, esta aplicação tem como objetivo a facilitação de acesso de informação aos estudantes e de facilitação de informação para os que estão a oassar por cá.',
            ),FAQbox(
              question: 'Que linguagens foram utilizadas para a criação da UniVerse?',
              answer: 'Para a criação da Universe foram utilizadas uma variedade de linguagens, desde JavaScript, Java, Html, CSS a Dart.',
            ),
            FAQbox(
              question: 'Dentro da UniVerse existe algum segredo que o utilizador consiga descobrir?',
              answer: 'Pergunta interessante! Dentro da UniVerse, há uma aura de mistério que cativa a curiosidade dos utilizadores. Embora não possa confirmar nem negar explicitamente a existência de segredos, posso dizer que a plataforma foi desenvolvida com detalhes minuciosos e uma atenção cuidadosa aos pormenores.',
            ),
             FAQbox(
               question: 'Onde posso saber mais sobre a UniVerse?',
               answer: 'Não queremos que o Universo esteja distante, por isso, podes acompanhar-nos no Instagram @universe.fct',
             ),
             FAQbox(
               question: 'Quer saber alguma informação específica sobre a faculdade FCT NOVA?',
               answer: 'Vai ao site de ajuda da FCT, onde encontra a FAQ da faculdade com várias questões frequentemente perguntadas. Link: https://www.fct.unl.pt/faq#t136n17231',
             ),
      ]
        ),
    );
  }
}