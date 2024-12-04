import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/history/presentation/widgets/history_widget.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';
import 'package:onbush/shared/widget/app_carousel_widget.dart';
import 'package:onbush/shared/widget/app_input.dart';

@RoutePage()
class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final List<String> _list = [
    "Tout",
    "Resume de cous",
    "Sujets d'exam",
    "Controle Continu",
    "TD"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          Image.asset("assets/icons/leading-icon-circle.png"),
          Gap(20.w),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              "Vos telechargements",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
            ),
          ),
          Gap(20.h),
          SizedBox(
            height: 50.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              itemBuilder: (context, index) {
                // if (index == 0) {
                //   return SizedBox(width: 20.w);
                // } else {

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: AppButton(
                    text: _list[index],
                    radius: 9.r,
                    // width: 110.w,
                    bgColor: AppColors.grey,
                  ),
                );
                // }
              },
              itemCount: _list.length,
              // shrinkWrap: true,
            ),
          ),
          Gap(30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppInput(
                  hint: "Chercher un cours",
                  width: context.width,
                  prefix: const Icon(Icons.search),
                ),
                Gap(20.h),
                const HistoryWidget(),
                Gap(20.h),
                const HistoryWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
