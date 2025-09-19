import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/util/responsive_util.dart';
import 'package:flutter_template/presentation/widgets/gap.dart';

class BannerCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double heightFactor;
  final Duration interval;

  const BannerCarousel({
    super.key,
    required this.imageUrls,
    this.heightFactor = 150,
    this.interval = const Duration(seconds: 3),
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.imageUrls.length > 1) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.interval, (timer) {
      if (_pageController.hasClients) {
        _currentIndex = (_currentIndex + 1) % widget.imageUrls.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return const SizedBox(); // if no images passed
    }

    double bannerHeight =
        ResponsiveHelper.scaleHeight(context, widget.heightFactor);

    return Column(
      children: [
        SizedBox(
          height: bannerHeight,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.scaleRadius(context, 16),
            ),
            child: PageView.builder(
              controller: _pageController,
              physics: widget.imageUrls.length > 1
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: bannerHeight,
                );
              },
            ),
          ),
        ),
        Gap.vertical(context, 15)
      ],
    );
  }
}
