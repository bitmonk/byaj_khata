import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Simple Pagination Controller
class SimplePaginationController extends GetxController {
  RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isInitialLoading = false.obs;
  RxBool hasMoreData = true.obs;

  void resetPagination() {
    currentPage.value = 1;
    lastPage.value = 1;
    isLoadingMore.value = false;
    isInitialLoading.value = false;
    hasMoreData.value = true;
  }

  void updatePageInfo(int current, int last) {
    currentPage.value = current;
    lastPage.value = last;
    hasMoreData.value = current < last;
  }

  bool canLoadMore() {
    return hasMoreData.value && !isLoadingMore.value && !isInitialLoading.value;
  }
}

// Pagination Mixin
mixin PaginationMixin<T extends StatefulWidget> on State<T> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  // @override
  // void dispose() {
  //   scrollController.removeListener(_scrollListener);
  //   scrollController.dispose();
  //   super.dispose();
  // }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      // Trigger load more when user is 200px from bottom
      onLoadMore();
    }
  }

  // Override this method in your widget
  void onLoadMore();
}

// Simple Paginated ListView Widget
class SimplePaginatedListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final VoidCallback? onLoadMore;
  final bool isLoading;
  final bool hasMoreData;
  final ScrollController? scrollController;
  final EdgeInsetsGeometry? padding;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final String? emptyMessage;

  const SimplePaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onLoadMore,
    this.scrollController,
    this.isLoading = false,
    this.hasMoreData = true,
    this.padding,
    this.loadingWidget,
    this.emptyWidget,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && !isLoading) {
      return emptyWidget ??
          Center(child: Text(emptyMessage ?? 'No items found'));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 200 &&
            hasMoreData &&
            !isLoading &&
            onLoadMore != null) {
          onLoadMore!();
        }
        return false;
      },
      child: ListView.builder(
        controller: scrollController,
        padding: padding,
        itemCount: items.length + (hasMoreData && isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < items.length) {
            return itemBuilder(context, items[index], index);
          } else {
            // Loading indicator at the end
            return loadingWidget ??
                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
          }
        },
      ),
    );
  }
}
