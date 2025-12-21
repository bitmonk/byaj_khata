import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:byaz_track/core/constants/app_colors.dart';
import 'package:byaz_track/utlis/app_text_styles.dart';

class AppTextLocationField extends StatefulWidget {
  const AppTextLocationField({
    super.key,
    required this.googleAPIKey,
    required this.textEditingController,
    required this.onPlaceDetailsWithCoordinatesReceived,
    required this.onSuggestionClicked,
    this.debounceTime = 400,
    this.countries = const [],
    this.getAllDetails = false,
    this.onPlaceDetailsReceived,
    this.validator,
    this.hintText = '',
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.onTap,
    this.isReadOnly = false,
    this.autofocus = false,
    this.labelText = 'Location',
    this.fillColor = AppColors.colorWhite,
    this.borderWidth = 1.0,
    this.hintStyle,
    this.style,
    this.cursorHeight,
    this.maxLength,
    this.focusNode,
    this.alignLabelWithHint = false,
    this.contentPadding,
    this.suggestionValidator = false,
    this.onClear,
    this.showClearButton = true,
  });

  final String googleAPIKey;
  final TextEditingController textEditingController;
  final void Function(Prediction) onPlaceDetailsWithCoordinatesReceived;
  final void Function(Prediction) onSuggestionClicked;
  final int debounceTime;
  final List<String> countries;
  final bool getAllDetails;
  final void Function(Map<String, dynamic>)? onPlaceDetailsReceived;
  final String? Function(String?)? validator;
  final VoidCallback? onClear;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isReadOnly;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;
  final TextInputAction textInputAction;
  final BorderRadius borderRadius;
  final bool autofocus;
  final String? labelText;
  final Color fillColor;
  final Color focusedBorderColor = AppColors.neutral600;
  final double borderWidth;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final double? cursorHeight;
  final int? maxLength;
  final bool alignLabelWithHint;
  final EdgeInsets? contentPadding;
  final bool suggestionValidator;
  final bool showClearButton;

  @override
  State<AppTextLocationField> createState() => _AppTextLocationFieldState();
}

class _AppTextLocationFieldState extends State<AppTextLocationField> {
  bool _isSuggestionSelected = false;
  String _lastSelectedPredictionText = '';
  late final VoidCallback _controllerListener;
  String? _initialText; // Store initial text to detect untouched state

  @override
  void initState() {
    super.initState();

    // Initialize _isSuggestionSelected based on pre-filled text
    _initialText = widget.textEditingController.text;
    if (_initialText?.isNotEmpty ?? false) {
      _isSuggestionSelected =
          true; // Treat pre-filled text as a valid selection
      _lastSelectedPredictionText = _initialText!;
    }

    _controllerListener = () {
      if (_isSuggestionSelected &&
          widget.textEditingController.text != _lastSelectedPredictionText) {
        setState(() {
          _isSuggestionSelected = false; // Reset if user modifies text
        });
      }
    };

    widget.textEditingController.addListener(_controllerListener);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_controllerListener);
    super.dispose();
  }

  Future<void> fetchPlaceDetails(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component,geometry,formatted_address&key=${widget.googleAPIKey}";

    final response = await Dio().get(url);
    final result = response.data['result'];

    String? streetNumber, route, city, state, country, postalCode;
    for (var component in result['address_components']) {
      List types = component['types'];
      if (types.contains('street_number'))
        streetNumber = component['long_name'];
      if (types.contains('route')) route = component['long_name'];
      if (types.contains('locality')) city = component['long_name'];
      if (types.contains('administrative_area_level_1'))
        state = component['long_name'];
      if (types.contains('country')) country = component['long_name'];
      if (types.contains('postal_code')) postalCode = component['long_name'];
    }

    final addressLine = [streetNumber, route].where((e) => e != null).join(' ');
    final latitude = result['geometry']['location']['lat'];
    final longitude = result['geometry']['location']['lng'];

    final placeDetails = {
      'addressLine': addressLine,
      'city': city ?? '',
      'state': state ?? '',
      'country': country ?? '',
      'postalCode': postalCode ?? '',
      'latitude': latitude,
      'longitude': longitude,
    };

    widget.onPlaceDetailsReceived?.call(placeDetails);
  }

  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      // onChanged: (String text) {
      //   print('Text changed: $text');
      // },
      focusNode: widget.focusNode,
      textEditingController: widget.textEditingController,
      googleAPIKey: widget.googleAPIKey,
      debounceTime: widget.debounceTime,
      countries: widget.countries.isEmpty ? null : widget.countries,
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (Prediction prediction) {
        if (!_isSuggestionSelected && widget.getAllDetails) {
          fetchPlaceDetails(prediction.placeId!);
        }
        widget.onPlaceDetailsWithCoordinatesReceived(prediction);
        setState(() {
          _isSuggestionSelected = true;
          _lastSelectedPredictionText = prediction.description ?? '';
        });
      },
      itemClick: (Prediction prediction) {
        widget.textEditingController.text = prediction.description ?? '';
        widget.textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: prediction.description?.length ?? 0),
        );
        widget.onSuggestionClicked(prediction);
        setState(() {
          _isSuggestionSelected = true;
          _lastSelectedPredictionText = prediction.description ?? '';
        });
        if (widget.getAllDetails) {
          fetchPlaceDetails(prediction.placeId!);
        }
      },
      itemBuilder: (context, index, Prediction prediction) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.neutral600),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  prediction.description ?? "",
                  style: AppTextStyles.typography3Regular.copyWith(
                    color: AppColors.neutral800,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      seperatedBuilder: const Divider(),
      isCrossBtnShown: widget.showClearButton,
      placeType: PlaceType.geocode,
      keyboardType: TextInputType.streetAddress,
      boxDecoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: widget.borderRadius,
      ),
      inputDecoration: InputDecoration(
        labelText: widget.labelText,
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
        labelStyle: AppTextStyles.typography3Regular.copyWith(
          color: AppColors.neutral600,
        ),
        contentPadding:
            widget.contentPadding ?? const EdgeInsets.fromLTRB(14, 8, 14, 8),
        enabledBorder: CustomOutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: BorderSide(
            color: AppColors.neutral100,
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
        errorStyle: const TextStyle(
          color: AppColors.colorRed,
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
        suffixIcon: widget.suffixIcon,
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 36,
          minWidth: 40,
        ),
      ),
      validator: (value, context) {
        if (widget.validator != null) {
          final customValidation = widget.validator!(value);
          if (customValidation != null) return customValidation;
        }

        // Skip suggestion validation if the field is pre-filled and untouched
        if (widget.suggestionValidator &&
            !_isSuggestionSelected &&
            widget.textEditingController.text == _initialText) {
          return null; // Pre-filled and untouched, treat as valid
        }

        if (widget.suggestionValidator && !_isSuggestionSelected) {
          return 'Please choose a valid location';
        }

        return null;
      },
      clearData: () {
        widget.textEditingController.clear();
        widget.onClear?.call();
        setState(() {
          _isSuggestionSelected = false;
          _lastSelectedPredictionText = '';
        });
      },
    );
  }
}

class CustomOutlineInputBorder extends InputBorder {
  const CustomOutlineInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

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
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: borderSide.width);

  @override
  CustomOutlineInputBorder scale(double t) {
    return CustomOutlineInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius,
    );
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomOutlineInputBorder &&
          other.borderSide == borderSide &&
          other.borderRadius == borderRadius;

  @override
  int get hashCode => Object.hash(borderSide, borderRadius);
}
