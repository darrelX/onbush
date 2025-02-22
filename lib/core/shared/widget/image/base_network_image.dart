import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onbush/core/shared/widget/indicator/base_indicator.dart';

class BaseNetworkImage extends StatelessWidget {
  const BaseNetworkImage(this.url, {super.key, this.hasRadius = true});

  final String? url;
  final bool hasRadius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      progressIndicatorBuilder: (context, url, progress) =>
          const BaseIndicator(),
      errorWidget: (_, __, ___) => const BaseIndicator(),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: hasRadius ? BorderRadius.circular(8) : null,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
