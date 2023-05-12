import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../consts/color_consts.dart';

class UrlLaunchableItem extends StatelessWidget {
  final String text;
  final String url;

  const UrlLaunchableItem({
    super.key, required this.text, required this.url });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Uri toLaunch = Uri.parse(url);
        var urllaunchable = await canLaunchUrl(toLaunch);
        if (urllaunchable) {
          await launchUrl(
            toLaunch,
            mode: LaunchMode.externalApplication
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Text(
              text,
              ),
          ],
        ),
      ),
    );
  }
}
