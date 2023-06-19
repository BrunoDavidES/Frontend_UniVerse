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
           children:[ FAQbox(
              question: 'É necessário criar uma conta?',
              answer: 'Não! \nSe és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito. \n',
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
            ),
            FAQbox(
              question: 'É necessário criar uma conta?',
              answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
            ),FAQbox(
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
      ]
        ),
    );
  }
}