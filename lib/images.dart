import 'dart:math';

class Images {
  static List<String> avatars = List.generate(10, (index) => 'assets/avatar/avatar_${index + 1}.jpg');
  static List<String> dummy = List.generate(5, (index) => 'assets/dummy/dummy_${index + 1}.jpg');
  static List<String> product = List.generate(10, (index) => 'assets/dummy/ecommerce/product_${index + 1}.jpg');

  static String logoLight = 'assets/logo/logo_light.png';
  static String logoLightSmall = 'assets/logo/logo_light_small.png';
  static String logoDark = 'assets/logo/logo_dark.png';
  static String logoDarkSmall = 'assets/logo/logo_dark_small.png';
  static String authBackground = 'assets/auth_background.jpg';

  static String randomImage(List<String> images) {
    return images[Random().nextInt(images.length)];
  }
}
