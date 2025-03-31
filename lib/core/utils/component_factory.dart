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
