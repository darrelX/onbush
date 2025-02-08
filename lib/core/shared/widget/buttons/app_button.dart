import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/core/extensions/context_extensions.dart';

import '../../../constants/colors/app_colors.dart';

class AppButton extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? activeBgColor;
  final Color? borderColor;
  final bool enable;
  final bool haveTop;
  final bool loading;
  final Color? loadingColor;
  final double height;
  final String? text;
  final BoxConstraints? constraints;
  final double? width;
  final Color? textColor;
  final double? minWidth;
  final TextStyle? style;
  final double? radius;
  final List<BoxShadow>? boxShadow;

  const AppButton({
    super.key,
    this.boxShadow,
    this.child,
    this.onPressed,
    this.enable = true,
    this.bgColor,
    this.borderColor,
    this.loading = false,
    this.haveTop = true,
    this.height = 50.0,
    this.radius,
    this.width,
    this.loadingColor,
    this.text,
    this.minWidth,
    this.textColor,
    this.style,
    this.constraints,
    this.activeBgColor,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  void _onTap() {
    if (!widget.loading && widget.onPressed != null && widget.enable) {
      widget.onPressed!.call();
      setState(() {
        _isPressed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("button $_isPressed");
    return InkWell(
      onTap: _onTap,
      borderRadius: BorderRadius.circular(15.r),

      // onHighlightChanged: (isHighlighted) {
      //   // Changer l'état lorsque l'utilisateur sélectionne ou désélectionne le bouton
      //   setState(() {
      //     _isPressed = isHighlighted;
      //   });
      // },
      // highlightColor: Colors.transparent,
      child: Container(
          height: widget.child == null ? widget.height : null,
          width: widget.width,
          
          constraints: widget.constraints,
          padding: widget.child == null
              ? EdgeInsets.symmetric(horizontal: 10.w)
              : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius ?? 16.r),
            color: widget.enable
                // ? widget.bgColor
                ? (_isPressed && widget.activeBgColor != null
                    ? widget.activeBgColor
                    : widget.bgColor)
                : widget.bgColor?.withOpacity(.6),
                boxShadow: widget.boxShadow,
            border: widget.borderColor != null && widget.child == null
                ? Border.all(
                    color: widget.borderColor!,
                    width: 1.5.w,
                  )
                : null,
          ),
          child: widget.loading
              ? CupertinoTheme(
                  data: CupertinoTheme.of(context).copyWith(
                    brightness: widget.bgColor == AppColors.primary
                        ? Brightness.dark
                        : Brightness.light,
                  ),
                  child: CupertinoActivityIndicator(
                    radius: 16.r,
                    color: widget.loadingColor,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.text != null
                        ? Text(
                            widget.text!,
                            style: widget.style ??
                                context.textTheme.titleMedium?.copyWith(
                                  color: widget.textColor != null
                                      ? widget.textColor!
                                      : widget.bgColor == AppColors.primary
                                          ? AppColors.white
                                          : null,
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        : widget.child ?? const SizedBox()
                  ],
                )),
    );
  }
}
