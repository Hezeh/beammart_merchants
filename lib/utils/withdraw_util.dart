import 'package:beammart_merchants/widgets/withdraw_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

withdrawUtil(context) {
  return showBarModalBottomSheet(
    expand: true,
    context: context,
    builder: (context) => Withdraw(),
  );
}
