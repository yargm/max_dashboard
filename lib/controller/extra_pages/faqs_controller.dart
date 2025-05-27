import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/helpers/widgets/my_text_utils.dart';

class FaqsController extends MyController {
  final List<bool> dataExpansionPanel = [true, false, false, false, false, false];
  List<String> dummyTexts = List.generate(12, (index) => MyTextUtils.getDummyText(60));
}
