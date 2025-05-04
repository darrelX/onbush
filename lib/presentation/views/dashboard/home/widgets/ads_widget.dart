import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 190.h,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 180.w,
                      child: Text(
                        "Deviens Parrain, Partage et Récolte des Récompenses !",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontSize: 17.r,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white),
                        textAlign: TextAlign.left,
                        maxLines: 3,
                      )),
                  AppButton(
                    text: "Devenir Parrain",
                    bgColor: AppColors.sponsorButton,
                    onPressed: () {
                      context.router.push(const AmbassadorSpaceRoute());
                    },
                    width: 158.w,
                    height: 35.h,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.r,
                        color: AppColors.white),
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        Positioned(
            right: 5.w,
            bottom: 0,
            child: Image.asset(
              AppImage.sponsorImage,
              height: 170.h,
              fit: BoxFit.fitHeight,
            )),
      ],
    );
  }
}
