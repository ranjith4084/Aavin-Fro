import 'dart:developer';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:aavinposfro/models/product.dart';
import 'package:aavinposfro/models/stock.dart';
import 'package:aavinposfro/presentation/screens/home/my_store/update_stock_container.dart';
import 'package:aavinposfro/presentation/screens/home/my_store/updated_stock_summary.dart';
import 'package:aavinposfro/presentation/widgets/custom_stepper.dart'
    as customStepper;
import 'package:aavinposfro/presentation/widgets/custom_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class UpdateStockDialog extends StatefulWidget {
  UpdateStockDialog();

  @override
  _UpdateStockDialogState createState() => _UpdateStockDialogState();
}

class _UpdateStockDialogState extends State<UpdateStockDialog> {
  int _currentStep;
  _ViewModel _vm;
  final _snackBar = SnackBar(content: Text("Stock Updated Successfully."));
 // final firestoreInstance = Fi.instance;

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
  }

  void updateStock() async {
    // Map<String, dynamic> objects = {};
    // objects.addAll(this._vm.stockDraft.toJson());
    // log(this._vm.stockDraft.toJson().toString());
    // var id = await firestoreInstance
    //     .collection("stock")
    //     .add(objects);
    // log(id.toString());
  }

  _onStepContinue() {
    if (_currentStep == 1) {
      _vm.submitStock();
//      Scaffold.of(context).showSnackBar(_snackBar);
      this.updateStock();

//      Navigator.pop(context);
    } else {
      _onStepTapped(_currentStep + 1);
    }
  }

  _onStepCancel() {
    if (_currentStep > 0) {
      _onStepTapped(_currentStep - 1);
    }
  }

  _onStepTapped(int step) {
    setState(() => {_currentStep = step});
  }

  Widget get _fab {
    if (_vm.updatedStock.length > 0) {
      return _currentStep == 0
          ? FloatingActionButton(
              onPressed: _onStepContinue,
              child: Icon(Icons.done),
            )
          : FutureBuilder(
              future: Future.delayed(Duration(
                milliseconds: 300,
              )),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return SizedBox.shrink();
                    break;
                  case ConnectionState.waiting:
                    return SizedBox.shrink();
                    break;
                  case ConnectionState.active:
                    return SizedBox.shrink();
                    break;
                  case ConnectionState.done:
                    return FloatingActionButton.extended(
                      onPressed: _onStepContinue,
                      label: Text("Submit"),
                      icon: Icon(Icons.save),
                    );
                    break;
                  default:
                    return null;
                }
              },
            );
    } else {
      SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          this._vm = vm;
          return Scaffold(
            appBar: AppBar(
              title: Text("Update Stock"),
            ),
            body: CustomStepper(
              type: customStepper.StepperType.horizontal,
              physics: ClampingScrollPhysics(),
              currentStep: _currentStep,
              onStepContinue: _onStepContinue,
              onStepCancel: _onStepCancel,
              onStepTapped: _onStepTapped,
              controlsBuilder: (BuildContext context,
                  ControlsDetails details) {
                return Row(
                  children: <Widget>[
                    Container(
                      child: null,
                    ),
                    Container(
                      child: null,
                    ),
                  ],
                );
              },
              steps: <customStepper.Step>[
                customStepper.Step(
                  title: Text("Update Stock"),
                  content: UpdateStockContainer(vm.stock.items),
                  isActive: _currentStep == 0,
                  state: _currentStep == 1
                      ? customStepper.StepState.complete
                      : customStepper.StepState.editing,
                ),
                customStepper.Step(
                  title: Text("Submit"),
                  content: UpdatedStockSummary(),
                  isActive: _currentStep == 1,
                  state: _currentStep == 0
                      ? customStepper.StepState.disabled
                      : customStepper.StepState.editing,
                )
              ],
            ),
            floatingActionButtonLocation: _currentStep == 0
                ? FloatingActionButtonLocation.endFloat
                : FloatingActionButtonLocation.centerFloat,
            floatingActionButton: _fab,
          );
        });
  }
}

class _ViewModel {
  final Stock stock;
  final Stock stockDraft;
  final Map<Product, int> updatedStock;
  final Function() submitStock;

  _ViewModel(this.stock, this.stockDraft, this.updatedStock, this.submitStock);

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store.state.stock, store.state.stockDraft,
        store.state.updatedStock, () => store.dispatch(SubmitStockAction()));
  }
}
