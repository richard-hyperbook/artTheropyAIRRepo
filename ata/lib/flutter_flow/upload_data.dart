import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
//import 'package:video_player/video_player.dart';

// import '../auth/firebase_auth/auth_util.dart';
import 'flutter_flow_util.dart';

const Set<String> allowedFormats = <String>{'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};

class SelectedFile {
  const SelectedFile({
    this.storagePath = '',
    this.filePath,
    required this.bytes,
    this.dimensions,
    this.blurHash,
  });
  final String storagePath;
  final String? filePath;
  final Uint8List bytes;
  final MediaDimensions? dimensions;
  final String? blurHash;
}

class MediaDimensions {
  const MediaDimensions({
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
}

enum MediaSource {
  photoGallery,
  videoGallery,
  camera,
}

Future<List<SelectedFile>?> selectMediaWithSourceBottomSheet({
  required BuildContext context,
  String? storageFolderPath,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  required bool allowPhoto,
  bool allowVideo = false,
  String pickerFontFamily = 'Roboto',
  Color textColor = const Color(0xFF111417),
  Color backgroundColor = const Color(0xFFF5F5F5),
  bool includeDimensions = false,
  bool includeBlurHash = false,
}) async {
  /*ListTile Function(String label, MediaSource mediaSource)*/ createUploadMediaListTile(String label, MediaSource mediaSource) => ListTile(
            title: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                pickerFontFamily,
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            tileColor: backgroundColor,
            dense: false,
            onTap: () => Navigator.pop(
              context,
              mediaSource,
            ),
          );
  final MediaSource? mediaSource = await showModalBottomSheet<MediaSource>(
      context: context,
      backgroundColor: backgroundColor,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!kIsWeb) ...<Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: ListTile(
                  title: Text(
                    'Choose Source',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      pickerFontFamily,
                      color: textColor.withOpacity(0.65),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  tileColor: backgroundColor,
                  dense: false,
                ),
              ),
              const Divider(),
            ],
            if (allowPhoto && allowVideo) ...<Widget>[
              createUploadMediaListTile(
                'Gallery (Photo)',
                MediaSource.photoGallery,
              ),
              const Divider(),
              createUploadMediaListTile(
                'Gallery (Video)',
                MediaSource.videoGallery,
              ),
            ] else if (allowPhoto)
              createUploadMediaListTile(
                'Gallery',
                MediaSource.photoGallery,
              )
            else
              createUploadMediaListTile(
                'Gallery',
                MediaSource.videoGallery,
              ),
            if (!kIsWeb) ...<Widget>[
              const Divider(),
              createUploadMediaListTile('Camera', MediaSource.camera),
              const Divider(),
            ],
            const SizedBox(height: 10),
          ],
        );
      });
  if (mediaSource == null) {
    return null;
  }
  return selectMedia(
    storageFolderPath: storageFolderPath,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
    isVideo: mediaSource == MediaSource.videoGallery ||
        (mediaSource == MediaSource.camera && allowVideo && !allowPhoto),
    mediaSource: mediaSource,
    includeDimensions: includeDimensions,
    includeBlurHash: includeBlurHash,
  );
}

Future<List<SelectedFile>?> selectMedia({
  String? storageFolderPath,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  bool isVideo = false,
  MediaSource mediaSource = MediaSource.camera,
  bool multiImage = false,
  bool includeDimensions = false,
  bool includeBlurHash = false,
}) async {
  final ImagePicker picker = ImagePicker();

  if (multiImage) {
    final Future<List<XFile>> pickedMediaFuture = picker.pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    final List<XFile> pickedMedia = await pickedMediaFuture;
    if (pickedMedia.isEmpty) {
      return null;
    }
    return Future.wait(pickedMedia.asMap().entries.map((MapEntry<int, XFile> e) async {
      final int index = e.key;
      final XFile media = e.value;
      final Uint8List mediaBytes = await media.readAsBytes();
      final String path = _getStoragePath(storageFolderPath, media.name, false, index);
      final Future<MediaDimensions>? dimensions = includeDimensions
          ? /*isVideo*/
              /*? _getVideoDimensions(media.path)
              :*/ _getImageDimensions(mediaBytes)
          : null;

      return SelectedFile(
        storagePath: path,
        filePath: media.path,
        bytes: mediaBytes,
        dimensions: await dimensions,
      );
    }));
  }

  final ImageSource source = mediaSource == MediaSource.camera
      ? ImageSource.camera
      : ImageSource.gallery;
  final Future<XFile?> pickedMediaFuture = /*isVideo
      ? picker.pickVideo(source: source)
      :*/ picker.pickImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: imageQuality,
          source: source,
        );
  final XFile? pickedMedia = await pickedMediaFuture;
  final Uint8List? mediaBytes = await pickedMedia?.readAsBytes();
  if (mediaBytes == null) {
    return null;
  }
  final String path = _getStoragePath(storageFolderPath, pickedMedia!.name, isVideo);
  final Future<MediaDimensions>? dimensions = includeDimensions
      ? /*isVideo
          ? _getVideoDimensions(pickedMedia.path)
          :*/ _getImageDimensions(mediaBytes)
      : null;

  return <SelectedFile>[
    SelectedFile(
      storagePath: path,
      filePath: pickedMedia.path,
      bytes: mediaBytes,
      dimensions: await dimensions,
    ),
  ];
}

bool validateFileFormat(String filePath, BuildContext context) {
  if (allowedFormats.contains(mime(filePath))) {
    return true;
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('Invalid file format: ${mime(filePath)}'),
    ));
  return false;
}

Future<SelectedFile?> selectFile({
  String? storageFolderPath,
  List<String>? allowedExtensions,
}) =>
    selectFiles(
      storageFolderPath: storageFolderPath,
      allowedExtensions: allowedExtensions,
    ).then((List<SelectedFile>? value) => value?.first);

Future<List<SelectedFile>?> selectFiles({
  String? storageFolderPath,
  List<String>? allowedExtensions,
  bool multiFile = false,
}) async {
  final FilePickerResult? pickedFiles = await FilePicker.platform.pickFiles(
    type: allowedExtensions != null ? FileType.custom : FileType.any,
    allowedExtensions: allowedExtensions,
    withData: true,
    allowMultiple: multiFile,
  );
  if (pickedFiles == null || pickedFiles.files.isEmpty) {
    return null;
  }
  if (multiFile) {
    return Future.wait(pickedFiles.files.asMap().entries.map((MapEntry<int, PlatformFile> e) async {
      final int index = e.key;
      final PlatformFile file = e.value;
      final String storagePath =
          _getStoragePath(storageFolderPath, file.name, false, index);
      return SelectedFile(
        storagePath: storagePath,
        filePath: isWeb ? null : file.path,
        bytes: file.bytes!,
      );
    }));
  }
  final PlatformFile file = pickedFiles.files.first;
  if (file.bytes == null) {
    return null;
  }
  final String storagePath = _getStoragePath(storageFolderPath, file.name, false);
  return <SelectedFile>[
    SelectedFile(
      storagePath: storagePath,
      filePath: isWeb ? null : file.path,
      bytes: file.bytes!,
    )
  ];
}

List<SelectedFile> selectedFilesFromUploadedFiles(
  List<FFUploadedFile> uploadedFiles, {
  String? storageFolderPath,
  bool isMultiData = false,
}) =>
    uploadedFiles.asMap().entries.map(
      (MapEntry<int, FFUploadedFile> entry) {
        final int index = entry.key;
        final FFUploadedFile file = entry.value;
        return SelectedFile(
            storagePath: _getStoragePath(
              storageFolderPath,
              file.name!,
              false,
              isMultiData ? index : null,
            ),
            bytes: file.bytes!);
      },
    ).toList();

Future<MediaDimensions> _getImageDimensions(Uint8List mediaBytes) async {
  final /*Image*/ image = await decodeImageFromList(mediaBytes);
  return MediaDimensions(
    width: image.width.toDouble(),
    height: image.height.toDouble(),
  );
}
/*

Future<MediaDimensions> _getVideoDimensions(String path) async {
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset(path);
  await videoPlayerController.initialize();
  final Size size = videoPlayerController.value.size;
  return MediaDimensions(width: size.width, height: size.height);
}
*/

String _getStoragePath(
  String? pathPrefix,
  String filePath,
  bool isVideo, [
  int? index,
]) {
  pathPrefix ??= _firebasePathPrefix();
  pathPrefix = _removeTrailingSlash(pathPrefix);
  final int timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final String ext = /*isVideo ? 'mp4' :*/ filePath.split('.').last;
  final String indexStr = index != null ? '_$index' : '';
  return '$pathPrefix/$timestamp$indexStr.$ext';
}

String getSignatureStoragePath([String? pathPrefix]) {
  pathPrefix ??= _firebasePathPrefix();
  pathPrefix = _removeTrailingSlash(pathPrefix);
  final int timestamp = DateTime.now().microsecondsSinceEpoch;
  return '$pathPrefix/signature_$timestamp.png';
}

void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            if (showLoading)
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}

String? _removeTrailingSlash(String? path) => path != null && path.endsWith('/')
    ? path.substring(0, path.length - 1)
    : path;

String _firebasePathPrefix() => 'users/' + /*£currentUserUid +*/ '/uploads';
