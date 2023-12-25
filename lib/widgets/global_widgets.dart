import 'package:get/get.dart';

import '../utils/colors.dart';

class GlobalWidgets {
  static GetSnackBar globalSnackBar(String title, String? message) {
    return GetSnackBar(
      title: title,
      duration: const Duration(seconds: 3),
      backgroundColor: AppColors.darkColor,
      message: message,
    );
  }
}
