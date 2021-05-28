import 'package:beammart_merchants/widgets/transaction_detail_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

transactionDetailUtil(context) {
  return showBarModalBottomSheet(
    expand: true,
    context: context,
    builder: (context) => TransactionDetail(),
  );
}
