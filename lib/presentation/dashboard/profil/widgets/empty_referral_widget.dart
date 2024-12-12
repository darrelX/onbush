import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EmptyReferralWidget extends StatelessWidget {
  const EmptyReferralWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      
               
    Container(
      height: 200.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF88C9FF),
      ),
    ),
    Gap(10.h),
    SizedBox(
      width: 200.w,
      child: const Text(
        "Tu n'as pas encore de filleuls. Partage ton lien Parrain et commence à gagner des récompenses dès maintenant !",
        style: TextStyle(color: Color(0xff969DAC)),
        maxLines: 3,
        textAlign: TextAlign.center,
      ),
    ),
      ],
    );
  }
}
