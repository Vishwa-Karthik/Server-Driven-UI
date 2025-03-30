import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:server_driven_ui/core/utils/app_strings.dart';

import 'package:server_driven_ui/features/login/presentation/pages/login_page.dart';
import 'package:server_driven_ui/features/sign_up/presentation/pages/sign_up_page.dart';

typedef ComponentAction = void Function(BuildContext context);

class ComponentFactory {
  static Widget buildComponent(
    Map<String, dynamic> json,
    BuildContext context, {
    GlobalKey<FormState>? formKey,
  }) {
    switch (json['type']) {
      case 'text':
        return Text(
          json['value'] ?? '',
          style: TextStyle(
            fontSize: json['fontSize']?.toDouble() ?? 16,
            color: _parseColor(json['color']) ?? Colors.black,
            fontWeight: _parseFontWeight(json['fontWeight']),
          ),
          textAlign: _parseTextAlignment(json['alignment']),
        );
      case 'textField':
        return Padding(
          padding: _parseEdgeInsets(json['margin']),
          child: TextField(
            decoration: InputDecoration(hintText: json['placeholder']),
            obscureText: json['obscureText'] ?? false,
          ),
        );
      case 'button':
        return Padding(
          padding: _parseEdgeInsets(json['padding']),
          child: ElevatedButton(
            onPressed:
                () => _handleAction(
                  json['action'],
                  json['children']?[0]['target'],
                  context,
                  formKey: formKey,
                ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _parseColor(json['backgroundColor']),
            ),
            child: Text(
              json['label'] ?? '',
              style: TextStyle(
                color: _parseColor(json['textColor']),
                fontSize: 16,
              ),
            ),
          ),
        );
      case 'spacer':
        return SizedBox(height: json['height']?.toDouble() ?? 10);
      case 'richText':
        return GestureDetector(
          onTap:
              () => _handleAction(
                json['children']?[0]['action'],
                json['children']?[0]['target'],
                context,
              ),
          child: RichText(
            text: TextSpan(
              text: json['text'],
              style: _parseTextStyle(json['textStyle']),
              children:
                  (json['children'] as List<dynamic>?)?.map((child) {
                    return TextSpan(
                      text: child['text'],
                      style: _parseTextStyle(child['style']),
                    );
                  }).toList() ??
                  [],
            ),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  static Color? _parseColor(String? hexColor) {
    if (hexColor == null || !hexColor.startsWith('#')) return null;
    return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
  }

  static FontWeight? _parseFontWeight(String? weight) {
    switch (weight) {
      case 'bold':
        return FontWeight.bold;
      default:
        return FontWeight.normal;
    }
  }

  static TextAlign _parseTextAlignment(String? alignment) {
    switch (alignment) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  static EdgeInsets _parseEdgeInsets(List<dynamic>? values) {
    if (values == null || values.length != 4) return EdgeInsets.zero;
    return EdgeInsets.fromLTRB(
      values[0].toDouble(),
      values[1].toDouble(),
      values[2].toDouble(),
      values[3].toDouble(),
    );
  }

  static TextStyle _parseTextStyle(Map<String, dynamic>? style) {
    return TextStyle(
      fontSize: style?['fontSize']?.toDouble() ?? 16,
      fontWeight: _parseFontWeight(style?['fontWeight']),
      color: _parseColor(style?['color']) ?? Colors.black,
    );
  }

  static void _handleAction(
    String? action,
    String? target,
    BuildContext context, {
    GlobalKey<FormState>? formKey,
  }) {
    if (action == null) return;
    if (formKey != null && formKey.currentState != null) {
      if (!formKey.currentState!.validate()) return;
    }
    switch (action) {
      case 'navigate':
        if (target == AppString.signUpScreen) {
          Navigator.pushReplacement(context, SignUpPage.route());
        } else if (target == AppString.loginScreen) {
          Navigator.pushReplacement(context, LoginPage.route());
        }
        break;
 

      default:
        log('Unknown action: $action');
        break;
    }
  }
}
