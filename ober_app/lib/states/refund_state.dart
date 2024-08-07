import 'package:ober_app/models/refund_response.dart';

class RefundState {
  List<RefundData> list;

  bool isDataInit;

  int currentPage;
  int lastPage;



  RefundState(
      {required this.lastPage,
      required this.currentPage,
      required this.isDataInit,
      required this.list});

  RefundState.init()
      : list = [],
        currentPage = 0,
        lastPage = 0,
        isDataInit = false;

  RefundState update(RefundState state) {
    return RefundState(
        isDataInit: state.isDataInit,
        currentPage: state.currentPage,
        lastPage: state.lastPage,
        list: state.list);
  }
}
