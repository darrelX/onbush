import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';

import '../theme/app_colors.dart';

class AppInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? initialValue;
  final Color? fillColor;
  final String? label;
  final Color? labelColors;
  final bool readOnly;
  final bool enable;
  final AutovalidateMode autoValidate;
  final TextAlign textAlign;
  final Function(String value)? onChange;
  final ValueChanged<String>? onSubmitted;
  final List<String? Function(String?)> validators;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final bool? hideText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool showEyes;
  final bool obscureText;
  final int minLines, maxLines;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final Color textColor;
  final Color? cursorColor;
  final Color errorColor;
  final VoidCallback? onTap;
  final bool required;
  final List<String>? autofillHints;
  final int? maxLength;
  final bool showHelper;
  final EdgeInsets? contentPadding;
  final Widget? eye;
  final Widget? eyeClosed;
  final Widget? labelRight;
  final bool isItalic;
  final int? maxValue;
  final double? width;
  final Color? colorBorder;
  final int? errorMaxLines;
  final ValueChanged<bool>? onInputValidated;
  final GlobalKey<FormFieldState>? formFieldKey;

  const AppInput({
    super.key,
    this.formFieldKey,
    this.controller,
    this.onInputValidated,
    this.fillColor = Colors.white,
    this.maxValue,
    this.hint,
    this.initialValue,
    this.label,
    this.readOnly = false,
    this.enable = true,
    this.autoValidate = AutovalidateMode.disabled,
    this.textAlign = TextAlign.start,
    this.onChange,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.hideText,
    this.suffixIcon,
    this.prefix,
    this.showEyes = false,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.focusNode,
    this.nextNode,
    this.inputFormatters,
    this.prefixText,
    this.textColor = AppColors.black,
    this.cursorColor,
    this.errorColor = AppColors.red,
    this.validators = const [],
    this.onTap,
    this.required = false,
    this.autofillHints,
    this.maxLength,
    this.showHelper = true,
    this.contentPadding = const EdgeInsets.only(
      right: 10,
      top: 14,
      bottom: 14,
      left: 16,
    ),
    this.eye,
    this.eyeClosed,
    this.onSubmitted,
    this.labelRight,
    this.isItalic = false,
    this.labelColors,
    this.width,
    this.errorMaxLines,
    this.colorBorder,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _isObscure = true;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      widget.hideText != null
          ? _isObscure = widget.hideText!
          : _isObscure = true;
      // if (FormBuilderValidators.compose(widget.validators) == null) {
      //   print("ok");
      //   widget.onInputValidated!(true);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hideText != null) {
      _isObscure = widget.hideText!;
    }

    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 6,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${widget.label}",
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: widget.labelColors ?? AppColors.black,
                  ),
                ),
                const Spacer(),
                if (widget.labelRight != null) widget.labelRight!
              ],
            ),
          ),
        Container(
          width: widget.width ?? 320.w,
          // height: 50.h,
          decoration: BoxDecoration(
            // color: const Color.fromRGBO(240, 244, 245, 10),
            // Couleur de fond souhaitée
            borderRadius: BorderRadius.circular(40.0), // Rayon des bords
          ),
          child: Center(
            child: TextFormField(
              key: widget.formFieldKey,
              controller: widget.controller,
              style: context.textTheme.titleSmall,
              autocorrect: true,
              buildCounter: !widget.showHelper
                  ? (
                      context, {
                      required currentLength,
                      required isFocused,
                      maxLength,
                    }) =>
                      Container()
                  : null,
              onTap: widget.onTap,
              initialValue: widget.initialValue,
              enabled: widget.enable,
              validator: FormBuilderValidators.compose(widget.validators),
              inputFormatters: widget.inputFormatters,
              readOnly: widget.readOnly,
              maxLength: widget.maxLength,
              onChanged: (value) {
                // Si un onChanged personnalisé est passé, on l'appelle
                if (widget.onChange != null) {
                  widget.onChange!(value);
                }

                // Vérifie la validité avec le validateur fourni
                final isCurrentlyValid =
                    FormBuilderValidators.compose(widget.validators)
                            .call(value) ==
                        null;

                if (isCurrentlyValid != isValid) {
                  setState(() {
                    isValid = isCurrentlyValid;
                  });

                  // Déclenche le callback lorsque la validité change
                  if (widget.onInputValidated != null) {
                    widget.onInputValidated!(isValid);
                  }
                }
              },
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              focusNode: widget.focusNode,
              autovalidateMode: widget.autoValidate,
              keyboardType: widget.keyboardType,
              autofillHints: widget.autofillHints,
              cursorColor: widget.cursorColor,
              textAlign: widget.textAlign,
              obscureText: widget.obscureText ? _isObscure : false,
              textInputAction: widget.nextNode != null
                  ? TextInputAction.next
                  : (widget.textInputAction ?? TextInputAction.done),
              onFieldSubmitted: widget.nextNode == null
                  ? widget.onSubmitted
                  : (value) {
                      FocusScope.of(context).requestFocus(widget.nextNode);
                      if (widget.onSubmitted != null) {
                        widget.onSubmitted!(value);
                      }
                    },
              decoration: InputDecoration(
                errorMaxLines: widget.errorMaxLines,

                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.r), // Rayon des bords
                    borderSide: const BorderSide(color: Colors.red)),

                focusedBorder: null,
                // enabledBorder: widget.border ? InputBorder.none : null,
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.r), // Rayon des bords
                    borderSide:
                        BorderSide(color: widget.colorBorder ?? Colors.grey)
                    // borderSide: const BorderSide(color: Colors.transparent)
                    ),
                filled: true,
                fillColor: widget.fillColor,
                hintText: widget.hint,

                hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  // fontSize: 15.sp,
                  color: Colors.grey.shade500,
                  fontStyle: widget.isItalic ? FontStyle.italic : null,
                ),
                suffixIcon:
                    (widget.showEyes == true && widget.obscureText == true)
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            child: _isObscure
                                ? widget.eye ??
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 8.h,
                                      ),
                                      child: const Icon(
                                        Icons.visibility_off_outlined,
                                        size: 25,
                                        //color: AppColors.textColor,
                                      ),
                                    )
                                : widget.eyeClosed ??
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 8.h,
                                      ),
                                      child: const Icon(
                                        Icons.visibility_outlined,
                                        size: 25,

                                        ///color: AppColors.textColor,
                                      ),
                                    ),
                          )
                        : widget.suffixIcon,
                contentPadding: widget.contentPadding,
                prefixIcon: widget.prefix,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
