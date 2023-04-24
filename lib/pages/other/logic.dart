import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../openai/chat/model.dart';
import 'state.dart';

class OtherLogic extends GetxController {
  final OtherState state = OtherState();

  @override
  void onInit() {
    state.observerController =
        ListObserverController(controller: state.scrollController);

    super.onInit();
  }

  void sendText() {
    state.temp += 1;
    var item = TextModel(sendType: SendType.me, content: "${state.temp}");
    state.items.value.add(item);
    state.items.refresh();

    // state.scrollController.animateTo(
    //   state.scrollController.position.maxScrollExtent + 10,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );

    state.observerController?.jumpTo(index: state.items.length - 1);
  }
}
