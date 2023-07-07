import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chatgpt_mac/pages/network/api.dart';
import 'package:flutter_chatgpt_mac/pages/network/url.dart';
import 'package:get/get.dart';
import 'package:luca_flutter_common/luca_loading.dart';

import 'state.dart';

class AudioLogic extends GetxController {
  final AudioState state = AudioState();

  void openDocument() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      File file = File(result.files.single.path ?? "");
      LucaLoading.show(timeout: 60);
      var filename = file.path.split("/").last;
      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(file.path, filename: filename),
        "model": "whisper-1",
      });
      var res = await Api().post(
        ApiURL.audioTranscriptions,
        data: formData,
        headers: {
          "Content-Type": "multipart/form-data",
        },
      );
      if (res.isSuccessful()) {
        LucaLoading.dismiss();
        print(res.data);
      } else {
        LucaLoading.showToast(res.message);
      }
    }
  }
}
