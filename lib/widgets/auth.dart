import 'package:flutter/material.dart';
import 'package:syren/utils/palette.dart';

class AccountCTA extends StatelessWidget {
  const AccountCTA(
      {super.key,
      required this.text,
      required this.onTap,
      required this.linkText});

  final String text;
  final String linkText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 8, 8, 8),
              child: Text(
                linkText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Palette.primary,
                ),
              ),
            )),
      ],
    );
  }
}
