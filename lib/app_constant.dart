import 'package:intl/intl.dart' show DateFormat;

final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
final DateFormat timeFormatter = DateFormat('jms');

class AppConstant {
  static int androidAppVersion = 1;
  static int iOSAppVersion = 1;
  static String version = "1.0.0";

  static String get appName => 'MaxDash';
}
