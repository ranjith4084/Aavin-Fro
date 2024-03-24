import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class PlaceOrderContainer extends StatefulWidget {
  const PlaceOrderContainer({Key key}) : super(key: key);

  _PlaceOrderContainerState createState() => _PlaceOrderContainerState();
}

class _PlaceOrderContainerState extends State<PlaceOrderContainer> {
  _ViewModel vm;
  Order _order;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _deliveryAddressEditingController;

  void _initWidget(Store<AppState> store) {
    _order = store.state.order;
    _deliveryAddressEditingController =
        TextEditingController(text: store.state.order.deliveryAddress ?? "");
    _deliveryAddressEditingController.addListener(() {
      final inputAddress = _deliveryAddressEditingController.text;
      _order.deliveryAddress = inputAddress;
      vm.updateOrder(_order);
    });
  }

  _onPaymentModeChanged(PaymentMode paymentMode) {
    _order.paymentMode = paymentMode;
    vm.updateOrder(_order);
  }

  _onDeliveryDeliveryDatePressed(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: 4)),
        firstDate:  DateTime.now().add(Duration(days: 4)),
        lastDate: DateTime.now().add(Duration(days: 30)));

    if (picked != null && picked != vm.order.deliveryDate) {
      _order.deliveryDate = picked;
      if(vm.indentOrderList!=null&&vm.indentOrderList.length>0){
        var indentDate = vm.indentOrderList.where((element) => element.deliveryDate == picked.millisecondsSinceEpoch);
        if(indentDate.isEmpty){
          vm.updateOrder(_order);
        }else{
          _showDialog("Already indent has been placed on this day please select different day");
        }

      }else{
        vm.updateOrder(_order);
      }

    }
  }

  _showDialog(String content)async{
    await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Aavin'),
        content: Text(content),
        actions: <Widget>[
          new ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              //_vm.orderhistory();

              //  vm.back();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        onInit: _initWidget,
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          this.vm = vm;
          return Container(
            child: Form(
              autovalidateMode: AutovalidateMode.always, key: _formKey,
              child: Wrap(
                runSpacing: 16,
                children: <Widget>[
                  Text(
                    "Select Delivery Date",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  _DeliveryDatePicker(
                    deliveryDate: vm.order.deliveryDate,
                    onDeliveryDatePressed: _onDeliveryDeliveryDatePressed,
                  ),
//                  Text(
//                    "Delivery Address",
//                    style: Theme.of(context).textTheme.subtitle1,
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 16, right: 16),
//                    child: _DeliveryAddressField(
//                      deliveryAddressEditingController:
//                          _deliveryAddressEditingController,
//                    ),
//                  ),
                  Text(
                    "Select Payment Mode",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  _PaymentModeSelector(
                    paymentMode: vm.order.paymentMode,
                    onPaymentModeChanged: _onPaymentModeChanged,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final Order order;
  final Function(Order order) updateOrder;
  final List<IndentOrder>indentOrderList;

  _ViewModel(this.updateOrder, this.order,this.indentOrderList);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        (order) => store.dispatch(UpdateOrderAction(order)), store.state.order,
     store.state.indentOrder);
  }
}

class _DeliveryAddressField extends StatelessWidget {
  final TextEditingController deliveryAddressEditingController;

  const _DeliveryAddressField({
    Key key,
    @required this.deliveryAddressEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      width: double.infinity,
//      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
//      padding: EdgeInsets.all(12),
//      child: Text("23A, Opaline Road,\nT Nagar,\nChennai"),
    );
//      TextFormField(
//      textAlignVertical: TextAlignVertical.top,
//      validator: (input) {
//        return input.isEmpty
//            ? "Delivery Address is required to place order."
//            : null;
//      },
//      decoration: InputDecoration(
//          focusedBorder: OutlineInputBorder(
//            borderSide: BorderSide(
//              color: Theme.of(context).primaryColor,
//            ),
//          ),
//          enabledBorder: OutlineInputBorder(
//            borderSide: BorderSide(
//              color: Colors.grey[500],
//            ),
//          ),
//          errorBorder: OutlineInputBorder(
//            borderSide: BorderSide(
//              color: Colors.red[500],
//            ),
//          ),
//          focusedErrorBorder: OutlineInputBorder(
//            borderSide: BorderSide(
//              color: Colors.red[500],
//            ),
//          ),
//          labelText: 'Enter your Delivery Address',
//          alignLabelWithHint: true),
//      maxLines: 5,
//      controller: deliveryAddressEditingController,
//      style: Theme.of(context).textTheme.bodyText2,
//    );
  }
}

class _DeliveryDatePicker extends StatelessWidget {
  final Function(BuildContext) onDeliveryDatePressed;
  final DateTime deliveryDate;

  const _DeliveryDatePicker(
      {Key key, @required this.onDeliveryDatePressed, this.deliveryDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: this.deliveryDate == null
                          ? Colors.red
                          : Colors.grey[500]),
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: Colors.transparent,
            ),
            // padding: EdgeInsets.only(left: 32, right: 16, top: 16, bottom: 16),
            // elevation: 0,


            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    this.deliveryDate == null
                        ? "Select Delivery Date"
                        : DateFormat("E, d MMM y")
                        .format(this.deliveryDate)
                        .toString(),
                    style: Theme.of(context).textTheme.headline5),
                this.deliveryDate == null
                    ? Icon(Icons.edit,
                    color: this.deliveryDate == null
                        ? Colors.red
                        : Theme.of(context).textTheme.bodyText2.color)
                    : Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              ],
            ),
            onPressed: () => onDeliveryDatePressed(context),
          ),
          if (this.deliveryDate == null)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                "Delivery Date is required.",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.red[700], fontSize: 11),
              ),
            )
        ],
      ),
    );
  }
}

class _PaymentModeSelector extends StatelessWidget {
  final PaymentMode paymentMode;
  final Function(PaymentMode) onPaymentModeChanged;

  const _PaymentModeSelector(
      {Key key,
      @required this.paymentMode,
      @required this.onPaymentModeChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[500]),
              borderRadius: BorderRadius.circular(8)),
          child: RadioListTile(
            selected: this.paymentMode == PaymentMode.cashOnDelivery,
            value: PaymentMode.cashOnDelivery,
            groupValue: this.paymentMode,
            onChanged: onPaymentModeChanged,
            title: Text(
              "Cash on Delivery",
              style: Theme.of(context).textTheme.headline5,
            ),
            secondary: Icon(Icons.account_balance_wallet),
          ),
        ),
//        Container(
//          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
//          decoration: BoxDecoration(
//              border: Border.all(color: Colors.grey[500]),
//              borderRadius: BorderRadius.circular(8)),
//          child: RadioListTile(
//            selected: this.paymentMode == PaymentMode.onlinePayment,
//            value: PaymentMode.onlinePayment,
//            groupValue: this.paymentMode,
//            onChanged: onPaymentModeChanged,
//            title: Text("Pay Online",
//                style: Theme.of(context).textTheme.headline5),
//            secondary: Icon(Icons.payment),
//          ),
//        )
      ],
    );
  }
}
