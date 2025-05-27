// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// //import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:maxdash/controller/other/google_map_screen_controller.dart';
// import 'package:maxdash/helpers/theme/app_theme.dart';
// import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
// import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
// import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
// import 'package:maxdash/helpers/widgets/my_container.dart';
// import 'package:maxdash/helpers/widgets/my_spacing.dart';
// import 'package:maxdash/helpers/widgets/my_text.dart';
// import 'package:maxdash/view/layouts/layout.dart';

// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({super.key});

//   @override
//   State<GoogleMapScreen> createState() => _GoogleMapScreenState();
// }

// class _GoogleMapScreenState extends State<GoogleMapScreen> with UIMixin {
//   zGoogleMapScreenController controller = Get.put(GoogleMapScreenController());

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//         child: GetBuilder(
//             init: controller,
//             builder: (controller) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Padding(
//                     padding: MySpacing.x(flexSpacing),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         MyText.titleMedium(
//                           "Google Map",
//                           fontSize: 18,
//                           fontWeight: 600,
//                         ),
//                         MyBreadcrumb(
//                           children: [
//                             MyBreadcrumbItem(name: 'Maps'),
//                             MyBreadcrumbItem(name: 'Google Map', active: true),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   MySpacing.height(flexSpacing),
//                   // Padding(
//                   //     padding: MySpacing.x(flexSpacing),
//                   //     child: MyContainer.none(
//                   //       clipBehavior: Clip.antiAliasWithSaveLayer,
//                   //       height: 600,
//                   //       child: GoogleMap(
//                   //         onMapCreated: controller.onMapCreated,
//                   //         initialCameraPosition: CameraPosition(target: controller.center, zoom: 11.0),
//                   //       ),
//                   //     )),
//                 ],
//               );
//             }));
//   }
// }
