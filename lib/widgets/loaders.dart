import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.stroke,
  }) : super(key: key);
  final double width;
  final double height;
  final Color color;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: stroke,
        color: color,
      ),
    );
  }
}

// loading_overlay.dart
class LoadingOverlay extends StatelessWidget {
  LoadingOverlay({Key? key, required this.child}) : super(key: key);

  final Widget child;
  final _isLoading = false.obs;

  static LoadingOverlay of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<LoadingOverlay>()!;
  }

  void show() {
    _isLoading(true);
  }

  void hide() {
    _isLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            child,
            if (_isLoading.value)
              // BackdropFilter(
              //   filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              //   child: Opacity(
              //     opacity: 0.8,
              //     child: ModalBarrier(
              //         dismissible: false,
              //         color: Colors.transparent.withOpacity(0.5)),
              //   ),
              // ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: const Opacity(
                  opacity: 0.6,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
              ),
            if (_isLoading.value)
              Positioned(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator.adaptive(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Loading product details ...',
                      )
                    ],
                  ),
                ),
              )
          ],
        ));
  }
}

class CircularLoader extends StatelessWidget {
  const CircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}
