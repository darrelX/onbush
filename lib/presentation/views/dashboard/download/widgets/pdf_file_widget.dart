import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:gap/gap.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';

class PdfFileWidget extends StatefulWidget {
  final PdfFileEntity pdfFileEntity;
  const PdfFileWidget({super.key, required this.pdfFileEntity});

  @override
  State<PdfFileWidget> createState() => _PdfFileWidgetState();
}

class _PdfFileWidgetState extends State<PdfFileWidget> {
  // Bloque les captures d'écran
  void _enableSecureMode() async {
    await FlutterWindowManagerPlus.addFlags(
        FlutterWindowManagerPlus.FLAG_SECURE);
  }

  @override
  void initState() {
    super.initState();
    _enableSecureMode();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router
            .push(DownloadPdfViewRoute(pdfFileEntity: widget.pdfFileEntity));
      },
      child: Container(
        height: 65.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/icons/leading-icon.png",
              fit: BoxFit.fill,
              height: 60.h,
              color: AppColors.black,
            ),
            Gap(20.w),
            Expanded(
              child: Container(
                // color: AppColors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        widget.pdfFileEntity.name!,
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontSize: 14.r, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        // width: 220.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.pdfFileEntity.category!,
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontSize: 13.r, color: Colors.grey.shade600),
                            ),
                            Text(
                              "${widget.pdfFileEntity.updatedDate?.timeAgoShort()}",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontSize: 13.r, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Gap(15.w),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16.r,
            )
          ],
        ),
      ),
    );
  }
}
