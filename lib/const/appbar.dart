import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;
  final String? logoAssetPath;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actionIcon,
    this.onActionPressed,
    this.logoAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          if (logoAssetPath != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                logoAssetPath!,
                height: 40,
              ),
            ),
          if (subtitle == null)
            Text(title)
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:  GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitle!, style:  GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
        ],
      ),
      actions: actionIcon != null
          ? [
              IconButton(
                icon: Icon(actionIcon),
                tooltip: 'Action',
                color: Colors.white,
                onPressed: onActionPressed,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
