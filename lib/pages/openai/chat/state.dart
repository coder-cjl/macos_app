import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class ChatState {
  TextEditingController input = TextEditingController();
  var items = [].obs;
  ScrollController scrollController = ScrollController();
  ListObserverController? observerController;
}
