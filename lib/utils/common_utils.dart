class CommonUtils {
  static String getUsernameFromEmail(String email) {
    return '@${email.toString().split('@')[0]}';
  }
}
