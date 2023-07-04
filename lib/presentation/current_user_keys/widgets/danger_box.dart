import 'package:ditto/presentation/general/info_box.dart';

class DangerBox extends InfoBox {
  DangerBox({
    super.key,
    required super.bgColor,
    super.messageText,
    required super.titleText,
    super.showPopIcon = true,
  });
}
