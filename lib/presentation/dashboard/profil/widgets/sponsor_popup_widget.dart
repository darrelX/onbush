import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/app_init_screen.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/app_dialog.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/theme/app_colors.dart';

class SponsorPopupWidget extends StatefulWidget {
  final Future<void> Function() shareIt;
  final String? sponsorCode;
  const SponsorPopupWidget(
      {super.key, required this.shareIt, required this.sponsorCode});

  @override
  State<SponsorPopupWidget> createState() => _SponsorPopupWidgetState();
}

class _SponsorPopupWidgetState extends State<SponsorPopupWidget> {
  final TextEditingController _sponsorCodeController = TextEditingController();
  bool _copied = false;

  // Fonction pour copier le texte dans le presse-papier
  Future<void> _copyToClipboard() async {
    await Clipboard.setData(
        ClipboardData(text: _sponsorCodeController.text)); // Copie le texte
    setState(() {
      _copied = true; // Active l'état copié
    });

    await AppSnackBar.showSuccess(
        message:
            "Code Parrain ${_sponsorCodeController.text} copie avec success",
        flushbarPosition: FlushbarPosition.BOTTOM,
        context: context);

    // Réinitialiser l'état après 2 secondes pour l'effet visuel
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _copied = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _sponsorCodeController.text = widget.sponsorCode!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Partager ton code ambassadeur et invite tes amis a decouvrir OnBush! Pour chaque inscription avec abonnement, tu gagnes 500 F/utilisateurs.",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, height: 1),
          ),
          Gap(30.h),
          Text(
            "NB : Les utilisateurs doivent s'abonner pour que les recompenses soient validees.",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, height: 1),
          ),
          Gap(20.h),
          AppInput(
            controller: _sponsorCodeController,
            // height: 90.h,
            style: context.textTheme.displayMedium!.copyWith(fontSize: 17.r),
            suffixIcon: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(vertical: 3.5.h),
              child: AppButton(
                text: _copied ? "Copié !" : "Copier",
                textColor: AppColors.white,
                bgColor: AppColors.secondary,
                onPressed: _copyToClipboard,
                height: 2.h,
                width: 90.w,
              ),
            ),
            hint: "505ABZ56",
            // colorBorder: Colors.black,
          ),
          Gap(30.h),
          AppButton(
            text: "Partager",
            height: 50.h,
            width: context.width,
            onPressed: widget.shareIt,
            textColor: AppColors.white,
            bgColor: AppColors.secondary,
          )
        ],
      ),
    );
  }
}
