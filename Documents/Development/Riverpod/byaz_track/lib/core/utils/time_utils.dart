import 'package:intl/intl.dart';

class TimeUtils {
  // Convert DateTime to UTC
  static DateTime toUtc(DateTime dateTime) {
    return dateTime.isUtc ? dateTime : dateTime.toUtc();
  }

  // Convert UTC DateTime to local time
  static DateTime toLocal(DateTime dateTime) {
    return dateTime.isUtc ? dateTime.toLocal() : dateTime;
  }

  // Format time for chat messages (shows time only)
  static String formatChatTime(DateTime dateTime) {
    final localTime = dateTime.isUtc ? dateTime.toLocal() : dateTime;
    return DateFormat('h:mm a').format(localTime);
  }

  // Format date for chat list (shows relative time)
  static String formatChatDate(DateTime dateTime) {
    final localTime = dateTime.isUtc ? dateTime.toLocal() : dateTime;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(
      localTime.year,
      localTime.month,
      localTime.day,
    );

    if (messageDate == today) {
      return 'Today, ${DateFormat('h:mm a').format(localTime)}';
    } else if (messageDate == yesterday) {
      return 'Yesterday, ${DateFormat('h:mm a').format(localTime)}';
    } else if (now.difference(localTime).inDays < 7) {
      return DateFormat('EEEE, h:mm a').format(localTime);
    } else {
      return DateFormat('MMM d, yyyy h:mm a').format(localTime);
    }
  }
}
