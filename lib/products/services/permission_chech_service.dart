import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionCheckService {
  Future<bool> checkPhotoStatus();
}

class PermissionCheckService implements IPermissionCheckService {
  @override
  Future<bool> checkPhotoStatus() async {
    final status = await Permission.photos.status;
    return status.isGranted;
  }
}
