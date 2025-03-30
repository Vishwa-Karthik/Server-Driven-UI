// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:server_driven_ui/core/utils/app_strings.dart';

// import 'package:server_driven_ui/features/login/presentation/pages/login_page.dart';
// import 'package:server_driven_ui/features/sign_up/presentation/pages/sign_up_page.dart';

// typedef ComponentAction = void Function(BuildContext context);

// class ComponentFactory {
//   static Widget buildComponent(
//     Map<String, dynamic> json,
//     BuildContext context, {
//     GlobalKey<FormState>? formKey,
//   }) {
//     switch (json['type']) {
//       case 'text':
//         return Text(
//           json['value'] ?? '',
//           style: TextStyle(
//             fontSize: json['fontSize']?.toDouble() ?? 16,
//             color: _parseColor(json['color']) ?? Colors.white,
//             fontWeight: _parseFontWeight(json['fontWeight']),
//           ),
//           textAlign: _parseTextAlignment(json['alignment']),
//         );
//       case 'textField':
//         return Padding(
//           padding: _parseEdgeInsets(json['margin']),
//           child: TextField(
//             style: TextStyle(
//               fontSize: json['fontSize']?.toDouble() ?? 16,
//               color: _parseColor(json['color']) ?? Colors.white,
//               fontWeight: _parseFontWeight(json['fontWeight']),
//             ),

//             decoration: InputDecoration(
//               hintText: json['placeholder'],
//               hintStyle: TextStyle(
//                 color: _parseColor(json['placeholderColor']),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: _parseColor(json['borderColor']) ?? Colors.grey,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: _parseColor(json['borderColor']) ?? Colors.grey,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: _parseColor(json['borderColor']) ?? Colors.grey,
//                 ),
//               ),
//             ),
//             obscureText: json['obscureText'] ?? false,
//           ),
//         );
//       case 'button':
//         return Padding(
//           padding: _parseEdgeInsets(json['padding']),
//           child: ElevatedButton(
//             onPressed:
//                 () => _handleAction(
//                   json['action'],
//                   json['children']?[0]['target'],
//                   context,
//                   formKey: formKey,
//                 ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: _parseColor(json['backgroundColor']),
//             ),
//             child: Text(
//               json['label'] ?? '',
//               style: TextStyle(
//                 color: _parseColor(json['textColor']),
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         );
//       case 'spacer':
//         return SizedBox(height: json['height']?.toDouble() ?? 10);
//       case 'richText':
//         return GestureDetector(
//           onTap:
//               () => _handleAction(
//                 json['children']?[0]['action'],
//                 json['children']?[0]['target'],
//                 context,
//               ),
//           child: RichText(
//             text: TextSpan(
//               text: json['text'],
//               style: _parseTextStyle(json['textStyle']),
//               children:
//                   (json['children'] as List<dynamic>?)?.map((child) {
//                     return TextSpan(
//                       text: child['text'],
//                       style: _parseTextStyle(child['style']),
//                     );
//                   }).toList() ??
//                   [],
//             ),
//           ),
//         );
//       default:
//         return SizedBox.shrink();
//     }
//   }

//   static Color? _parseColor(String? hexColor) {
//     if (hexColor == null || !hexColor.startsWith('#')) return null;
//     return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
//   }

//   static FontWeight? _parseFontWeight(String? weight) {
//     switch (weight) {
//       case 'bold':
//         return FontWeight.bold;
//       default:
//         return FontWeight.normal;
//     }
//   }

//   static TextAlign _parseTextAlignment(String? alignment) {
//     switch (alignment) {
//       case 'center':
//         return TextAlign.center;
//       case 'right':
//         return TextAlign.right;
//       default:
//         return TextAlign.left;
//     }
//   }

//   static EdgeInsets _parseEdgeInsets(List<dynamic>? values) {
//     if (values == null || values.length != 4) return EdgeInsets.zero;
//     return EdgeInsets.fromLTRB(
//       values[0].toDouble(),
//       values[1].toDouble(),
//       values[2].toDouble(),
//       values[3].toDouble(),
//     );
//   }

//   static TextStyle _parseTextStyle(Map<String, dynamic>? style) {
//     return TextStyle(
//       fontSize: style?['fontSize']?.toDouble() ?? 16,
//       fontWeight: _parseFontWeight(style?['fontWeight']),
//       color: _parseColor(style?['color']) ?? Colors.black,
//     );
//   }

//   static void _handleAction(
//     String? action,
//     String? target,
//     BuildContext context, {
//     GlobalKey<FormState>? formKey,
//   }) {
//     if (action == null) return;
//     if (formKey != null && formKey.currentState != null) {
//       if (!formKey.currentState!.validate()) return;
//     }
//     switch (action) {
//       case 'navigate':
//         if (target == AppString.signUpScreen) {
//           Navigator.pushReplacement(context, SignUpPage.route());
//         } else if (target == AppString.loginScreen) {
//           Navigator.pushReplacement(context, LoginPage.route());
//         }
//         break;

//       default:
//         log('Unknown action: $action');
//         break;
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:developer';

// /// Callback for component actions
// typedef ComponentAction =
//     void Function(BuildContext context, String action, String? target);

// /// Text Component
// class TextComponent extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   final Color color;
//   final FontWeight fontWeight;
//   final TextAlign textAlign;

//   const TextComponent({
//     super.key,
//     required this.text,
//     this.fontSize = 16,
//     this.color = Colors.white,
//     this.fontWeight = FontWeight.normal,
//     this.textAlign = TextAlign.left,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: fontSize,
//         color: color,
//         fontWeight: fontWeight,
//       ),
//       textAlign: textAlign,
//     );
//   }
// }

// /// TextField Component
// class TextFieldComponent extends StatelessWidget {
//   final TextEditingController controller;
//   final String placeholder;
//   final Color placeholderColor;
//   final Color borderColor;
//   final bool obscureText;
//   final EdgeInsets margin;
//   final ValueChanged<String> onChanged;

//   const TextFieldComponent({
//     super.key,
//     required this.controller,
//     this.placeholder = '',
//     this.placeholderColor = Colors.grey,
//     this.borderColor = Colors.grey,
//     this.obscureText = false,
//     this.margin = EdgeInsets.zero,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: margin,
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           hintText: placeholder,
//           hintStyle: TextStyle(color: placeholderColor),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(color: borderColor),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(color: borderColor),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(color: borderColor),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Button Component
// class ButtonComponent extends StatelessWidget {
//   final String label;
//   final Color backgroundColor;
//   final Color textColor;
//   final ComponentAction onAction;
//   final String action;
//   final String? target;
//   final EdgeInsets padding;

//   const ButtonComponent({
//     super.key,
//     required this.label,
//     required this.onAction,
//     this.backgroundColor = Colors.blue,
//     this.textColor = Colors.white,
//     required this.action,
//     this.target,
//     this.padding = EdgeInsets.zero,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding,
//       child: ElevatedButton(
//         onPressed: () => onAction(context, action, target),
//         style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
//         child: Text(label, style: TextStyle(color: textColor, fontSize: 16)),
//       ),
//     );
//   }
// }

// /// Spacer Component
// class SpacerComponent extends StatelessWidget {
//   final double height;

//   const SpacerComponent({super.key, this.height = 10});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(height: height);
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef OnComponentEvent = void Function(String componentId, dynamic value);

class ComponentFactory {
  static Widget buildComponent(
    Map<String, dynamic> component,
    BuildContext context, {
    required OnComponentEvent onEvent,
    GlobalKey<FormState>? formKey,
  }) {
    switch (component['type']) {
      case 'text':
        return _buildText(component);
      case 'textField':
        return _buildTextField(component, onEvent);
      case 'button':
        return _buildButton(component, onEvent);
      case 'spacer':
        return SizedBox(height: component['height']?.toDouble() ?? 10);
      case 'richText':
        return _buildRichText(component, onEvent);
      default:
        return const SizedBox.shrink();
    }
  }

  static Widget _buildText(Map<String, dynamic> component) {
    return Text(
      component['value'] ?? '',
      style: TextStyle(
        fontSize: component['fontSize']?.toDouble() ?? 16,
        fontWeight:
            component['fontWeight'] == 'bold'
                ? FontWeight.bold
                : FontWeight.normal,
        color: _hexToColor(component['color']) ?? Colors.black,
      ),
      textAlign: _parseAlignment(component['alignment']),
    );
  }

  static Widget _buildTextField(
    Map<String, dynamic> component,
    OnComponentEvent onEvent,
  ) {
    return Padding(
      padding: _parseEdgeInsets(component['margin']),
      child: TextFormField(
        style: TextStyle(
          fontSize: component['fontSize']?.toDouble() ?? 16,
          color: _hexToColor(component['color']) ?? Colors.white,
        ),
        decoration: InputDecoration(
          hintText: component['placeholder'] ?? '',
          border: OutlineInputBorder(),
        ),
        keyboardType: _parseKeyboardType(component['keyboardType']),
        obscureText: component['obscureText'] ?? false,
        onChanged: (value) => onEvent(component['id'], value),
      ),
    );
  }

  static Widget _buildButton(
    Map<String, dynamic> component,
    OnComponentEvent onEvent,
  ) {
    return Padding(
      padding: _parseEdgeInsets(component['padding']),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _hexToColor(component['backgroundColor']),
        ),
        onPressed: () => onEvent(component['action'], null),
        child: Text(
          component['label'] ?? 'Button',
          style: TextStyle(
            color: _hexToColor(component['textColor']) ?? Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget _buildRichText(
    Map<String, dynamic> component,
    OnComponentEvent onEvent,
  ) {
    List<TextSpan> children =
        (component['children'] as List<dynamic>?)
            ?.map(
              (child) => TextSpan(
                text: child['text'],
                style: TextStyle(
                  fontSize: child['style']['fontSize']?.toDouble() ?? 16,
                  fontWeight:
                      child['style']['fontWeight'] == 'bold'
                          ? FontWeight.bold
                          : FontWeight.normal,
                  color: _hexToColor(child['style']['color']) ?? Colors.blue,
                ),
                recognizer:
                    child['action'] != null
                        ? (TapGestureRecognizer()
                          ..onTap =
                              () => onEvent(child['action'], child['target']))
                        : null,
              ),
            )
            .toList() ??
        [];

    return RichText(
      text: TextSpan(
        text: component['text'] ?? '',
        style: TextStyle(
          fontSize: component['textStyle']['fontSize']?.toDouble() ?? 16,
          color: _hexToColor(component['textStyle']['color']) ?? Colors.black,
        ),
        children: children,
      ),
    );
  }

  static TextAlign _parseAlignment(String? alignment) {
    switch (alignment) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  static TextInputType _parseKeyboardType(String? type) {
    switch (type) {
      case 'email':
        return TextInputType.emailAddress;
      case 'password':
        return TextInputType.text;
      default:
        return TextInputType.text;
    }
  }

  static EdgeInsets _parseEdgeInsets(List<dynamic>? padding) {
    if (padding == null || padding.length != 4) {
      return EdgeInsets.zero;
    }
    return EdgeInsets.fromLTRB(
      padding[0].toDouble(),
      padding[1].toDouble(),
      padding[2].toDouble(),
      padding[3].toDouble(),
    );
  }

  static Color? _hexToColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }
}
