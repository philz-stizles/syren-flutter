import 'package:flutter/material.dart';
import 'package:syren/utils/enums.dart';
import 'package:syren/utils/palette.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'widgets.dart';

// class AppTextField extends StatelessWidget {
//   const AppTextField({
//     required this.hintText,
//     super.key,
//     this.formKey,
//     this.maxLength,
//     this.icon,
//     this.isObscured = false,
//     this.isEnabled = true,
//     this.editingCtrl,
//     this.onSaved,
//     this.validator,
//     this.type = TextInputType.text,
//     this.iconTap,
//     this.validationText,
//   });
//   final GlobalKey<FormState>? formKey;
//   final String hintText;
//   final String? validationText;
//   final bool isObscured;
//   final bool isEnabled;
//   final IconData? icon;
//   final VoidCallback? iconTap;
//   final int? maxLength;
//   final TextInputType type;
//   final TextEditingController? editingCtrl;
//   final FormFieldSetter<String>? onSaved;
//   final FormFieldValidator<String>? validator;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
//       child: TextFormField(
//         controller: editingCtrl,
//         enabled: isEnabled,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         style: const TextStyle(fontSize: 14),
//         keyboardType: type,
//         maxLength: maxLength,
//         obscureText: isObscured,
//         decoration: InputDecoration(
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Color(0xFEFE0000),
//               width: 1, // width: 0
//             ),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Color(0xFEFE0000),
//               width: 1, // width: 0
//             ),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           hintText: hintText,
//           suffixIcon: icon == null
//               ? null
//               : GestureDetector(onTap: iconTap, child: Icon(icon)),
//         ),
//         validator: (val) {
//           if (val == null || val.isEmpty) {
//             return validationText ??
//                 "Please provide a valid ${hintText.toLowerCase()}";
//           } else {
//             return null;
//           }
//         },
//       ),
//     );
//   }
// }

class AppPasswordField extends StatelessWidget {
  AppPasswordField({
    this.formKey,
    this.hintText,
    super.key,
    this.icon,
    this.editingCtrl,
    this.validator,
    this.iconTap,
    this.labelText,
    this.fontWeight = FontWeight.w700,
  });
  final GlobalKey<FormState>? formKey;
  final String? hintText;
  final String? labelText;
  final FontWeight fontWeight;
  final IconData? icon;
  final VoidCallback? iconTap;
  final TextEditingController? editingCtrl;
  final FormFieldValidator<String>? validator;

  final isObscure = true.obs;
  final isError = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            labelText!,
            style: TextStyle(
                fontSize: 12, fontWeight: fontWeight, color: Palette.secondary),
          ),
          SizedBox(
            height: labelText == null ? 0 : 5,
          ),
          Obx(() => TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(fontSize: 14),
                controller: editingCtrl,
                obscureText: isObscure.value,
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFEFE0000),
                      width: 1, // width: 0
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFEFE0000),
                      width: 1, // width: 0
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: hintText,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        isObscure.value = !isObscure.value;
                      },
                      child: Icon(isObscure.value
                          ? Icons.visibility_off
                          : Icons.visibility)),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    isError.value = true;
                    return "Please provide a valid ${hintText?.toLowerCase()}";
                  } else {
                    isError.value = false;
                    return null;
                  }
                },
              ))
        ]));
  }
}

class SelectField extends StatelessWidget {
  SelectField({
    required this.hintText,
    super.key,
    this.formKey,
    this.icon = Icons.arrow_drop_down,
    this.editingCtrl,
    this.validator,
    this.hasValidator = true,
    this.iconTap,
  });
  final GlobalKey<FormState>? formKey;
  final String hintText;
  final IconData? icon;
  final VoidCallback? iconTap;
  final TextEditingController? editingCtrl;
  final bool hasValidator;
  final FormFieldValidator<String>? validator;

  final isError = false.obs;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingCtrl,
      enabled: false,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFEFE0000),
              width: 1, // width: 0
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFEFE0000),
              width: 1, // width: 0
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
          suffixIcon: Icon(icon),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFEDEDED),
              width: 0,
            ),
            // borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFEDEDED),
              width: 0,
            ),
            // borderRadius: BorderRadius.circular(5),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFEDEDED),
              width: 0,
            ),
            borderRadius: BorderRadius.circular(5),
          )),
      validator: hasValidator
          ? (validator ??
              (val) {
                if (val!.isEmpty) {
                  return "Field must not be empty";
                } else {
                  return null;
                }
              })
          : null,
    );
  }
}

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.validationText,
    this.formKey,
    this.maxLength,
    this.icon,
    this.maxLines = 1,
    this.isObscured = false,
    this.fontWeight = FontWeight.w700,
    this.isEnabled = true,
    this.type = TextInputType.text,
    this.editingCtrl,
    this.validator,
    this.iconTap,
    this.descriptionText,
    this.initialValue,
  });
  final GlobalKey<FormState>? formKey;
  final String? hintText;
  final String? labelText;
  final String? validationText;
  final String? initialValue;
  final String? descriptionText;
  final bool isObscured;
  final bool isEnabled;
  final IconData? icon;
  final FontWeight fontWeight;
  final VoidCallback? iconTap;
  final int? maxLength;
  final TextInputType type;
  final TextEditingController? editingCtrl;
  final FormFieldValidator<String>? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText == null
                ? const SizedBox()
                : Text(
                    labelText!,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: fontWeight,
                        color: Palette.secondary),
                  ),
            SizedBox(
              height: labelText == null ? 0 : 5,
            ),
            descriptionText == null
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      descriptionText!,
                      // style: AppTextStyles.defaultStyle.copyWith(
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w400,
                      //     color: const Color(0xFFC8CBD5)),
                    ),
                  ),
            TextFormField(
              maxLines: maxLines,
              initialValue: initialValue,
              controller: editingCtrl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 14),
              keyboardType: type,
              maxLength: maxLength,
              obscureText: isObscured,
              decoration: InputDecoration(
                enabled: isEnabled,
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFEFE0000),
                    width: 1, // width: 0
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFEFE0000),
                    width: 1, // width: 0
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: hintText,
                suffixIcon: icon == null
                    ? null
                    : GestureDetector(onTap: iconTap, child: Icon(icon)),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please provide a valid ${validationText ?? labelText?.toLowerCase() ?? hintText?.toLowerCase()}";
                } else {
                  return null;
                }
              },
            ),
          ],
        ));
  }
}

class RadioButtonField extends StatelessWidget {
  const RadioButtonField({
    super.key,
    required this.labelText,
    this.hintText,
    this.validationText,
    this.formKey,
    this.icon,
    this.editingCtrl,
    this.validator,
    this.iconTap,
    this.descriptionText,
    this.fontWeight = FontWeight.w700,
    this.direction = RadioButtonDirection.horizontal,
    this.isEnabled = true,
    this.initialValue,
    required this.options,
  });
  final GlobalKey<FormState>? formKey;
  final String? hintText;
  final String labelText;
  final String? validationText;
  final String? initialValue;
  final String? descriptionText;
  final bool isEnabled;
  final RadioButtonDirection direction;
  final IconData? icon;
  final FontWeight fontWeight;
  final VoidCallback? iconTap;
  final TextEditingController? editingCtrl;
  final FormFieldValidator<String>? validator;
  final List<dynamic> options;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: fontWeight,
                  color: Palette.secondary),
            ),
            SizedBox(
              height: direction == RadioButtonDirection.vertical ? 10 : 5,
            ),
            descriptionText == null
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      descriptionText!,
                      // style: AppTextStyles.defaultStyle.copyWith(
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w400,
                      //     color: const Color(0xFFC8CBD5)),
                    ),
                  ),
            direction == RadioButtonDirection.horizontal
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _buildOptions())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildOptions())
          ],
        ));
  }

  List<Widget> _buildOptions() {
    return options
        .map(
          (e) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(children: [
              SizedBox(
                  height: 15.0,
                  width: 15.0,
                  child: Transform.scale(
                      scale: 0.6,
                      child: Radio(
                          value: 1,
                          groupValue: 'null',
                          onChanged: (index) {}))),
              const SizedBox(
                width: 5,
              ),
              Text(
                e,
                style: const TextStyle(fontSize: 12, color: Palette.secondary),
              ),
              const SizedBox(
                width: 10,
              ),
            ]),
          ),
        )
        .toList();
  }
}

class AppPinCodeTextField extends StatelessWidget {
  const AppPinCodeTextField({
    super.key,
    this.formKey,
    this.maxLength,
    this.length = 5,
    this.isObscured = false,
    this.editingCtrl,
    this.validator,
    this.type = TextInputType.text,
    this.iconTap,
  });
  final GlobalKey<FormState>? formKey;
  final bool isObscured;
  final int length;
  final VoidCallback? iconTap;
  final int? maxLength;
  final TextInputType type;
  final TextEditingController? editingCtrl;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
      child: PinCodeTextField(
        mainAxisAlignment: MainAxisAlignment.center,
        useExternalAutoFillGroup: false,
        backgroundColor: Colors.white,
        controller: editingCtrl,
        autoDisposeControllers: false,
        textStyle: const TextStyle(fontWeight: FontWeight.normal),
        cursorColor: Colors.red,
        validator: (val) {
          if (val!.isEmpty) {
            return "Field must not be empty";
          } else {
            return null;
          }
        },
        cursorHeight: 10,
        onCompleted: (val) {},
        onChanged: (val) {},
        obscureText: true,
        textInputAction: TextInputAction.done,
        enableActiveFill: true,
        pinTheme: PinTheme(
            fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0),
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 45,
            selectedFillColor: Colors.grey.withOpacity(0.1),
            disabledColor: Colors.white,
            selectedColor: Colors.white,
            fieldWidth: 40, // 45
            activeColor: Colors.red,
            inactiveColor: Colors.grey.withOpacity(0.15),
            inactiveFillColor: Colors.white,
            activeFillColor: Colors.white),
        length: length,
        appContext: context,
      ),
    );
  }
}

class BottomSheetSelectField extends StatelessWidget {
  BottomSheetSelectField({
    super.key,
    this.formKey,
    required this.options,
    required this.editingCtrl,
    this.validator,
    this.onTap,
    required this.title,
    required this.description,
    this.hintText,
    this.hasLabel = false,
  });
  final GlobalKey<FormState>? formKey;
  final List<dynamic> options;
  final VoidCallback? onTap;
  final String title;
  final bool hasLabel;
  final String? hintText;
  final String description;
  final TextEditingController editingCtrl;
  final FormFieldValidator<String>? validator;
  final selectedOption = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          !hasLabel
              ? const SizedBox()
              : Text(
                  title,
                  // style: AppTextStyles.defaultStyle.copyWith(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //     color: const Color(0xFF65666A)),
                ),
          SizedBox(
            height: hasLabel ? 10.0 : 0.0,
          ),
          GestureDetector(
              onTap: () {
                UIConfig.showBottomSheet(
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          // style: AppTextStyles.defaultStyle.copyWith(
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.w700,
                          //   color: const Color.fromRGBO(70, 81, 116, 1),
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          // style: AppTextStyles.defaultStyle.copyWith(
                          //   fontSize: 12,
                          //   fontWeight: FontWeight.w400,
                          //   color: const Color.fromRGBO(70, 81, 116, 1),
                          // ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ...options
                            .map(
                              (option) => Obx(() => Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(option),
                                      Radio(
                                          value: option,
                                          groupValue: selectedOption.value,
                                          onChanged: (val) {
                                            selectedOption.value = val!;
                                            editingCtrl.text =
                                                selectedOption.value;
                                          }),
                                    ],
                                  )),
                            )
                            .toList(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: SelectField(
                hintText: hintText ?? (options.isNotEmpty ? options.first : ''),
                editingCtrl: editingCtrl,
                icon: Icons.arrow_drop_down,
              ))
        ]));
  }
}

class DropdownSelectField extends StatelessWidget {
  DropdownSelectField(
      {super.key,
      required this.editingCtrl,
      required this.options,
      required this.dropdownValue,
      required this.onChanged,
      this.labelText,
      this.fontWeight = FontWeight.w700,
      this.hint});

  final FontWeight fontWeight;
  final TextEditingController editingCtrl;
  final ValueChanged<String?>? onChanged;
  final List<String> options;
  final String dropdownValue;
  final String? labelText;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            labelText!,
            style: TextStyle(
                fontSize: 12, fontWeight: fontWeight, color: Palette.secondary),
          ),
          SizedBox(
            height: labelText == null ? 0 : 5,
          ),
          DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Palette.secondary, width: 1.5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  // Initial Value
                  value: dropdownValue,
                  style:
                      const TextStyle(fontSize: 14, color: Palette.secondary),
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: options.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (newValue) {
                    onChanged!(newValue);
                  },
                ),
              ))
        ]));
  }
}

// ignore: must_be_immutable
class PopupMenuSelectField extends StatelessWidget {
  PopupMenuSelectField({
    super.key,
    required this.ignoring,
    required this.editingCtrl,
    required this.options,
    required this.hintText,
    required this.onSelected,
    this.labelText,
  });

  final bool ignoring;
  final TextEditingController editingCtrl;
  final VoidCallback? onSelected;
  List<dynamic> options = [].obs;
  final String hintText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      labelText == null
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                labelText!,
                // style: AppTextStyles.defaultStyle.copyWith(
                //     fontSize: 14,
                //     fontWeight: FontWeight.normal,
                //     color: const Color(0xFF65666A)),
              ),
            ),
      SizedBox(
        width: double.infinity,
        child: IgnorePointer(
          ignoring: ignoring,
          child: PopupMenuButton<int>(
            padding: EdgeInsets.zero,
            icon: TextFormField(
              style: const TextStyle(fontSize: 14),
              // controller: editingCtrl,
              enabled: false,
              decoration: InputDecoration(
                hintText: hintText,
              ),
              // validator: (val) {
              //   if (val!.isEmpty) {
              //     return "Field must not be empty";
              //   } else {
              //     return null;
              //   }
              // },
            ),
            onSelected: (val) {
              if (val == 1) {
                debugPrint("Male");
                // profileUpdateCtrl.gender.text = "Male";
                // debugPrint(profileUpdateCtrl.gender.text
                //     .substring(0, 1)
                //     .toUpperCase());
              } else if (val == 2) {
                debugPrint("Female");
                // profileUpdateCtrl.gender.text = "Female";
              } else {
                debugPrint("Others");
              }
            },
            itemBuilder: (context) => options
                .map(
                  (dynamic e) => PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        const Icon(Icons.star),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(e)
                      ],
                    ),
                  ),
                )
                .toList(),
            offset: const Offset(0, 50),
            color: Colors.white,
            elevation: 2,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      )
    ]

        //
        );
  }
}

// ignore: must_be_immutable
class DialogSelectField extends StatelessWidget {
  DialogSelectField({
    super.key,
    this.formKey,
    required this.options,
    required this.editingCtrl,
    this.validator,
    required this.title,
    this.description,
    this.hintText,
    this.searchHintText = 'Search here',
    required this.searchCtrl,
    this.onChanged,
    this.label,
    this.search,
    this.onRefresh,
    required this.onTapOption,
  });
  final GlobalKey<FormState>? formKey;
  final String title;
  final String? label;
  final String? hintText;
  final String searchHintText;
  final String? search;
  final String? description;
  final TextEditingController searchCtrl;
  final TextEditingController editingCtrl;
  final Function? onRefresh;
  final Function onTapOption;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  var options = [].obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onRefresh != null) {
          onRefresh!();
        }
        final ScrollController scrollController = ScrollController();
        searchCtrl.clear();
        Get.dialog(AlertDialog(
            scrollable: true,
            title: Text(
              title,
              textAlign: TextAlign.center,
              // style: AppTextStyles.defaultStyle.copyWith(
              //   fontSize: 14,
              // ),
            ),
            titlePadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            content: SizedBox(
              height: Get.height * .70,
              width: Get.width,
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(fontSize: 14),
                    controller: searchCtrl,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: searchHintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        child: Obx(
                          () => ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              var option = options[index];
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Get.back();
                                      onTapOption(option);
                                      searchCtrl.clear();
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    title: Text(
                                      option.name!,
                                      // style:
                                      //     AppTextStyles.defaultStyle.copyWith(),
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        )),
                  )
                ],
              ),
            )));
      },
      child: TextFormField(
        controller: editingCtrl,
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return "Field must not be empty";
          } else {
            return null;
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class LabeledCheckbox extends StatelessWidget {
  LabeledCheckbox({
    super.key,
    required this.label,
    required this.isChecked,
    this.contentPadding = const EdgeInsets.all(5),
    this.onTap,
    this.gap = 10.0,
  });

  final String label;
  final EdgeInsets contentPadding;
  bool isChecked;
  final Function? onTap;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!(!isChecked) : null,
      child: Padding(
        padding: contentPadding,
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                height: 15.0,
                width: 15.0,
                child: Transform.scale(
                    scale: 0.6,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      value: isChecked,
                      activeColor: Palette.primary,
                      visualDensity: VisualDensity.compact,
                      onChanged: (val) {
                        isChecked = val!;
                      },
                    ))),
            SizedBox(
              width: gap,
            ), // you can control gap between checkbox and label with this field
            Flexible(
              child: Text(
                label,
                // style: AppTextStyles.defaultStyle.copyWith(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     color: const Color.fromRGBO(123, 131, 156, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateSelectField extends StatelessWidget {
  DateSelectField({
    required this.hintText,
    super.key,
    this.icon = Icons.arrow_drop_down,
    this.editingCtrl,
    this.validator,
    this.hasValidator = true,
    this.onTap,
  });

  final String hintText;
  final IconData? icon;
  final VoidCallback? onTap;
  final TextEditingController? editingCtrl;
  final bool hasValidator;
  final FormFieldValidator<String>? validator;

  final isError = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        style: const TextStyle(fontSize: 14),
        controller: editingCtrl,
        enabled: false,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return "Field must not be empty";
          } else {
            return null;
          }
        },
      ),
    );
  }
}

class BottomSheetOption extends StatelessWidget {
  const BottomSheetOption({
    super.key,
    required this.label,
    required this.imageLink,
    this.onTap,
  });

  final String label;
  final String imageLink;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color.fromRGBO(235, 235, 235, 1),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          child: Row(
            children: [
              Image.asset(
                imageLink,
                height: 30,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                label,
                // style: AppTextStyles.defaultStyle.copyWith(
                //   fontSize: 12,
                //   fontWeight: FontWeight.w400,
                //   color: const Color.fromRGBO(70, 81, 116, 1),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
