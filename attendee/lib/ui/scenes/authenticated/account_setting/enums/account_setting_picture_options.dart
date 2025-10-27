import "package:attendee/utils/constants/app_string_constants.dart";

enum AccountSettingPictureOptions {
  takePhoto,
  chooseFromLibrary,
  delete,
  cancel;

  String get label => switch (this) {
    AccountSettingPictureOptions.takePhoto =>
      AppStringConstants.account.takePhotoLabel,

    AccountSettingPictureOptions.chooseFromLibrary =>
      AppStringConstants.account.photoLibraryLabel,

    AccountSettingPictureOptions.delete =>
      AppStringConstants.account.deteleLabel,

    AccountSettingPictureOptions.cancel =>
      AppStringConstants.account.cancelLabel,
  };
}
