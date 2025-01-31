import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCarouselWidget extends StatelessWidget {
  final List<Widget> children;
  final double? height;
  final bool enableInfiniteScroll;
  final double viewportFraction;
  final CarouselSliderController carouselController;
  final CarouselOptions? carouselOptions;
  final double aspectRatio;

  const AppCarouselWidget({
    super.key,
    required this.children,
    this.height,
    this.viewportFraction = 0.5,
    required this.carouselController,
    this.carouselOptions,
    this.enableInfiniteScroll = false,
    this.aspectRatio = 16 / 9,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        carouselController: carouselController,
        items: [...children],
        options: CarouselOptions(
            aspectRatio: aspectRatio,
            enableInfiniteScroll: enableInfiniteScroll,
            height: height ?? 160.h,
            // enlargeFactor: 0.3,
            viewportFraction: viewportFraction,
            padEnds: false));
  }
}
