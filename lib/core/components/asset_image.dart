import 'package:flutter/material.dart';

import 'package:mzala/core/constants/app_defaults.dart';
import 'skeleton.dart';

class AssetImageWithLoader extends StatelessWidget {
  final BoxFit fit;

  /// This widget is used for displaying local asset images with a placeholder
  const AssetImageWithLoader(
    this.assetPath, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = AppDefaults.radius,
    this.borderRadius,
  });

  final String assetPath;
  final double radius;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
      child: Image.asset(
        assetPath,
        fit: fit,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(assetPath),
                  fit: fit,
                ),
              ),
            );
          }
          return frame == null ? const Skeleton() : child;
        },
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }
}
