import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/indent_order.dart';
import 'package:aavinposfro/models/order.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/presentation/screens/checkout/place_order_container.dart';
import 'package:aavinposfro/presentation/screens/checkout/review_order_container.dart';
import 'package:aavinposfro/routes.dart';
import 'package:aavinposfro/utils/OrderStatus.dart';
import 'package:aavinposfro/utils/ResponseMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key key}) : super(key: key);

  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  _ViewModel vm;
  int _currentStep;
  bool canSubmit;

  String get _btnText {
    if (_currentStep == 0) {
      return "Confirm";
    } else {
      return vm.order.paymentMode == PaymentMode.cashOnDelivery
          ? "Place Order"
          : "Make Payment";
    }
  }

  @override
  void initState() {
    super.initState();
    canSubmit = false;
    _currentStep = 0;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        this.vm = vm;
        return Scaffold(
          appBar: AppBar(
              title: Text("Checkout"),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  vm.back();
                },
              )),
          body: Stepper(
            type: StepperType.horizontal,
            controlsBuilder: (BuildContext context,
                ControlsDetails details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  vm.isLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  ):Container(),
                  Container(
                    child: null,
                  ),
                  Container(
                    child: null,
                  ),
                ],
              );
            },
            currentStep: _currentStep,
            onStepContinue: _onStepContinue,
            onStepCancel: _onStepCancel,
            onStepTapped: _onStepTapped,
            steps: <Step>[
              Step(
                  isActive: _currentStep == 0,
                  state: _currentStep == 1
                      ? StepState.complete
                      : StepState.editing,
                  content: ReviewOrderContainer(vm.order),
                  title: Text("Review Order")),
              Step(
                  isActive: _currentStep == 1,
                  state: _currentStep == 0
                      ? StepState.disabled
                      : StepState.editing,
                  content: PlaceOrderContainer(),
                  title: Text("Place Order"))
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 76,
            child: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Grand Total".toUpperCase(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "₹ ${vm.order.cart.total.total_price}",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),


                      onPressed: _onStepContinue,
                      child: Row(
                        children: <Widget>[
                          Text(_btnText),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _onStepContinue() async{

    debugPrint("onAuthStateChanged "+vm.order.cart.items.toString());
    debugPrint(_currentStep.toString());
    if(_currentStep==1){
      if(vm.order.deliveryDate==null){


      }else{

        List<Product>product=getUpdatedProduct(vm.order.cart.items);
        IndentOrder indentOrder=IndentOrder("",vm.order.deliveryDate.millisecondsSinceEpoch,product,IndentOrderStatus.OrderPlaced,vm.storeDetails.storeDocumentID,vm.storeDetails.storeCode,vm.order.total,vm.order.cart.total.total_basicprice,vm.order.cart.total.total_gst,vm.order.cart.total.total_cgst,vm.order.cart.total.total_sgst,vm.order.cart.total.total_igst,vm.order.cart.items.length,vm.storeDetails.regionID,vm.storeDetails.zoneID,vm.storeDetails.storeAddress,vm.contactNumber,vm.storeDetails.contactPerson,vm.order.cart.items);
       var obj= await vm.placeOrder(indentOrder);
//
       debugPrint(vm.message);
//      if(vm.message==ResponseMessage.success){
        _showDialog("You order has been placed successfully");
//        //vm.back();
//      }else{
//
//        _showDialog(vm.message);
//      }
      //debugPrint(vm.message);
      }
    }else{
      _currentStep + 1 != 2 ? _onStepTapped(_currentStep + 1) : null;
    }
  }
  List<Product>getUpdatedProduct(Map<Product, int> items){
    List<Product>productlist=List();
    items
      ..forEach((key, value) {
        key.selected_quantity = value;
        productlist.add(key);
      });
    return productlist;
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
            vm.back();
          },
          child: new Text('OK'),
        ),
      ],
    ),
    );

  }
  _onStepCancel() {
    if (_currentStep > 0) {
      _onStepTapped(_currentStep - 1);
    }
  }

  _onStepTapped(int step) {
    setState(() => {_currentStep = step});
  }
}

class _ViewModel {

  final bool isLoading;
  final Order order;
  final String message;
  final StoreDetails storeDetails;
 // final IndentOrder indentOrder;
  final Function(Order order) updateOrder;
  final Function(IndentOrder order) placeOrder;
  final Function() makePayment;
  final Function() back;
  final int contactNumber;

  _ViewModel(this.isLoading,this.order, this.updateOrder, this.placeOrder, this.makePayment,
      this.back,this.storeDetails,this.message,this.contactNumber);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        store.state.isLoading,
        store.state.order,
        (order) => store.dispatch(UpdateOrderAction(order)),
        (indentorder) => store.dispatch(PlaceOrderAction(indentorder)),
        () => store.dispatch(MakePaymentAction()),
        () => store.dispatch(NavigateAction(AppRoutes.home)),
        store.state.storeDetails,
    store.state.message,
    store.state.phoneNumber);
  }
}
