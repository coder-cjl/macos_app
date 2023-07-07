import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../routers/router.dart';
import 'state.dart';

class OtherLogic extends GetxController {
  final OtherState state = OtherState();

  @override
  void onInit() {
    state.observerController =
        ListObserverController(controller: state.scrollController);

    super.onInit();
  }

  void sendText() async {
    // state.temp += 1;
    // var item = TextModel(sendType: SendType.me, content: "${state.temp}");
    // state.items.value.add(item);
    // state.items.refresh();
    //
    // // state.scrollController.animateTo(
    // //   state.scrollController.position.maxScrollExtent + 10,
    // //   duration: const Duration(milliseconds: 300),
    // //   curve: Curves.easeOut,
    // // );
    //
    // state.observerController?.jumpTo(index: state.items.length - 1);

    testFile();
  }

  void testFile() async {
    AppPage.to(Routes.setting);
    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles(allowMultiple: true);
    // if (result != null) {
    //   var files = result.files.map((e) => File(e.path ?? "")).toList();
    //   print(files);
    //   // File file = File(result.files.single.path ?? "");
    //   // print(file.path);
    // }
  }
}
