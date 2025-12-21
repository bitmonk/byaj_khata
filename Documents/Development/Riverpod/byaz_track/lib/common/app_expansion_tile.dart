import 'package:byaz_track/core/extension/extensions.dart';

class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile({
    required this.title,
    required this.description,
    required this.titleNumber,
    this.isFirst = false,
    this.isLast = false,
    super.key,
  });
  final String titleNumber;
  final String title;
  final String description;
  final bool isFirst;
  final bool isLast;

  @override
  State<AppExpansionTile> createState() => _AppExpansionTileState();
}

class _AppExpansionTileState extends State<AppExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    BorderRadius getBorderRadius(bool isCollapsed) {
      if (widget.isFirst && widget.isLast) {
        return BorderRadius.circular(16);
      } else if (widget.isFirst) {
        return BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );
      } else if (widget.isLast) {
        return BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        );
      } else {
        return BorderRadius.zero;
      }
    }

    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      initiallyExpanded: isExpanded,
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      iconColor: AppColors.neutral900,
      collapsedIconColor: AppColors.neutral900,
      shape: RoundedRectangleBorder(borderRadius: getBorderRadius(false)),
      backgroundColor: AppColors.foundationPrimary50,
      showTrailingIcon: false,
      collapsedBackgroundColor: AppColors.baseWhite,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: getBorderRadius(true),
      ),
      minTileHeight: 125,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleNumber,
            style: context.text.titleLarge!.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppColors.foundationBlue500,
            ),
          ),
          VerticalSpacing(8),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: context.text.titleLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.neutral900,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              const HorizontalSpacing(8),
              if (isExpanded)
                const Icon(Icons.remove)
              else
                const Icon(Icons.add),
            ],
          ),
        ],
      ),
      onExpansionChanged: (value) {
        isExpanded = value;
        setState(() {});
      },
      children: [
        Text(
          widget.description,
          style: context.text.titleMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.color5A5365,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
