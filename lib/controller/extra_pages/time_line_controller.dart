import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/helpers/widgets/my_text_utils.dart';
import 'package:maxdash/model/time_line.dart';

class TimeLineController extends MyController {
  List<TimeLineModel> timeline = [];
  List<String> dummyTexts = List.generate(12, (index) => MyTextUtils.getDummyText(60));

  @override
  void onInit() {
    TimeLineModel.dummyList.then((value) {
      timeline = value.sublist(0, 6);
      update();
    });
    super.onInit();
  }
}
