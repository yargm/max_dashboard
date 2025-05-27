import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/apps/calendar_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sf_calendar;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with UIMixin {
  final CalendarController _controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: _controller,
        tag: 'calendar_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Calendar",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Calendar'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard.bordered(
                  borderRadiusAll: 4,
                  border: Border.all(color: Colors.grey.withValues(alpha:.2)),
                  shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
                  paddingAll: 24,
                  height: 700,
                  child: sf_calendar.SfCalendar(
                    view: sf_calendar.CalendarView.week,
                    allowedViews: _controller.allowedViews,
                    dataSource: _controller.events,
                    allowDragAndDrop: true,
                    allowAppointmentResize: true,
                    onDragEnd: _controller.dragEnd,
                    monthViewSettings:
                        sf_calendar.MonthViewSettings(showAgenda: true, appointmentDisplayMode: sf_calendar.MonthAppointmentDisplayMode.appointment),
                    controller: sf_calendar.CalendarController(),
                    allowViewNavigation: true,
                    showTodayButton: true,
                    showCurrentTimeIndicator: true,
                    showNavigationArrow: true,
                    onSelectionChanged: (calendarSelectionDetails) {
                      _controller.onSelectDate(calendarSelectionDetails);
                      addDataModal(context);
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> addDataModal(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title(),
              MySpacing.height(24),
              location(),
              MySpacing.height(24),
              description(),
              MySpacing.height(24),
              colorSelect(),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _controller.addEvent();
              },
            ),
          ],
        );
      },
    );
  }

  Widget colorSelect() {
    List<DropdownMenuItem<Color>> itemColor = [];
    for (Color color in _controller.colorCollection) {
      itemColor.add(DropdownMenuItem(
          value: color,
          child: Row(
            children: [
              MyContainer(color: color, height: 20, width: 50, clipBehavior: Clip.antiAliasWithSaveLayer),
              MySpacing.width(12),
              MyText.bodyMedium(colorToString(color), fontWeight: 600),
            ],
          )));
    }

    return DropdownButtonFormField<Color>(
        dropdownColor: contentTheme.background,
        value: _controller.selectedColor,
        items: itemColor,
        onChanged: (Color? value) => _controller.onSelectedColor(value),
        decoration: InputDecoration(
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          filled: true,
          contentPadding: MySpacing.all(12),
          hintText: "Select Color",
          hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
        ));
  }

  String colorToString(Color color) {
    if (color == Colors.red) return 'Red';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.green) return 'Green';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.pink) return 'Pink';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.brown) return 'Brown';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.teal) return 'Teal';
    if (color == Colors.indigo) return 'Indigo';
    return '';
  }

  Widget description() {
    return TextFormField(
      controller: _controller.descriptionTE,
      decoration: InputDecoration(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        hintText: "Add Description",
        hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
      ),
    );
  }

  Widget location() {
    return TextFormField(
      controller: _controller.locationTE,
      decoration: InputDecoration(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        hintText: "Add Location",
        hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
      ),
    );
  }

  Widget title() {
    return TextFormField(
      controller: _controller.titleTE,
      decoration: InputDecoration(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        hintText: "Add Title",
        hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
      ),
    );
  }
}
