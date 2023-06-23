import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var scrollController = ScrollController().obs;
  var shouldShowScrollToTop = false.obs;

  /// Get
  getScrollController() => scrollController.value;
  getShouldScrollToTop() => shouldShowScrollToTop.value;

  /// Set
  setShouldScrollToTop(value) => shouldShowScrollToTop(value);

  /// Methods
  scrollToOffset(offset) => scrollController.value.animateTo(offset, duration: Duration(milliseconds: 500), curve: Curves.easeInBack);
}