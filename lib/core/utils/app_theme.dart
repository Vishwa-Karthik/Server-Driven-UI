import 'package:flutter/material.dart';
import 'package:server_driven_ui/core/utils/app_colors.dart';

class AppTheme {
  final Map<String, dynamic>? appTheme;

  const AppTheme({this.appTheme});

  ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor:
          AppColors.parseColor(
            appTheme?['themes']['light_mode']['colors']['background']
                as String?,
          ) ??
          Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor:
            AppColors.parseColor(
              appTheme?['themes']['light_mode']['colors']['background']
                  as String?,
            ) ??
            Colors.white,
      ),
      fontFamily: appTheme?['themes']['light_mode']['fontFamily'],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              AppColors.parseColor(
                appTheme?['themes']['light_mode']['colors']['primary']
                    as String?,
              ) ??
              Colors.white,
          foregroundColor:
              AppColors.parseColor(appTheme?['textColor'] as String?) ??
              Colors.white,
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor:
          AppColors.parseColor(
            appTheme?['themes']['dark_mode']['colors']['backgroundColor']
                as String?,
          ) ??
          Colors.black,
      colorScheme: ColorScheme.fromSeed(
        seedColor:
            AppColors.parseColor(
              appTheme?['themes']['dark_mode']['colors']['backgroundColor']
                  as String?,
            ) ??
            Colors.white,
      ),
      fontFamily: appTheme?['themes']['dark_mode']['fontFamily'],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              AppColors.parseColor(
                appTheme?['themes']['dark_mode']['colors']['primary']
                    as String?,
              ) ??
              Colors.white,
          foregroundColor:
              AppColors.parseColor(appTheme?['textColor'] as String?) ??
              Colors.white,
        ),
      ),
    );
  }
}
