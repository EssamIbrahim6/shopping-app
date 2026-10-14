abstract class AppMethods {
  AppMethods._();

  static String timeAgo(String date) {
    final reviewDate = DateTime.parse(date);
    final diff = DateTime.now().difference(reviewDate);

    if (diff.inDays >= 7) {
      return '${diff.inDays ~/ 7} week${diff.inDays ~/ 7 > 1 ? 's' : ''} ago';
    }

    if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    }

    if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    }

    return 'Today';
  }

  static double calculateDiscount(double price, double discountPercentage) {
    return price * (1 - discountPercentage / 100);
  }
}
