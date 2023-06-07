import 'dart:io';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:gcloud/storage.dart';
import 'package:mime/mime.dart';

class CloudService {
  static final CloudService _instance = CloudService._();
  static const String _keyPath = 'assets/keys/credentials.json';
  static CloudService get instance => _instance;

  CloudService._() {
    rootBundle.loadString(_keyPath).then((json) {
      _credentials = auth.ServiceAccountCredentials.fromJson(json);
    });
  }
  final String _bucketName = 'meme_hub';
  late auth.ServiceAccountCredentials _credentials;
  auth.AutoRefreshingAuthClient? _client;

  Future<String> save(String name, Uint8List imgBytes) async {
    // Create a client
    _client ??=
        await auth.clientViaServiceAccount(_credentials, Storage.SCOPES);

    // Instantiate objects to cloud storage
    var storage = Storage(_client!, 'Test project');
    var bucket = storage.bucket(_bucketName);

    // Save to bucket
    final now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch;
    final type = lookupMimeType(name);
    final newName = '${timestamp}_${name}';
    final ObjectInfo objectInfo = await bucket.writeBytes(newName, imgBytes,
        metadata: ObjectMetadata(
          contentType: type,
          custom: {
            'timestamp': '$timestamp',
          },
        ));
    // String downloadLink = objectInfo.downloadLink.toString();
    return 'https://storage.googleapis.com/${_bucketName}/${newName}';
  }

  Future<String> uploadImage(File image) async {
    Uint8List imageBytes = image.readAsBytesSync();
    String imageName = image.path.split('/').last;
    return await CloudService.instance.save(imageName, imageBytes);
  }
}
