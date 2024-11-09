import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shop/logic/cubit/product_cubit.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/const.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.id,
    required this.state,
    this.isShop = false,
  });
  final String image;
  final String id;
  final String title;
  final double price;
  final int quantity;
  final bool isShop;
  final ProductUpdatedState state;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    // final instance = context.read<ProductProvider>();
    final cubit = getIt.get<ProductCubit>();

    return Visibility(
      visible: widget.isShop
          ? (widget.state.counters[widget.id]! < 1 ? false : true)
          : true,
      child: Container(
        height: 90.h,
        // width: 0,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A191C32),
              offset: Offset(2, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x1A191C32),
              offset: Offset(-4, 6),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        child: Row(
          children: [
            Image.asset(
              widget.image,
            ),
            Gap(20.h),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${widget.price} nkap",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IgnorePointer(
                      ignoring:
                          widget.state.counters[widget.id]! > 0 ? false : true,
                      child: Opacity(
                        opacity:
                            widget.state.counters[widget.id]! > 0 ? 1 : 0.5,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              cubit.decrement(widget.id);
                            });
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              radius10,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(
                                radius10,
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/remove.svg',
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(8.w),
                    Text(
                      '${widget.state.counters[widget.id]}',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(8.w),
                    IgnorePointer(
                      ignoring:
                          widget.state.counters[widget.id]! < widget.quantity
                              ? false
                              : true,
                      child: Opacity(
                        opacity:
                            widget.state.counters[widget.id]! < widget.quantity
                                ? 1
                                : 0.5,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              cubit.increment(widget.id, widget.quantity);
                            });
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              radius10,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(
                                radius10,
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/add.svg',
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
