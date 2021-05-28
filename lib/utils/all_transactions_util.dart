import 'package:beammart_merchants/widgets/all_transactions_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

allTransactionsUtil(context) {
  return showBarModalBottomSheet(
    expand: true,
    context: context,
    builder: (context) => AllTransactions(),
  );
}
