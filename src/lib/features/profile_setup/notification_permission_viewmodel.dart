import 'package:stacked/stacked.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionViewModel extends BaseViewModel {
  Future<void> requestNotificationPermission() async {
    setBusy(true);
    final status = await Permission.notification.request();
    if (status.isGranted) {
      // Handle the case where permission is granted
    } else if (status.isDenied) {
      // Handle the case where permission is denied
    } else if (status.isPermanentlyDenied) {
      // Handle the case where permission is permanently denied
    }
    setBusy(false);
  }

  Future<bool> checkNotificationPermissionStatus() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }
}
