import 'package:flutter/material.dart';
import 'package:maxdash/controller/my_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarController extends MyController {
  late DataSource events;
  final List<CalendarView> allowedViews = <CalendarView>[CalendarView.day, CalendarView.week, CalendarView.workWeek, CalendarView.month, CalendarView.schedule];
  List<Appointment> appointmentCollection = <Appointment>[];
  DateTime? selectedDate;
  late Color selectedColor = Colors.red;
  late TextEditingController titleTE, descriptionTE, locationTE;
  List<Color> colorCollection = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.brown,
    Colors.orange,
    Colors.teal,
    Colors.indigo,
  ];

  @override
  void onInit() {
    events = addAppointments();
    selectedColor = colorCollection[0];
    titleTE = TextEditingController(text: 'Title');
    descriptionTE = TextEditingController(text: 'Description');
    locationTE = TextEditingController(text: 'Location');
    super.onInit();
  }

  void onSelectedColor(value) {
    selectedColor = value;
    update();
  }

  DataSource addAppointments() {
    final DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour);

    appointmentCollection
        .add(Appointment(startTime: today.add(Duration(hours: 2)), endTime: today.add(Duration(hours: 3)), subject: 'Team Sync', color: Colors.blue));

    appointmentCollection.add(Appointment(
        startTime: today.add(Duration(days: 1, hours: 4)), endTime: today.add(Duration(days: 1, hours: 5)), subject: 'Product Demo', color: Colors.orange));

    appointmentCollection.add(Appointment(
        startTime: today.add(Duration(days: 2, hours: 6)),
        endTime: today.add(Duration(days: 2, hours: 7)),
        subject: 'Conference Call',
        color: Colors.blueAccent));

    appointmentCollection.add(Appointment(
        startTime: today.add(Duration(days: 3, hours: 1)), endTime: today.add(Duration(days: 3, hours: 2)), subject: 'Workshop', color: Colors.yellow));

    appointmentCollection.add(Appointment(
        startTime: today.add(Duration(days: 4, hours: 9)),
        endTime: today.add(Duration(days: 4, hours: 10)),
        subject: 'Strategic Planning',
        color: Colors.purpleAccent));

    return DataSource(appointmentCollection);
  }

  void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) {
    Appointment detail = appointmentDragEndDetails.appointment as Appointment;
    Duration duration = detail.endTime.difference(detail.startTime);

    DateTime start = DateTime(appointmentDragEndDetails.droppingTime!.year, appointmentDragEndDetails.droppingTime!.month,
        appointmentDragEndDetails.droppingTime!.day, appointmentDragEndDetails.droppingTime!.hour, 0, 0);

    final List<Appointment> appointment = <Appointment>[];
    events.appointments!.remove(appointmentDragEndDetails.appointment);

    events.notifyListeners(CalendarDataSourceAction.remove, <dynamic>[appointmentDragEndDetails.appointment]);

    Appointment app = Appointment(
      subject: detail.subject,
      color: detail.color,
      startTime: start,
      endTime: start.add(duration),
    );

    appointment.add(app);

    events.appointments!.add(appointment[0]);

    events.notifyListeners(CalendarDataSourceAction.add, appointment);
  }

  void addEvent() {
    final DateTime today = selectedDate ?? DateTime.now();
    Appointment appointment = Appointment(
      startTime: today,
      endTime: today.add(Duration(hours: 1)),
      color: selectedColor,
      subject: descriptionTE.text,
    );
    appointmentCollection.add(appointment);
    titleTE.clear();
    descriptionTE.clear();
    locationTE.clear();
    events = DataSource(appointmentCollection);
    update();
  }

  void onSelectDate(CalendarSelectionDetails calendarSelectionDetails) {
    selectedDate = calendarSelectionDetails.date;
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
