import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_radio_list_tile.dart';

@RoutePage()
class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final PageController _pageController = PageController();
  String? _pm;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Column(
            children: [
              Image.asset(
                "assets/images/2.png",
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 360.h,
            child: Container(
              width: 350.w,
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            children: [
              Container(
                width: 350.w,
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                // height: 600.h,
                // color: Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(380.h),
                    Text(
                      "Apprends sans limites avec OnBush",
                      style: context.textTheme.headlineMedium!.copyWith(
                          color: AppColors.primary,
                          shadows: [
                            const Shadow(
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1.0,
                              color: Colors.grey,
                            ),
                          ],
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                    Gap(20.h),
                    const _Widget(
                        title:
                            "Profitez de tous les cours, fiches TD, et corrigés disponibles."),
                    Gap(5.h),
                    const _Widget(
                        title:
                            "Téléchargez vos contenus pour étudier sans connexion Internet."),
                    Gap(5.h),
                    const _Widget(
                        title:
                            "Recevez des alertes pour les nouveaux cours et les examens à venir.."),
                    Gap(5.h),
                    const _Widget(
                        title:
                            "Téléchargez vos contenus pour étudier sans connexion Internet."),
                    Gap(5.h),
                    const _Widget(
                        title:
                            "Visualisez vos progrès académiques grâce à notre tableau de bord interactif."),
                    Gap(20.h),
                    Text(
                      "à seulement 5.000 Fcfa / an.",
                      style: context.textTheme.headlineSmall!
                          .copyWith(color: AppColors.secondary),
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
              Container(
                width: 350.w,
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    Gap(380.h),
                    Text(
                      "Apprends sans limites avec OnBush",
                      style: context.textTheme.headlineMedium!.copyWith(
                          color: AppColors.black,
                          shadows: [
                            const Shadow(
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1.0,
                              color: Colors.grey,
                            ),
                          ],
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                    Gap(20.h),
                    AppRadioListTile(
                      activeColor: AppColors.primary,
                      groupeValue: _pm,
                      title: "Orange Money",
                      selectedColor: AppColors.primary,
                      onChanged: (String? value) {
                        setState(() {
                          _pm = value!;
                        });
                      },
                      value: "Orange Money",
                    ),
                    Gap(20.h),
                    AppRadioListTile(
                      title: "Mobile Money",
                      activeColor: AppColors.primary,
                      groupeValue: _pm,
                      selectedColor: AppColors.primary,
                      onChanged: (String? value) {
                        setState(() {
                          _pm = value!;
                        });
                      },
                      value: "Mobile Money",
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 750.h,
            child: AppButton(
              text: "Continuer",
              width: 320.w,
              textColor: AppColors.white,
              bgColor: AppColors.secondary,
            ),
          )
        ],
      ),
    );
  }
}

class _Widget extends StatelessWidget {
  final String title;
  const _Widget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle,
          color: AppColors.primary,
          size: 30.r,
        ),
        Gap(15.w),
        SizedBox(
          width: 240.w,
          child: Text(
            title,
            style: context.textTheme.labelLarge!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w900,
              shadows: [
                const Shadow(
                  offset: Offset(0.5, 0.5),
                  blurRadius: 1.0,
                  color: Colors.grey,
                ),
              ],
            ),
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
