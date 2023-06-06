import 'dart:typed_data';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:gcloud/storage.dart';
import 'package:mime/mime.dart';

class CloudService {
  final String _bucketName = 'meme_hub';
  late auth.ServiceAccountCredentials _credentials;
  auth.AutoRefreshingAuthClient? _client;

  CloudService({required json}) {
    _credentials = auth.ServiceAccountCredentials.fromJson(json);
  }

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
    print('https://storage.googleapis.com/${_bucketName}/${newName}');
    return 'https://storage.googleapis.com/${_bucketName}/${newName}';
  }
}
