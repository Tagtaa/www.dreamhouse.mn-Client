import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

import '../base_service.dart';

const String _kRoot = 'files';

final class FileService extends BaseService<FileService> {
  Future<String> _getPath(String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_kRoot/$fileName';
  }

  Future<String> _getTempPath() async {
    final Directory directory = await getTemporaryDirectory();
    return '${directory.path}/$_kRoot/${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<String> getSha1Of(File file) async {
    final Uint8List bytes = await file.readAsBytes();
    return sha1.convert(bytes).toString();
  }

  Future<File> getFile(String fileName) async {
    final String path = await _getPath(fileName);
    return File(path);
  }

  Future<File> createTempFile() async {
    final String tempPath = await _getTempPath();
    return await File(tempPath).create(recursive: true);
  }

  Future<void> saveTempFile(File tempFile, String saveFileName) async {
    final String savePath = await _getPath(saveFileName);
    await File(savePath).create(recursive: true);

    await tempFile.copy(savePath);
    await tempFile.delete(recursive: true);
  }

  Future<void> deleteAllFiles() async {
    Future<void> delete(Directory directory) async {
      final Directory fileDirectory = Directory('${directory.path}/$_kRoot');
      if (await fileDirectory.exists()) {
        await fileDirectory.delete(recursive: true);
      }
    }

    await delete(await getApplicationDocumentsDirectory());
    await delete(await getTemporaryDirectory());
  }
}
