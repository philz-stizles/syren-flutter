import 'package:flutter/material.dart';
import 'package:syren/utils/palette.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
    this.subTitle,
  }) : super(key: key);
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Palette.secondary,
                ),
              ),
              (subTitle == null)
                  ? const SizedBox()
                  : Text(
                      subTitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Palette.grey,
                      ),
                    ),
            ],
          ),
        ));
  }
}

class FormHeader extends StatelessWidget {
  const FormHeader({
    Key? key,
    this.title,
    this.text,
  }) : super(key: key);
  final String? title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      title != null
          ? Align(
              alignment: Alignment.center,
              child: Text(
                title!,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Palette.secondary),
              ),
            )
          : const SizedBox(),
      SizedBox(
        height: title == null ? 0 : 5,
      ),
      text == null
          ? const SizedBox()
          : Align(
              alignment: Alignment.center,
              child: Text(
                text!,
                // style: AppTextStyles.defaultStyle.copyWith(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w400,
                //     color: const Color.fromRGBO(98, 107, 137, 1)),
              )),
      const SizedBox(
        height: 20.0,
      ),
    ]);
  }
}
