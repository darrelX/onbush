import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';

import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? borderColor;
  final bool enable;
  final bool haveTop;
  final bool loading;
  final Color? loadingColor;
  final double height;
  final String? text;
  final double? width;
  final Color? textColor;

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
    this.width = 100,
    this.loadingColor,
    this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      // width: width,

      padding: EdgeInsets.symmetric(horizontal: 10.r),
      constraints: BoxConstraints(minWidth: width!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: enable ? bgColor : bgColor?.withOpacity(.6),
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: 1.5,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (!loading && enable && onPressed != null) ? onPressed : null,
          borderRadius: BorderRadius.circular(15.r),
          child: Center(
            child: loading
                ? CupertinoTheme(
                    data: CupertinoTheme.of(context).copyWith(
                      brightness: bgColor == AppColors.primary
                          ? Brightness.dark
                          : Brightness.light,
                    ),
                    child: CupertinoActivityIndicator(
                      radius: 16,
                      color: loadingColor,
                    ),
                  )
                : text != null
                    ? Text(
                        text!,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: textColor != null
                              ? textColor!
                              : bgColor == AppColors.primary
                                  ? AppColors.white
                                  : null,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : child,
          ),
        ),
      ),
    );
  }
}
