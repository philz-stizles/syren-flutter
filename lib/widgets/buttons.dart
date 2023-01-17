import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:syren/utils/palette.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/enums.dart';
import 'widgets.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      this.disabled = false,
      this.loading = false,
      this.outlined = false,
      required this.title,
      required this.press,
      this.color,
      this.expanded = true,
      this.size = ButtonSize.large,
      this.icon})
      : super(key: key);

  final Color? color;
  final bool loading;
  final bool disabled;
  final bool outlined;
  final bool expanded;
  final ButtonSize size;
  final String title;
  final IconData? icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? double.infinity : null,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              side: BorderSide(
                  color: outlined ? Palette.secondary : Colors.transparent,
                  width: outlined ? 1 : 0),
              //shadowColor: outlined ? null : Palette.primary,
              elevation: outlined ? 0 : null,
              backgroundColor: outlined ? Palette.white : null,
              padding: EdgeInsets.symmetric(
                  vertical: size == ButtonSize.large ? 18 : 8,
                  horizontal: size == ButtonSize.large ? 15 : 15)),
          onPressed: disabled ? null : press,
          child: loading
              ? Center(
                  child: SpinKitThreeBounce(
                    size: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: outlined ? Palette.secondary : Palette.white,
                      ),
                    ),
                    ...icon == null
                        ? [const SizedBox()]
                        : [
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              icon,
                              size: 20,
                              color:
                                  outlined ? Palette.secondary : Palette.white,
                            )
                          ]
                  ],
                )),
    );
  }
}

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    Key? key,
    this.disabled = false,
    this.loading = false,
    this.color,
    this.leadingIcon,
    this.trailingIcon,
    this.fontWeight = FontWeight.bold,
    required this.label,
    required this.onPress,
  }) : super(key: key);

  final Color? color;
  final bool loading;
  final bool disabled;
  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback onPress;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            leadingIcon == null ? const SizedBox() : Icon(leadingIcon),
            SizedBox(width: leadingIcon == null ? 0 : 10),
            Text(
              label,
              style: TextStyle(fontWeight: fontWeight, fontSize: 12),
            ),
            SizedBox(width: trailingIcon == null ? 0 : 10),
            trailingIcon == null ? const SizedBox() : Icon(trailingIcon)
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {Key? key,
      this.disabled = false,
      this.loading = false,
      required this.title,
      required this.press,
      this.color})
      : super(key: key);

  final Color? color;
  final bool loading;
  final bool disabled;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        onPressed: disabled ? null : press,
        child: loading
            ? Center(
                child: SpinKitThreeBounce(
                  size: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              )
            : Text(
                title,
                // style: AppTextStyles.defaultStyle.copyWith(
                //   fontSize: 14,
                //   fontWeight: FontWeight.w600,
                //   color: const Color.fromRGBO(231, 235, 236, 1),
                // ),
              ),
      ),
    );
  }
}

class BorderedButton extends StatelessWidget {
  const BorderedButton({
    Key? key,
    required this.text,
    required this.press,
    this.isLoading = false,
  }) : super(key: key);
  final bool isLoading;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: OutlinedButton.icon(
          onPressed: isLoading ? null : press,
          label: Text(
            text,
            //   style: AppTextStyles.defaultStyle.copyWith(
            //       fontSize: 14.0,
            //       fontWeight: FontWeight.w600,
            //       color: const Color.fromARGB(255, 123, 122, 122)),
          ),
          icon: isLoading
              ? const Loader(
                  width: 12.0,
                  height: 12.0,
                  color: Color.fromARGB(255, 123, 122, 122),
                  stroke: 2,
                )
              : const Icon(
                  Icons.add_circle_outline,
                  color: Color.fromARGB(255, 123, 122, 122),
                  size: 15, // getProportionateScreenWidth(15.0),
                ),
          style: OutlinedButton.styleFrom(
              fixedSize: const Size.fromWidth(170.0),
              padding: const EdgeInsets.all(12.0),
              side:
                  const BorderSide(color: Color.fromARGB(255, 123, 122, 122))),
        ));
  }
}

class SolidButton extends StatefulWidget {
  const SolidButton(
      {super.key,
      required this.color,
      required this.isLoading,
      required this.text,
      required this.press,
      this.disabled = false});

  final Color color;
  final bool isLoading;
  final bool disabled;
  final String text;
  final VoidCallback press;

  @override
  State<SolidButton> createState() => _SolidButtonState();
}

class _SolidButtonState extends State<SolidButton> {
  var _isLoading = false;

  @override
  void didUpdateWidget(covariant SolidButton oldWidget) {
    if (oldWidget.isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.disabled
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              widget.press();
            },
      child: Container(
        width: 120.0,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _isLoading && widget.isLoading
                ? Center(
                    child: SpinKitThreeBounce(
                      size: 12.0,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white70,
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      widget.text,
                      // style: AppTextStyles.defaultStyle.copyWith(
                      //     fontSize: 12.0,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.white),
                    ),
                  )),
      ),
    );
  }
}

class BlockButton extends StatelessWidget {
  const BlockButton(
      {Key? key, required this.label, required this.onTap, this.color})
      : super(key: key);

  final Color? color;

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(colors: [
                Colors.red,
                Colors.red.shade900,
              ])),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              label,
              // style: AppTextStyles.defaultStyle.copyWith(
              //   fontSize: 12,
              //   fontWeight: FontWeight.w400,
              //   color: Colors.white,
              // ),
            ),
          )),
    );
  }
}

class ChatButton extends StatelessWidget {
  const ChatButton({super.key, required this.onPress});

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPress,
      tooltip: 'Chat',
      child: const Icon(Icons.textsms),
    );
  }
}

class CardButton extends StatelessWidget {
  const CardButton(
      {Key? key,
      required this.label,
      required this.onTap,
      this.color,
      this.icon})
      : super(key: key);

  final Color? color;
  final IconData? icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: color),
          padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 30.0,
                color: Colors.white70,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                label,
                // style: AppTextStyles.defaultStyle.copyWith(
                //   fontSize: 14,
                //   fontWeight: FontWeight.w400,
                //   color: Colors.white,
                // ),
              ),
            ],
          )),
    ));
  }
}

class SelectButton extends StatelessWidget {
  const SelectButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.black,
          ),
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            // style: AppTextStyles.defaultStyle.copyWith(
            //   fontSize: 12,
            //   fontWeight: FontWeight.w400,
            //   color: Colors.white,
            // ),
          ),
        ),
        Positioned(
          top: 15.0,
          right: 15.0,
          child: Container(
            width: 15.0,
            height: 15.0,
            decoration: BoxDecoration(
              // color: Colors.white70,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child:
                // selectedAccount.value != null &&
                //         selectedAccount.value?.customerId ==
                //             data.customerId
                // ? const Icon(
                //     color: Palette.primaryGreen,
                //     size: 15.0,
                //     Icons.check_circle_outline)
                //:
                const Icon(
                    color: Colors.white70, size: 15.0, Icons.circle_rounded),
          ),
        ) //
      ],
    );
  }
}

class FlexiButton extends StatelessWidget {
  const FlexiButton(
      {Key? key,
      this.disabled = false,
      this.loading = false,
      required this.title,
      required this.press,
      this.color,
      this.size = FlexiButtonSize.medium})
      : super(key: key);

  final FlexiButtonSize size;
  final Color? color;
  final bool loading;
  final bool disabled;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: disabled ? null : press,
        child: loading
            ? Center(
                child: SpinKitThreeBounce(
                  size: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              )
            : Text(
                title,
                // style: AppTextStyles.defaultStyle.copyWith(
                //   fontSize: 14,
                //   fontWeight: FontWeight.w600,
                //   color: const Color(0xFFE7EBEC),
                // ),
              ),
      ),
    );
  }
}

class FlexiOutlinedButton extends StatelessWidget {
  const FlexiOutlinedButton(
      {Key? key,
      this.disabled = false,
      this.loading = false,
      required this.title,
      required this.press,
      this.color,
      this.size = FlexiButtonSize.medium})
      : super(key: key);

  final FlexiButtonSize size;
  final Color? color;
  final bool loading;
  final bool disabled;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // width: double.infinity,
        height: 40,
        child: OutlinedButton(
          onPressed: disabled ? null : press,
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(100, 45),
          ),
          child: loading
              ? Center(
                  child: SpinKitThreeBounce(
                    size: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                )
              : Text(
                  title,
                  // style: AppTextStyles.defaultStyle.copyWith(
                  //   fontSize: 14,
                  //   fontWeight: FontWeight.w600,
                  //   color: const Color.fromRGBO(98, 107, 137, 1),
                  // ),
                ),
        ));
  }
}

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    super.key,
    required this.onTap,
    required this.label,
    this.info,
    required this.imageLocation,
    this.isDisabled = false,
    this.bgColor = const Color.fromRGBO(227, 37, 38, 1),
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
  });

  final VoidCallback onTap;
  final String label;
  final String imageLocation;
  final String? info;
  final bool isDisabled;
  final Color? bgColor;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: Material(
          elevation: 1,
          child: Container(
            decoration: BoxDecoration(
                color: isDisabled ? Colors.grey.shade500 : bgColor,
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    // style: AppTextStyles.defaultStyle.copyWith(
                    //   fontSize: 12,
                    //   fontWeight: FontWeight.w400,
                    //   color: textColor,
                    // ),
                  ),
                  Image.asset(
                    imageLocation,
                    height: 30,
                    color: iconColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      info == null
          ? const SizedBox()
          : Align(
              alignment: Alignment.centerLeft,
              child: Text(
                info!,
                // style: AppTextStyles.defaultStyle.copyWith(
                //   fontSize: 10,
                //   fontWeight: FontWeight.w400,
                //   color: const Color.fromRGBO(82, 83, 109, 1),
                // ),
              ),
            ),
    ]);
  }
}

class LabelButton extends StatelessWidget {
  const LabelButton(
      {Key? key,
      this.disabled = false,
      this.loading = false,
      this.outlined = false,
      required this.label,
      this.color,
      this.icon})
      : super(key: key);

  final Color? color;
  final bool loading;
  final bool disabled;
  final bool outlined;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          color: Palette.primary,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label,
                style: const TextStyle(color: Palette.white, fontSize: 12)),
            const SizedBox(
              width: 5,
            ),
            Icon(icon, size: 18, color: Palette.white)
          ],
        ),
      ),
    );
  }
}

class TimeButton extends StatelessWidget {
  const TimeButton(
      {Key? key,
      this.disabled = false,
      this.isSelected = false,
      this.outlined = false,
      required this.label,
      required this.onTap,
      this.color})
      : super(key: key);

  final Color? color;
  final bool isSelected;
  final bool disabled;
  final bool outlined;
  final String label;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                // spreadRadius: 10.0,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              )
            ],
            color: isSelected ? Palette.primary : Palette.white,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.alarm_outlined,
                size: 18, color: isSelected ? Palette.white : Palette.brown),
            const SizedBox(
              width: 5,
            ),
            Text(label,
                style: TextStyle(
                    color: isSelected ? Palette.white : Palette.brown,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
