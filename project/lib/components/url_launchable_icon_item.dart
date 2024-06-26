import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../consts/color_consts.dart';

class UrlLaunchableIconItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final String url;
  final Color color;

  const UrlLaunchableIconItem({
    super.key, required this.icon, required this.text, required this.url, required this.color });

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(
              text,
              style: TextStyle(
                color: color,
              ),
              ),
          ],
        ),
      ),
    );
  }
}
