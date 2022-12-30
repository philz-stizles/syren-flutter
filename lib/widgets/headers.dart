import 'package:flutter/material.dart';
import 'package:syren/utils/palette.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.text,
    required this.press,
    this.img,
  }) : super(key: key);
  final String? img;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        img == null
            ? const SizedBox()
            : GestureDetector(
                onTap: press,
                child: Image.asset(
                  img!,
                  height: 30,
                ),
              ),
        Text(
          text,
          // style: AppTextStyles.defaultStyle.copyWith(
          //   fontSize: 14,
          //   fontWeight: FontWeight.w600,
          //   color: const Color.fromRGBO(101, 102, 106, 1),
          // ),
        ),
        Container(),
      ],
    );
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
              alignment: Alignment.centerLeft,
              child: Text(
                title!,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Palette.secondary),
              ),
            )
          : const SizedBox(),
      SizedBox(
        height: title == null ? 0 : 10,
      ),
      Align(
          alignment: Alignment.centerLeft,
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
