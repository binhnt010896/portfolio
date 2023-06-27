import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scroll_to_id/scroll_to_id.dart';

class HomeController extends GetxController {
  var scrollController = ScrollController().obs;
  var scrollToId = ScrollToId().obs;
  var shouldShowScrollToTop = false.obs;

  /// init
  @override
  onInit() {
    scrollToId = ScrollToId(scrollController: scrollController.value).obs;
    super.onInit();
  }

  /// Get
  getScrollController() => scrollController.value;
  getShouldScrollToTop() => shouldShowScrollToTop.value;

  /// Set
  setShouldScrollToTop(value) => shouldShowScrollToTop(value);

  /// Methods
  scrollToOffset(offset) => scrollController.value.animateTo(offset,
      duration: Duration(milliseconds: 500), curve: Curves.easeInBack);

  scrollToSection(id) => scrollToId.value.animateTo(id,
      duration: Duration(milliseconds: 500), curve: Curves.easeInBack);
}
