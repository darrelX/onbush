import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';

import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
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

  const AppButton({
    super.key,
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (!loading && enable && onPressed != null) ? onPressed : null,
      borderRadius: BorderRadius.circular(15.r),
      highlightColor: Colors.transparent,
      child: Container(
          height: height,
          width: width,
          constraints: constraints,
          padding:
              child == null ? EdgeInsets.symmetric(horizontal: 10.w) : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 16.r),
            color: enable ? bgColor : bgColor?.withOpacity(.6),
            border: borderColor != null
                ? Border.all(
                    color: borderColor!,
                    width: 1.5.w,
                  )
                : null,
          ),
          child: loading
              ? CupertinoTheme(
                  data: CupertinoTheme.of(context).copyWith(
                    brightness: bgColor == AppColors.primary
                        ? Brightness.dark
                        : Brightness.light,
                  ),
                  child: CupertinoActivityIndicator(
                    radius: 16.r,
                    color: loadingColor,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text != null
                        ? Text(
                            text!,
                            style: style ??
                                context.textTheme.titleMedium?.copyWith(
                                  color: textColor != null
                                      ? textColor!
                                      : bgColor == AppColors.primary
                                          ? AppColors.white
                                          : null,
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        : child ?? const SizedBox()
                  ],
                )),
    );
  }
}
