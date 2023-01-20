import 'package:flutter/material.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';

class AppMenuItem extends StatelessWidget {
  const AppMenuItem(
      {super.key,
      required this.label,
      required this.icon,
      this.isLast = false,
      required this.onTap});

  final String label;
  final IconData icon;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Palette.grey)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    // size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppMenuInkWell extends StatelessWidget {
  const AppMenuInkWell(
      {super.key,
      required this.label,
      this.child,
      this.isLast = false,
      required this.onTap});

  final String label;
  final Widget? child;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
        isLast
            ? const SizedBox(
                width: 0.0,
                height: 0.0,
              )
            : const Divider(
                thickness: 1,
              ),
      ],
    );
  }
}

class AppMenuText extends StatelessWidget {
  const AppMenuText(
      {super.key,
      required this.label,
      required this.text,
      this.isLast = false,
      this.onTap});

  final String label;
  final String text;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        isLast
            ? const SizedBox(
                width: 0.0,
                height: 0.0,
              )
            : const Divider(
                thickness: 1,
              ),
      ],
    );
  }
}

class AppMenuSwitch extends StatelessWidget {
  const AppMenuSwitch(
      {super.key,
      required this.label,
      this.child,
      this.isLast = false,
      this.onChanged,
      required this.switchValue});

  final String label;
  final Widget? child;
  final bool switchValue;
  final bool isLast;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            // AppSwitch(value: switchValue, onChanged: onChanged)
          ],
        ),
      ),
      isLast
          ? const SizedBox(
              width: 0.0,
              height: 0.0,
            )
          : const Divider(
              thickness: 1,
            ),
    ]);
  }
}

class AppMenu extends StatelessWidget {
  const AppMenu(
      {super.key, required this.title, required this.children, this.onTap});

  final String title;
  final List<Widget> children;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey.shade200,
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ...children
            ])));
  }
}

class AppMenuBadge extends StatelessWidget {
  const AppMenuBadge(
      {super.key,
      required this.label,
      this.badgeText,
      this.isLast = false,
      this.onTap});

  final String label;
  final String? badgeText;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    badgeText == null
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(240, 108, 110, 1),
                              borderRadius:
                                  BorderRadius.circular(secondaryBorderRadius),
                            ),
                            child: Center(
                              child: Text(
                                badgeText!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
        isLast
            ? const SizedBox(
                width: 0.0,
                height: 0.0,
              )
            : const Divider(
                thickness: 1,
              ),
      ],
    );
  }
}
