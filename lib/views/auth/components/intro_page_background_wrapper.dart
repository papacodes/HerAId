import 'package:flutter/material.dart';

import 'package:mzala/core/components/skeleton.dart';

class IntroLoginBackgroundWrapper extends StatelessWidget {
  const IntroLoginBackgroundWrapper({
    super.key,
    required this.imageURL,
  });

  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageURL,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return _IntroLoginBody(image: AssetImage(imageURL));
        }
        return frame == null ? const Skeleton() : _IntroLoginBody(image: AssetImage(imageURL));
      },
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
    );
  }
}

class _IntroLoginBody extends StatelessWidget {
  const _IntroLoginBody({
    required this.image,
  });

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black12.withOpacity(0.1),
                  Colors.black12,
                  Colors.black54,
                  Colors.black54,
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
