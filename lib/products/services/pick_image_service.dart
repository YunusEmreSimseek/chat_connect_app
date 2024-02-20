import 'package:image_picker/image_picker.dart';

abstract class IPickImageService {
  Future<XFile?> pickImageFromGallery();
}

class PickImageService implements IPickImageService {
  final _picker = ImagePicker();
  @override
  Future<XFile?> pickImageFromGallery() => _picker.pickImage(source: ImageSource.gallery);
}
