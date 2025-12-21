import 'package:byaz_track/core/extension/extensions.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    // required this.theme,
    required this.ontap,
    required this.leadingtitle,
  });

  // final ThemeData theme;
  final Function() ontap;
  final String leadingtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: Text(
              leadingtitle,
              // textAlign: TextAlign.end,
              style: context.text.labelMedium!.copyWith(
                fontSize: 18,
                color: AppColors.boldTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),

            // autofocus: false,
            onPressed: ontap,
            child: Text(
              "View All",

              textAlign: TextAlign.end,
              style: context.text.titleMedium!.copyWith(
                color: AppColors.hintGrey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            // label: const Icon(Icons.east_rounded),
          ),
        ],
      ),
    );
  }
}
