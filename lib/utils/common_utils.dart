class CommonUtils {
  static String getUsernameFromEmail(String email) {
    return '@${email.toString().split('@')[0]}';
  }

  static bool compareListOrderless<T>(List<T> l1, List<T> l2) {
    var condition1 = l1.toSet().difference(l2.toSet()).isEmpty;
    var condition2 = l1.length == l2.length;
    return condition1 && condition2;
  }
}
