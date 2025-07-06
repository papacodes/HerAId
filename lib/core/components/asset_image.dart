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


class AssetImageWithLoader extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AssetImageWithLoader(
    this.imagePath, {
    super.key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(
            Icons.error,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
