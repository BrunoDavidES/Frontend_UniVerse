import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../consts.dart';

class SocialMediaListItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final String url;

  const SocialMediaListItem({
    super.key, required this.icon, required this.text, required this.url });

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
            icon,
            Text(
              text,
              ),
          ],
        ),
      ),
    );
  }
}
