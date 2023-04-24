import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class OtherState {
  var items = [].obs;
  ScrollController scrollController = ScrollController();
  int temp = 0;
  ListObserverController? observerController;
}
