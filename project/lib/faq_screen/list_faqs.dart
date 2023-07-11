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
               answer: 'Não. Podes explorar a plataforma, de forma limitada, sem registo e/ou sessão iniciada. No entanto, aconselhamos-te a fazê-lo para que usufruas de todas as vantagens que te trazemos. Insere o teu e-mail institucional, nome e uma palavra-passe e está feito. Fazes agora parte da UniVerse!',
             ),
            FAQbox(
              question: 'Não sou da faculdade, posso visitar a UniVerse?',
              answer: 'Claro! Queremos que o Universo chegue a todos. Por isso, podes ver as mais recentes notícias e próximos eventos abertos a visitantes. Podes também encontrar informaçóes básicas para que não tenhas qualquer dúvida, estando o registo na plataforma aberto apenas a pessoas com vínculo à FCT.',
            ),
             FAQbox(
               question: 'Quem é a CAPI CREW?',
               answer: 'A CAPI CREW são os criadores da UniVerse. São 5 estudantes do curso de Engenharia Informática da NOVA FCT.',
             ),
            FAQbox(
              question: 'Por que não me consigo registar?',
              answer: 'Se não pertences a esta faculdade, não te poderás registar nesta plataforma. Contudo, e se estiveres vinculado à faculdade, o registo pode falhar por não te estares a inscrever com o teu e-mail institucional, a palavra-passe que escolheste não seguir as restrições de, no mínimo, 6 caracteres, 1 número e 1 letra maiúscula ou porque algém se já registou com o teu e-mail (neste caso, por favor contacta-nos).',
            ),
             FAQbox(
               question: 'Que linguagens de programação foram utilizadas para a criação da UniVerse?',
               answer: 'Alcançámos o Universo, usando Java, JavaScript, HTML, CSS e Dart.',
             ),
             FAQbox(
               question: 'Onde posso saber mais sobre a UniVerse?',
               answer: 'Não queremos que o Universo esteja distante, por isso, podes acompanhar-nos no Instagram em @universe.fct',
             ),
             FAQbox(
               question: 'Onde posso receber ajuda sobre a FCT?',
               answer: 'Visita a página de Ajuda do website da NOVA FCT ou recolhe informação na nossa página de Procurar.',
             ),
      ]
        ),
    );
  }
}