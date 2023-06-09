import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  DownloadService._();
  static final DownloadService _instance = DownloadService._();
  static DownloadService get instance => _instance;
  final Dio _dio = Dio();

  Future<String> downloadImage(String url) async {
    try {
      if (await Permission.manageExternalStorage.request().isGranted &&
          await Permission.storage.request().isGranted) {
        var savePath = await getDownloadPath();
        if (savePath == null) {
          return 'Can not get download folder!';
        }
        print('save path: ${savePath}');
        await _dio.download(url, savePath + '/image1.webp',
            onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = (received / total * 100);
            print('Download progress: ${progress.toStringAsFixed(2)}%');
          }
        });
        return 'File downloaded to: $savePath';
      } else {
        return 'Permission denied!';
      }
    } catch (e) {
      print(e);
      return 'Error: $e';
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }
}
