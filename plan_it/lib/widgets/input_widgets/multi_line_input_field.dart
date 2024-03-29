import 'package:flutter/material.dart';
import 'package:plan_it/services/utils/validators.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

class MultiLineInputfield extends StatefulWidget {
  final TextEditingController controller;
  final String fieldLabel;
  final String hintText;
  final bool validation;
  final bool? needTitle;
  final String errorMessage;
  final TextInputAction? textInputAction;
  final Color? backgroundColor;
  final TextAlign? textAlign;
  final TextStyle? hintTextStyle;
  final TextStyle? inputTextStyle;
  final Key? itemkey;
  final TextStyle? titleStyle;
  final Widget? prefixWidget;
  final bool? viewOnly;
  final FormFieldValidator<String>? validatorClass;
  final TextInputType? inputType;
  final int numberOfLines;

  const MultiLineInputfield(
      {super.key,
      required this.controller,
      required this.fieldLabel,
      required this.backgroundColor,
      required this.hintText,
      required this.validation,
      required this.errorMessage,
      this.needTitle,
      this.textInputAction,
      this.textAlign,
      this.hintTextStyle,
      this.itemkey,
      this.titleStyle,
      this.prefixWidget,
      this.viewOnly,
      this.validatorClass,
      this.inputTextStyle,
      this.inputType,
      required this.numberOfLines});

  @override
  State<MultiLineInputfield> createState() => _MultiLineInputfieldState();
}

class _MultiLineInputfieldState extends State<MultiLineInputfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.needTitle ?? true)
          Text(widget.fieldLabel,
              style: widget.titleStyle ?? TextDesign().fieldLabel),
        if (widget.needTitle ?? true) const SizedBox(height: 5),
        TextFormField(
          key: widget.itemkey,
          controller: widget.controller,
          keyboardType: widget.inputType ?? TextInputType.multiline,
          style: widget.inputTextStyle ?? TextDesign().input,
          readOnly: widget.viewOnly ?? false,
          maxLines: widget.numberOfLines,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ??
                TextDesign().input.copyWith(
                      color: MyColor.graySoft,
                    ),
            filled: true,
            fillColor: widget.backgroundColor ?? MyColor.fieldGray,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
            errorStyle: TextDesign().validator,
          ),
          validator:
              widget.validatorClass ?? ValidatorClass().noValidationRequired,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          onFieldSubmitted: (value) {
            widget.controller.text = value;
          },
        )
      ],
    );
  }
}
