import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/app_input.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:share_plus/share_plus.dart';

class SponsorPopupWidget extends StatefulWidget {
  final String? sponsorCode;
  const SponsorPopupWidget({super.key, required this.sponsorCode});

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

    await AppSnackBar.showConfig(
        child: Text(
          "texte copié dans le presse papier",
          style: TextStyle(color: AppColors.white, fontSize: 15.r),
        ),
        leading: Image.asset(
          "assets/images/onbushicon.png",
          color: AppColors.white,
          height: 30,
          width: 30,
        ),
        trailling: SvgPicture.asset(
          "assets/icons/course_downloaded.svg",
          color: AppColors.white,
        ),
        backgroundColor: AppColors.secondary,
        flushbarPosition: FlushbarPosition.BOTTOM,
        context: context);

    // Réinitialiser l'état après 2 secondes pour l'effet visuel
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _copied = false;
    });
  }

  Future<void> _shareWithSubject() async {
    String textToShare = """OnBush,
L'application qui réunit tes cours, anciens sujets et corrigés en un seul lieu. Utilise mon code *${_sponsorCodeController.text}* pour une réduction de 500 FCFA : https://onbush.com/dl?code=${_sponsorCodeController.text}""";
    const subjectToShare = 'Découvrez cette technologie géniale';

    try {
      await Share.share(
        textToShare,
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
      );
      print('Partage réussi');
    } catch (e) {
      print('Erreur lors du partage : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _sponsorCodeController.text = widget.sponsorCode!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
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
          Gap(20.h),
          Text(
            "NB : Les utilisateurs doivent s'abonner pour que les recompenses soient validees.",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, height: 1),
          ),
          Gap(20.h),
          AppInput(
            controller: _sponsorCodeController,
            // height: 90.h,
            style: context.textTheme.displayMedium!.copyWith(fontSize: 15.r),
            readOnly: true,
            suffixIcon: Container(
              margin: EdgeInsets.only(right: 7.w),
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
            onPressed: _shareWithSubject,
            textColor: AppColors.white,
            bgColor: AppColors.secondary,
          )
        ],
      ),
    );
  }
}
