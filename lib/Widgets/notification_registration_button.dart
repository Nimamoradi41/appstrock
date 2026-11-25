import 'package:flutter/material.dart';

import '../Screens/Teriazh/notification_registration.dart';

class NotificationRegistrationButton extends StatefulWidget {
  const NotificationRegistrationButton(
      {super.key,
      this.color = Colors.white,
      this.size = 30,
      this.icon = Icons.notifications_active,
      this.onRegistered});

  final Color color;
  final double size;
  final IconData icon;
  final VoidCallback? onRegistered;

  @override
  State<NotificationRegistrationButton> createState() =>
      _NotificationRegistrationButtonState();
}

class _NotificationRegistrationButtonState
    extends State<NotificationRegistrationButton> {
  bool _registering = false;

  @override
  void initState() {
    super.initState();
    syncNotificationTokenIfAllowed().catchError((Object error) {
      debugPrint('Notification token synchronization failed: $error');
    });
  }

  Future<void> _enableNotifications() async {
    if (_registering) return;
    setState(() => _registering = true);
    try {
      await registerNotificationToken();
      if (!mounted) return;
      widget.onRegistered?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اعلان‌ها با موفقیت فعال شدند')),
      );
    } catch (error) {
      if (!mounted) return;
      final message = error is StateError
          ? error.message.toString()
          : 'فعال‌سازی اعلان‌ها ناموفق بود؛ دوباره تلاش کنید';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _registering = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'فعال‌سازی اعلان‌ها',
      onPressed: _registering ? null : _enableNotifications,
      icon: _registering
          ? SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                  color: widget.color, strokeWidth: 2),
            )
          : Icon(widget.icon, color: widget.color, size: widget.size),
    );
  }
}
