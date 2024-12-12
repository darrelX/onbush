import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/theme/app_colors.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      padding:
          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/icons/leading-icon.png",
            fit: BoxFit.fill,
            height: 60.h,
            color: AppColors.black,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200.w,
                child: Text(
                  "Lorem ipsum indolors apsum Lorem ipsum indolors apsum 90",
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: 14.r, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                ),
              ),
              // Spacer(),
              SizedBox(
                width: 220.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Resume de cours",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontSize: 13.r,
                          color: Colors.grey.shade600),
                    ),
                    Text(
                      "Il y'a 2h",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontSize: 13.r,
                          color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 16.r,
          )
        ],
      ),
    );
  }
}
