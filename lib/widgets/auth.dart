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
            fontSize: 14,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Palette.primary,
                ),
              ),
            )),
      ],
    );
  }
}

class OTPExpiryMessage extends StatelessWidget {
  const OTPExpiryMessage({
    super.key,
    required this.content,
    required this.time,
    required this.format,
  });
  final String content;
  final String time;
  final String format;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: content,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            TextSpan(
              text: time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Palette.primary,
              ),
            ),
            TextSpan(
              text: format,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
