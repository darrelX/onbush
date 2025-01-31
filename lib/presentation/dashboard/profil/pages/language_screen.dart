import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:onbush/core/shared/widget/app_radio_list_tile.dart';

@RoutePage()
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final String _groupeValue = "fr";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        title: const Text("Espace Parrain"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30.h),
            Text(
              "Langues",
              style: context.textTheme.displaySmall,
            ),
            Gap(40.h),
            AppRadioListTile(
                groupeValue: _groupeValue,
                onChanged: (value) {
                  // setState(() {
                  //   _groupeValue = value;
                  // });
                },
                value: "fr",
                activeColor: AppColors.primary,
                title: "Francais"),
            Gap(20.h),
            IgnorePointer(
              ignoring: true,
              child: Opacity(
                opacity: 0.3,
                child: AppRadioListTile(
                    groupeValue: _groupeValue,
                    onChanged: (value) {
                      // setState(() {
                      //   _groupeValue = value;
                      // });
                    },
                    value: "en",
                    activeColor: AppColors.primary,
                    title: "Anglais"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
