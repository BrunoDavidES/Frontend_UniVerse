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
               answer: 'A UniVerse é a mais recente plataforma que vai trazer uma nova vida ao campus da tua faculdade!\nCom todo o Universo da FCT NOVA num só lugar, vai ser mais fácil encontrares informações básicas, avisos, eventos, organizares o teu dia-a-dia e muito mais. Junta-te já ao Universo!',
             ),
             FAQbox(
               question: 'É necessário criar uma conta?',
               answer: 'Sim. Estamos a trabalhar no sentido de tornar a UniVerse mais acessível para ti e, por isso, por enquanto, é necessário registares-te. Insere o teu e-mail institucional, nome e uma palavra-passe e está feito. Fazes agora parte da UniVerse!',
             ),
            FAQbox(
              question: 'É necessário criar uma conta?',
              answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
            ),
            FAQbox(
              question: 'É necessário criar uma conta?',
              answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
            ),
            FAQbox(
              question: 'É necessário criar uma conta?',
              answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
            ),
            FAQbox(
              question: 'É necessário criar uma conta?',
              answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
            ),FAQbox(
              question: 'É necessário criar uma conta?',
              answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
            ),
             FAQbox(
               question: 'Onde posso saber mais sobre a UniVerse?',
               answer: 'Não queremos que o Universo esteja distante, por isso, podes acompanhar-nos no Instagram @universe.fct',
             ),
            FAQbox(
              question: 'É necessário criar uma conta?',
              answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
            ),
      ]
        ),
    );
  }
}