import 'package:flutter/services.dart';

abstract class CopyStringToClipboardUsecase {
  Future<bool> execute({required String dataToCopy});
}

final class CopyStringToClipboardUsecaseImplementation
    implements CopyStringToClipboardUsecase {
  @override
  Future<bool> execute({required String dataToCopy}) async {
    try {
      await Clipboard.setData(ClipboardData(text: dataToCopy));
      return true;
    } catch (error) {
      return false;
    }
  }
}
