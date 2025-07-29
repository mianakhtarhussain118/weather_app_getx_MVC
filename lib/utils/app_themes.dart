import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomThemes {
  static final light_theme = ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: "Poppins",
      primaryColor: AppColors.c2,
      cardColor: AppColors.cardTwo,
      iconTheme: IconThemeData(
        color: AppColors.c5,
      ));

  static final dark_theme = ThemeData(
      scaffoldBackgroundColor: AppColors.bg,
      fontFamily: "Poppins",
      primaryColor: AppColors.white,
      cardColor: AppColors.card,
      iconTheme: IconThemeData(
        color: AppColors.white,
      ));
}
