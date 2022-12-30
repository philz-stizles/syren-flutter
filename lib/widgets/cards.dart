import 'package:flutter/material.dart';
import 'package:syren/utils/palette.dart';

class ImageCaptionCard extends StatelessWidget {
  const ImageCaptionCard(
      {super.key,
      required this.imageLocation,
      required this.icon,
      required this.title,
      required this.description,
      this.tap});

  final String imageLocation;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: tap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              // fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(imageLocation,
                      // scale: 0.7,
                      width: double.infinity,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            color: Palette.white,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Palette.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Palette.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ],
                      )),
                ) //
              ],
            )));
  }
}
