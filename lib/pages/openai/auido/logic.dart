import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chatgpt_mac/pages/openai/login/manager.dart';
import 'package:get/get.dart';
import 'package:luca_flutter_common/luca_loading.dart';

import 'state.dart';

class AuidoLogic extends GetxController {
  final AuidoState state = AuidoState();

  void openDocument() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      File file = File(result.files.single.path ?? "");
      print(file.path);

      LucaLoading.show(timeout: 60);
      try {
        var req = dio.Dio();
        (req.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (client) {
          client.findProxy = (url) {
            return UserOpenAiUtils.instance.user?.proxy ?? "";
          };
          client.badCertificateCallback = (cert, host, port) {
            return true;
          };
          return client;
        };
        dio.FormData formData = dio.FormData.fromMap({
          "file":
              await dio.MultipartFile.fromFile(file.path, filename: "demo.mp3"),
          "model": "whisper-1",
        });
        var res = await req.post(
          "https://api.openai.com/v1/audio/transcriptions",
          data: formData,
          options: dio.Options(
            headers: {
              "Authorization":
                  "Bearer ${UserOpenAiUtils.instance.user?.token ?? ""}",
              "Content-Type": "multipart/form-data",
            },
          ),
        );

        req.close();
        if (res.statusCode == 200) {
          LucaLoading.dismiss();
          print(res.data);
        } else {
          LucaLoading.showToast("请求出错");
        }
      } catch (e) {
        print(e);
        LucaLoading.showToast("请求出错");
      }
    }
  }
}
