import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxdash/helpers/services/auth_service.dart';
import 'package:maxdash/view/apps/calendar_screen.dart';
import 'package:maxdash/view/apps/chat_screen.dart';
import 'package:maxdash/view/apps/ecommerce/add_product_screen.dart';
import 'package:maxdash/view/apps/ecommerce/product_detail_screen.dart';
import 'package:maxdash/view/apps/ecommerce/product_screen.dart';
import 'package:maxdash/view/apps/ecommerce/customer_screen.dart';
import 'package:maxdash/view/apps/file_manager_screen.dart';
import 'package:maxdash/view/apps/kan_ban_board_screen.dart';
import 'package:maxdash/view/auth/forgot_password_screen.dart';
import 'package:maxdash/view/auth/login_screen.dart';
import 'package:maxdash/view/auth/register_account_screen.dart';
import 'package:maxdash/view/auth/reset_password_screen.dart';
import 'package:maxdash/view/dashboard/analytics_screen.dart';
import 'package:maxdash/view/dashboard/crm_screen.dart';
import 'package:maxdash/view/dashboard/crypto_screen.dart';
import 'package:maxdash/view/dashboard/ecommerce_screen.dart';
import 'package:maxdash/view/dashboard/job_screen.dart';
import 'package:maxdash/view/dashboard/project_screen.dart';
import 'package:maxdash/view/dashboard/sales_screen.dart';
import 'package:maxdash/view/error_pages/coming_soon_screen.dart';
import 'package:maxdash/view/error_pages/error_404_screen.dart';
import 'package:maxdash/view/error_pages/error_500_screen.dart';
import 'package:maxdash/view/extra_pages/faqs_screen.dart';
import 'package:maxdash/view/extra_pages/pricing_screen.dart';
import 'package:maxdash/view/extra_pages/time_line_screen.dart';
import 'package:maxdash/view/forms/basic_input_screen.dart';
import 'package:maxdash/view/forms/custom_option_screen.dart';
import 'package:maxdash/view/forms/editor_screen.dart';
import 'package:maxdash/view/forms/file_upload_screen.dart';
import 'package:maxdash/view/forms/mask_screen.dart';
import 'package:maxdash/view/forms/slider_screen.dart';
import 'package:maxdash/view/forms/validation_screen.dart';
import 'package:maxdash/view/other/basic_table_screen.dart';
import 'package:maxdash/view/other/google_map_screen.dart';
import 'package:maxdash/view/other/map_screen.dart';
import 'package:maxdash/view/other/syncfusion_chart_screen.dart';
import 'package:maxdash/view/ui/buttons_screen.dart';
import 'package:maxdash/view/ui/carousels_screen.dart';
import 'package:maxdash/view/ui/dialogs_screen.dart';
import 'package:maxdash/view/ui/drag_n_drop_screen.dart';
import 'package:maxdash/view/ui/loaders_screen.dart';
import 'package:maxdash/view/ui/modal_screen.dart';
import 'package:maxdash/view/ui/notification_screen.dart';
import 'package:maxdash/view/ui/tabs_screen.dart';
import 'package:maxdash/view/ui/toast_message_screen.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.isLoggedIn ? null : RouteSettings(name: '/auth/login');
  }
}

getPageRoute() {
  var routes = [
    GetPage(
        name: '/',
        page: () => const EcommerceScreen(),
        middlewares: [AuthMiddleware()]),

    // Dashboard
    GetPage(
        name: '/dashboard/ecommerce',
        page: () => const EcommerceScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard/crm',
        page: () => const CrmScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard/job',
        page: () => const JobScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard/project',
        page: () => const ProjectScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard/analytics',
        page: () => const AnalyticsScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard/crypto',
        page: () => const CryptoScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard/sales',
        page: () => const SalesScreen(),
        middlewares: [AuthMiddleware()]),

    // Apps
    GetPage(
        name: '/app/kanban_board',
        page: () => KanBanBoardScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/app/calendar',
        page: () => CalendarScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/app/chat',
        page: () => ChatScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/app/file_manager',
        page: () => FileManagerScreen(),
        middlewares: [AuthMiddleware()]),
    //Ecommerce
    GetPage(
        name: '/app/ecommerce/product',
        page: () => ProductScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/app/ecommerce/add_product',
        page: () => AddProductScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/app/ecommerce/product_detail',
        page: () => ProductDetailScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/app/ecommerce/customer',
        page: () => CustomerScreen(),
        middlewares: [AuthMiddleware()]),

    // Authentication
    GetPage(name: '/auth/login', page: () => LoginScreen()),
    GetPage(
        name: '/auth/register_account',
        page: () => const RegisterAccountScreen()),
    GetPage(
        name: '/auth/forgot_password',
        page: () => const ForgotPasswordScreen()),
    GetPage(
        name: '/auth/reset_password', page: () => const ResetPasswordScreen()),

    // Base UI
    GetPage(
        name: '/widget/toast',
        page: () => ToastMessageScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/widget/buttons',
        page: () => ButtonsScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/widget/modal',
        page: () => ModalScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/widget/tabs',
        page: () => TabsScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/widget/loader',
        page: () => LoadersScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/widget/dialog',
        page: () => DialogsScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/widget/carousel',
        page: () => CarouselsScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/widget/drag_n_drop',
        page: () => DragNDropScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/widget/notification',
        page: () => NotificationScreen(),
        middlewares: [AuthMiddleware()]),

    // Form
    GetPage(
        name: '/form/basic_input',
        page: () => BasicInputScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/form/custom_option',
        page: () => CustomOptionScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/form/editor',
        page: () => EditorScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/form/file_upload',
        page: () => FileUploadScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/form/slider',
        page: () => SliderScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/form/validation',
        page: () => ValidationScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/form/mask',
        page: () => MaskScreen(),
        middlewares: [AuthMiddleware()]),

    // Error
    GetPage(
        name: '/error/coming_soon',
        page: () => ComingSoonScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/error/500',
        page: () => Error500Screen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/error/404',
        page: () => Error404Screen(),
        middlewares: [AuthMiddleware()]),

    // Extra
    GetPage(
        name: '/extra/time_line',
        page: () => TimeLineScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/extra/pricing',
        page: () => PricingScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/extra/faqs',
        page: () => FaqsScreen(),
        middlewares: [AuthMiddleware()]),

    // Other
    GetPage(
        name: '/other/basic_table',
        page: () => BasicTableScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/other/map',
        page: () => MapScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/other/syncfusion_chart',
        page: () => SyncFusionChartScreen(),
        middlewares: [AuthMiddleware()]),
    //GetPage(name: '/other/google_map', page: () => GoogleMapScreen(), middlewares: [AuthMiddleware()]),
  ];
  return routes
      .map((e) => GetPage(
          name: e.name,
          page: e.page,
          middlewares: e.middlewares,
          transition: Transition.noTransition))
      .toList();
}
