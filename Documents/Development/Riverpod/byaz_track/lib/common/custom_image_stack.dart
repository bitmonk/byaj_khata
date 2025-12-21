import 'package:flutter/material.dart';

class CustomImageStack extends StatelessWidget {
  final List<String?>? imageUrls; // Nullable list with nullable strings
  final String? memberCount; // To determine number of default icons
  final double itemRadius;
  final double itemBorderWidth;
  final Color itemBorderColor;
  final int maxDisplayedImages;

  const CustomImageStack({
    super.key,
    required this.imageUrls,
    this.memberCount,
    this.itemRadius = 26,
    this.itemBorderWidth = 2,
    this.itemBorderColor = Colors.white,
    this.maxDisplayedImages = 3,
  });

  @override
  Widget build(BuildContext context) {
    final int memberCountInt = int.tryParse(memberCount ?? '0') ?? 0;
    final bool isEmptyOrNull = imageUrls == null || imageUrls!.isEmpty;

    // Determine display count: prioritize memberCount if imageUrls is empty/null
    final int displayCount;
    if (isEmptyOrNull) {
      // If no images, show default icons based on memberCount
      displayCount =
          memberCountInt > maxDisplayedImages
              ? maxDisplayedImages
              : memberCountInt > 0
              ? memberCountInt
              : 0;
    } else {
      // Count valid (non-null, non-empty) URLs
      final validImageCount =
          imageUrls!.where((url) => url != null && url.isNotEmpty).length;
      // Use memberCount if it's greater and we need to pad with default icons
      final targetCount =
          memberCountInt > validImageCount ? memberCountInt : validImageCount;
      displayCount =
          targetCount > maxDisplayedImages ? maxDisplayedImages : targetCount;
    }

    if (displayCount == 0) {
      return const SizedBox.shrink(); // Return empty widget if no images or members
    }

    // Determine width based on displayCount
    final double stackWidth;
    if (displayCount == 1) {
      stackWidth = 40;
    } else if (displayCount == 2) {
      stackWidth = 65;
    } else {
      stackWidth = 90;
    }

    return SizedBox(
      height: itemRadius * 2,
      width: stackWidth,
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < displayCount; i++)
            Positioned(
              left: (displayCount - i - 1) * (itemRadius * 1.3),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: itemBorderColor,
                    width: itemBorderWidth,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(itemRadius),
                  child:
                      (!isEmptyOrNull &&
                              i < imageUrls!.length &&
                              imageUrls![i] != null &&
                              imageUrls![i]!.isNotEmpty)
                          ? Image.network(
                            imageUrls![i]!,
                            width: itemRadius * 1.8,
                            height: itemRadius * 1.8,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: itemRadius * 1.8,
                                height: itemRadius * 1.8,
                                color: Colors.grey.shade300,
                                child: Icon(
                                  Icons.person,
                                  size: itemRadius,
                                  color: Colors.grey.shade600,
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: itemRadius * 1.8,
                                height: itemRadius * 1.8,
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                          )
                          : Container(
                            width: itemRadius * 1.8,
                            height: itemRadius * 1.8,
                            color: Colors.grey.shade300,
                            child: Icon(
                              Icons.person,
                              size: itemRadius,
                              color: Colors.grey.shade600,
                            ),
                          ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
