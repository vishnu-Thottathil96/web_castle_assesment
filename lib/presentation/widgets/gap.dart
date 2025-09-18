import 'package:flutter/material.dart';
import 'package:flutter_template/core/util/responsive_util.dart';

class Gap {
  Gap._();

  static SizedBox vertical(BuildContext context, double height) {
    return SizedBox(height: ResponsiveHelper.scaleHeight(context, height));
  }

  static SizedBox horizontal(BuildContext context, double width) {
    return SizedBox(width: ResponsiveHelper.scaleWidth(context, width));
  }
}
