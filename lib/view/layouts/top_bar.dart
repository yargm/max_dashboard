import 'package:get/get.dart';
import 'package:maxdash/helpers/services/localizations/language.dart';
import 'package:maxdash/helpers/theme/app_notifier.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/theme/theme_customizer.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_dashed_divider.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/images.dart';
import 'package:maxdash/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key, // this.onMenuIconTap,
  });

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin, UIMixin {
  Function? languageHideFn;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      shadow: MyShadow(position: MyShadowPosition.bottomRight, elevation: 0.5),
      height: 60,
      borderRadiusAll: 0,
      padding: MySpacing.x(24),
      color: topBarTheme.background.withAlpha(246),
      child: Row(
        children: [
          Row(
            children: [
              InkWell(
                  splashColor: colorScheme.onSurface,
                  highlightColor: colorScheme.onSurface,
                  onTap: () {
                    ThemeCustomizer.toggleLeftBarCondensed();
                  },
                  child: Icon(
                    Icons.menu,
                    color: topBarTheme.onBackground,
                  )),
              MySpacing.width(24),
              SizedBox(
                width: 200,
                child: TextFormField(
                  maxLines: 1,
                  style: MyTextStyle.bodyMedium(),
                  decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: focusedInputBorder,
                      prefixIcon: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            LucideIcons.search,
                            size: 14,
                          )),
                      prefixIconConstraints: BoxConstraints(minWidth: 36, maxWidth: 36, minHeight: 32, maxHeight: 32),
                      contentPadding: MySpacing.xy(16, 12),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    ThemeCustomizer.setTheme(ThemeCustomizer.instance.theme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
                  },
                  child: Icon(
                    ThemeCustomizer.instance.theme == ThemeMode.dark ? LucideIcons.sun : LucideIcons.moon,
                    size: 18,
                    color: topBarTheme.onBackground,
                  ),
                ),
                MySpacing.width(12),
                CustomPopupMenu(
                  backdrop: true,
                  hideFn: (hide) => languageHideFn = hide,
                  onChange: (_) {},
                  offsetX: -36,
                  menu: Padding(
                    padding: MySpacing.xy(8, 8),
                    child: Center(
                        child: ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.circular(2),
                            child: Image.asset(
                              'assets/lang/${ThemeCustomizer.instance.currentLanguage.locale.languageCode}.jpg',
                              width: 24,
                              height: 18,
                              fit: BoxFit.cover,
                            ))),
                  ),
                  menuBuilder: (_) => buildLanguageSelector(),
                ),
                MySpacing.width(6),
                CustomPopupMenu(
                  backdrop: true,
                  onChange: (_) {},
                  offsetX: -120,
                  menu: Padding(
                    padding: MySpacing.xy(8, 8),
                    child: Center(
                      child: Icon(
                        LucideIcons.bell,
                        size: 18,
                      ),
                    ),
                  ),
                  menuBuilder: (_) => buildNotifications(),
                ),
                MySpacing.width(4),
                CustomPopupMenu(
                  backdrop: true,
                  onChange: (_) {},
                  offsetX: -60,
                  offsetY: 8,
                  menu: Padding(
                    padding: MySpacing.xy(8, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyContainer.rounded(
                            paddingAll: 0,
                            child: Image.asset(
                              Images.avatars[0],
                              height: 28,
                              width: 28,
                              fit: BoxFit.cover,
                            )),
                        MySpacing.width(8),
                        MyText.labelLarge("Den")
                      ],
                    ),
                  ),
                  menuBuilder: (_) => buildAccountMenu(),
                  hideFn: (hide) => languageHideFn = hide,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLanguageSelector() {
    return MyContainer.bordered(
      padding: MySpacing.xy(8, 8),
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Language.languages
            .map((language) => MyButton.text(
                  padding: MySpacing.xy(8, 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashColor: contentTheme.onBackground.withAlpha(20),
                  onPressed: () async {
                    languageHideFn?.call();
                    // Language.changeLanguage(language);
                    await Provider.of<AppNotifier>(context, listen: false).changeLanguage(language, notify: true);
                    ThemeCustomizer.notify();
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.circular(2),
                          child: Image.asset(
                            'assets/lang/${language.locale.languageCode}.jpg',
                            width: 18,
                            height: 14,
                            fit: BoxFit.cover,
                          )),
                      MySpacing.width(8),
                      MyText.labelMedium(language.languageName)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget buildNotifications() {
    Widget buildNotification(String title, String description) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [MyText.labelLarge(title), MySpacing.height(4), MyText.bodySmall(description)],
      );
    }

    return MyContainer.bordered(
      paddingAll: 0,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(16, 12),
            child: MyText.titleMedium("Notification", fontWeight: 600),
          ),
          MyDashedDivider(height: 1, color: theme.dividerColor, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: MySpacing.xy(16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNotification("Your order is dispatched", "Order #5678 is on its way"),
                MySpacing.height(12),
                buildNotification("Account Security Alert", "New device logged into your account."),
                MySpacing.height(12),
                buildNotification("Event Reminder", "Your event 'Flutter Workshop' is tomorrow at 10:00 AM."),
                MySpacing.height(12),
                buildNotification("Payment Successful", "Your payment of \$45 has been successfully processed."),
              ],
            ),
          ),
          MyDashedDivider(height: 1, color: theme.dividerColor, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: MySpacing.xy(16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton.text(
                  onPressed: () {},
                  splashColor: contentTheme.primary.withAlpha(28),
                  child: MyText.labelSmall(
                    "View All",
                    color: contentTheme.primary,
                  ),
                ),
                MyButton.text(
                  onPressed: () {},
                  splashColor: contentTheme.danger.withAlpha(28),
                  child: MyText.labelSmall(
                    "Clear",
                    color: contentTheme.danger,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAccountMenu() {
    return MyContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyButton(
                  onPressed: () => {},
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.user,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "My Account",
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
                MySpacing.height(4),
                MyButton(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () => {},
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.settings,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "Settings",
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
                MySpacing.height(4),
                MyButton(
                  onPressed: () => {},
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.bell,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "Notifications",
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
                MySpacing.height(4),
                MyButton(
                  onPressed: () => {},
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.message_circle,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "Messages",
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
                MySpacing.height(4),
                MyButton(
                  onPressed: () => {},
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.circle_help,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "Help & Support",
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                languageHideFn?.call();
                Get.offNamed('/auth/login');
              },
              borderRadiusAll: AppStyle.buttonRadius.medium,
              padding: MySpacing.xy(8, 4),
              splashColor: contentTheme.danger.withAlpha(28),
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    LucideIcons.log_out,
                    size: 14,
                    color: contentTheme.danger,
                  ),
                  MySpacing.width(8),
                  MyText.labelMedium(
                    "Log out",
                    fontWeight: 600,
                    color: contentTheme.danger,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
