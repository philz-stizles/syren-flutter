import 'package:flutter/material.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/enums.dart';
import 'package:syren/utils/palette.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:table_calendar/table_calendar.dart';

import 'widgets.dart';

// ignore: must_be_immutable
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

  RxBool isObscure = true.obs;
  RxBool isError = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          labelText == null
              ? const SizedBox()
              : Text(
                  labelText!,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: fontWeight,
                      color: Palette.secondary),
                ),
          SizedBox(
            height: labelText == null ? 0 : 10,
          ),
          Obx(() => TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(fontSize: 14),
                controller: editingCtrl,
                obscureText: isObscure.value,
                decoration: InputDecoration(
                  hintText: hintText,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        isObscure.value = !isObscure.value;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(isObscure.value
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
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
  const AppTextField({
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
    this.formFieldKey,
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
  final GlobalKey<FormFieldState>? formFieldKey;
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
                        fontSize: 14,
                        fontWeight: fontWeight,
                        color: Palette.secondary),
                  ),
            SizedBox(
              height: labelText == null ? 0 : 10,
            ),
            descriptionText == null
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      descriptionText!,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC8CBD5)),
                    ),
                  ),
            TextFormField(
              key: formFieldKey,
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
                hintText: hintText,
                suffixIcon: icon == null
                    ? null
                    : GestureDetector(onTap: iconTap, child: Icon(icon)),
              ),
              validator: validator ??
                  (val) {
                    if (val == null || val.isEmpty) {
                      return validationText ?? "Please provide a valid value";
                    } else {
                      return null;
                    }
                  },
            ),
          ],
        ));
  }
}

class DateInputField extends StatelessWidget {
  const DateInputField({
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

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            labelText!,
            style: TextStyle(
                fontSize: 14, fontWeight: fontWeight, color: Palette.secondary),
          ),
          SizedBox(
            height: labelText == null ? 0 : 10,
          ),
          TextFormField(
            readOnly: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(fontSize: 14),
            controller: editingCtrl,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: icon == null
                  ? null
                  : GestureDetector(
                      onTap: iconTap,
                      child: Icon(
                        icon,
                        color: Palette.secondary,
                      )),
            ),
            // validator: (val) {
            //   if (val == null || val.isEmpty) {
            //     isError.value = true;
            //     return "Please provide a valid ${hintText?.toLowerCase()}";
            //   } else {
            //     isError.value = false;
            //     return null;
            //   }
            // },
          )
        ]));
  }
}

class RadioButtonField extends StatelessWidget {
  RadioButtonField({
    super.key,
    required this.labelText,
    required this.options,
    this.hintText,
    this.validationText,
    this.onChanged,
    this.descriptionText,
    this.fontWeight = FontWeight.w700,
    this.direction = RadioButtonDirection.horizontal,
    this.isEnabled = true,
    // this.groupValue,
  });

  final String? hintText;
  final String labelText;
  final String? validationText;
  // final String? groupValue;
  final String? descriptionText;
  final bool isEnabled;
  final RadioButtonDirection direction;
  final FontWeight fontWeight;
  final ValueChanged<String?>? onChanged;
  final List<dynamic> options;

  final groupValue = Rxn<String>();

  @override
  Widget build(BuildContext context) {
    return Obx((() => Container(
        margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: TextStyle(
                  fontSize: 14, fontWeight: fontWeight, color: Palette.label),
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
        ))));
  }

  List<Widget> _buildOptions() {
    return options
        .map(
          (e) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(children: [
              SizedBox(
                height: 30.0,
                width: 30.0,
                child: Transform.scale(
                    scale: 0.8,
                    child: Radio(
                        //fillColor: Palette.midGrey,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        value: e,
                        groupValue: groupValue.value,
                        onChanged: (value) {
                          groupValue.value = value.toString();
                          if (onChanged != null) {
                            onChanged!(groupValue.value);
                          }
                        })),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                e,
                style: const TextStyle(fontSize: 14, color: Palette.secondary),
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
  const DropdownSelectField(
      {super.key,
      required this.options,
      this.dropdownValue,
      required this.onChanged,
      this.labelText,
      this.fontWeight = FontWeight.w700,
      this.hint});

  final FontWeight fontWeight;
  final ValueChanged<String?>? onChanged;
  final List<String> options;
  final String? dropdownValue;
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
                fontSize: 14, fontWeight: fontWeight, color: Palette.secondary),
          ),
          SizedBox(
            height: labelText == null ? 0 : 10,
          ),
          DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Palette.grey, width: 1.5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  hint: const Text('Select an option'),
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
              )),
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

class SelectDateField extends StatelessWidget {
  SelectDateField(
      {super.key,
      required this.label,
      required this.selectedDay,
      required this.focusedDay,
      required this.onDaySelected});

  final String label;
  DateTime selectedDay;
  DateTime focusedDay;
  void Function(DateTime, DateTime)? onDaySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Palette.label),
        ),
        TableCalendar(
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              leftChevronMargin: const EdgeInsets.all(0),
              leftChevronPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
              leftChevronIcon: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(secondaryBorderRadius),
                    border: Border.all(color: Palette.lightGrey, width: 2.0)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.chevron_left),
                ),
              ),
              rightChevronMargin: const EdgeInsets.all(0),
              rightChevronPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
              rightChevronIcon: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(secondaryBorderRadius),
                    border: Border.all(color: Palette.lightGrey, width: 2.0)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.chevron_right),
                ),
              ),
              titleCentered: true,
              titleTextStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          calendarStyle: const CalendarStyle(),
          rowHeight: 42,
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          onDaySelected: onDaySelected
          // calendarFormat: _calendarFormat,
          // onFormatChanged: (format) {
          //   setState(() {
          //     _calendarFormat = format;
          //   });
          // },
          ,
          // onPageChanged: (currentFocusedDay) {
          //   focusedDay = currentFocusedDay;
          // },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
