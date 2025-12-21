import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.decoration,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.onTap,
    this.isReadOnly = false,
    this.scroll = EdgeInsets.zero,
    this.autofocus = false,
    this.maxLines = 1,
    this.labelText,
    this.labelStyle,
    this.fillColor = AppColors.colorWhite,
    this.borderWidth = 1.0,
    this.hintStyle,
    this.autofillHints,
    this.focusedBorderColor = AppColors.neutral600,
    this.style,
    this.cursorHeight,
    this.maxLength,
    this.focusNode,
    this.alignLabelWithHint = false,
    this.onChanged,
    this.contentPadding,
    this.enableInteractiveSelection = true,
    this.contextMenuBuilder,
    this.fieldKey,
    this.onEditingComplete,
  });

  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final InputDecoration? decoration;
  final String? hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enableInteractiveSelection;
  final bool isReadOnly;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final EdgeInsets scroll;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;
  final TextInputAction textInputAction;
  final BorderRadius borderRadius;
  final bool autofocus;
  final int? maxLines;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color fillColor;
  final Color focusedBorderColor;
  final double borderWidth;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Iterable<String>? autofillHints;
  final double? cursorHeight;
  final int? maxLength;
  final bool alignLabelWithHint;
  final GlobalKey<FormFieldState>? fieldKey;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final VoidCallback? onEditingComplete;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool hasInteracted = false;
  bool hasError = false;
  bool isFocused = false;

  @override
  void didUpdateWidget(covariant AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fieldKey?.currentState?.hasError ?? false) {
      setState(() {
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplete,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      autovalidateMode: widget.autovalidateMode,
      scrollPadding: widget.scroll,
      readOnly: widget.isReadOnly,
      onTap: () {
        widget.onTap?.call();
      },
      onChanged: (value) {
        setState(() {
          hasInteracted = true;
        });

        // Validate the field to check if there's an error
        final errorText = widget.validator?.call(value);
        setState(() {
          hasError = errorText != null && errorText.isNotEmpty;
        });

        widget.onChanged?.call(value);
      },
      obscureText: widget.obscureText,
      validator: (value) {
        // Don't show validation error if user hasn't interacted with the field yet
        if (!hasInteracted) {
          return null;
        }

        // Don't show validation error if field is empty
        if (value == null || value.isEmpty) {
          return null;
        }

        // Run the actual validation only after user interaction and when field has content
        return widget.validator?.call(value);
      },
      // obscureText: widget.obscureText,
      // validator: widget.validator,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      cursorHeight: widget.cursorHeight,
      style: context.text.titleMedium!.copyWith(
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none,
      ),
      maxLength: widget.maxLength,
      buildCounter:
          widget.maxLength == null
              ? null
              : (
                context, {
                required currentLength,
                required isFocused,
                required maxLength,
              }) {
                return Text(
                  '$currentLength/$maxLength words',
                  style: TextStyle(
                    color: AppColors.neutral600,
                    fontSize: 12.sp,
                  ),
                );
              },
      enableSuggestions: false,
      autocorrect: false,
      // textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: _getLabelStyle(context),
        counterText: '',
        filled: true,
        isDense: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        alignLabelWithHint: widget.alignLabelWithHint,
        hintStyle:
            widget.hintStyle ??
            AppTextStyles.typography3Regular.copyWith(
              color: AppColors.neutral600,
            ),
        contentPadding:
            widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        enabledBorder: CustomOutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: BorderSide(
            color: AppColors.neutral50,
            width: widget.borderWidth,
          ),
        ),
        focusedBorder: CustomOutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: BorderSide(color: widget.focusedBorderColor),
        ),
        errorBorder: CustomOutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: BorderSide(color: AppColors.error500),
        ),
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          color: AppColors.error500,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        focusedErrorBorder: CustomOutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: BorderSide(width: 2, color: AppColors.error500),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 36,
          minWidth: 40,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon:
            widget.suffixIcon == null
                ? null
                : Focus(
                  canRequestFocus: false,
                  descendantsAreFocusable: false,
                  child: widget.suffixIcon!,
                ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 36,
          minWidth: 40,
        ),
      ),
    );
  }

  TextStyle? _getLabelStyle(BuildContext context) {
    // Get current field value
    final currentValue = widget.controller?.text ?? '';

    // Get the current validation state
    final hasValidationError =
        widget.fieldKey?.currentState?.hasError ?? hasError;

    if (hasInteracted && hasValidationError && currentValue.isNotEmpty) {
      return widget.labelStyle ??
          context.text.titleMedium!.copyWith(
            color: AppColors.error500,
            fontSize: 16,
          );
    }

    if (isFocused) {
      return widget.labelStyle ??
          context.text.titleMedium!.copyWith(
            color: widget.focusedBorderColor,
            fontSize: 16,
          );
    }

    return widget.labelStyle ??
        context.text.titleMedium!.copyWith(
          color: AppColors.neutral600,
          fontSize: 16,
        );
  }
}

class CustomOutlineInputBorder extends InputBorder {
  /// Creates an underline border for an [InputDecorator].
  ///
  /// The [borderSide] parameter defaults to [BorderSide.none] (it must not be
  /// null). Applications typically do not specify a [borderSide] parameter
  /// because the input decorator substitutes its own, using [copyWith], based
  /// on the current theme and [InputDecorator.isFocused].
  ///
  /// The [borderRadius] parameter defaults to a value where the top left
  /// and right corners have a circular radius of 4.0. The [borderRadius]
  /// parameter must not be null.
  const CustomOutlineInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(4),
      topRight: Radius.circular(4),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(4),
    ),
  });

  /// The radii of the border's rounded rectangle corners.
  ///
  /// When this border is used with a filled input decorator, see
  /// [InputDecoration.filled], the border radius defines the shape
  /// of the background fill as well as the bottom left and right
  /// edges of the underline itself.
  ///
  /// By default the top right and top left corners have a circular radius
  /// of 4.0.
  final BorderRadius borderRadius;

  @override
  bool get isOutline => false;

  @override
  CustomOutlineInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
  }) {
    return CustomOutlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.only(bottom: borderSide.width);
  }

  @override
  CustomOutlineInputBorder scale(double t) {
    return CustomOutlineInputBorder(borderSide: borderSide.scale(t));
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(
      Rect.fromLTWH(
        rect.left,
        rect.top,
        rect.width,
        math.max(0, rect.height - borderSide.width),
      ),
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is CustomOutlineInputBorder) {
      return CustomOutlineInputBorder(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is CustomOutlineInputBorder) {
      return CustomOutlineInputBorder(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  /// Draw a horizontal line at the bottom of [rect].
  ///
  /// The [borderSide] defines the line's color and weight. The `textDirection`
  /// `gap` and `textDirection` parameters are ignored.
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = borderSide.toPaint();
    final outer = borderRadius.toRRect(rect);
    final center = outer.deflate(borderSide.width / 2.0);
    canvas.drawRRect(center, paint);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is InputBorder && other.borderSide == borderSide;
  }

  @override
  int get hashCode => borderSide.hashCode;
}
