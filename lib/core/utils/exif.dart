import 'dart:developer';
import 'dart:io';

import 'package:exif/exif.dart';
import 'package:image/image.dart' as img;

Future<File> fixExifRotation(String imagePath) async {
  final originalFile = File(imagePath);
  final imageBytes = await originalFile.readAsBytes();
  // final originalImage = await img.decodeImageFile(imagePath);
  final originalImage = img.decodeImage(imageBytes);

  if (originalImage == null) throw Exception('exif : original null');

  final height = originalImage.height;
  final width = originalImage.width;

  // Let's check for the image size
  if (height >= width) {
    // I'm interested in portrait photos so
    // I'll just return here
    return originalFile;
  }

  // We'll use the exif package to read exif data
  // This is map of several exif properties
  // Let's check 'Image Orientation'
  final exifData = await readExifFromFile(originalFile);
  num angle = 0;
  log('Rotating image necessary');
  // rotate
  if (exifData['Image Orientation']?.printable.contains('Horizontal') == true) {
    angle = 90;
  } else if (exifData['Image Orientation']?.printable.contains('180') == null) {
    angle = -90;
  }
  final fixedImage = img.copyRotate(originalImage, angle: angle);

  // Here you can select whether you'd like to save it as png
  // or jpg with some compression
  // I choose jpg with 100% quality
  return await originalFile.writeAsBytes(img.encodeJpg(fixedImage));
}
