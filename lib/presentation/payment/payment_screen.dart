import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_app/domain/ext.dart';
import 'package:ticket_app/domain/providers.dart';
import 'package:ticket_app/presentation/payment/payment_states.dart';

import 'package:ticket_app/presentation/payment/payment_viewmodel.dart';
import 'package:ticket_app/presentation/styles/app_colors.dart';
import '../../domain/models/event.dart';
import '../widgets/order_placed_dialog.dart';
import '../widgets/payment_option.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({required this.event, super.key});

  final Event event;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final PaymentViewModel _viewModel = PaymentViewModel();
  var flag = 0;

  @override
  Widget build(BuildContext context) {
    ref.listen<StateController<PaymentStates>>(paymentStateProvider.state,
        (previous, current) {
      switch (current.state.runtimeType) {
        case ErrorPaymentState:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text((current.state as ErrorPaymentState).msg)),
          );
          break;
        case SuccessPaymentState:
          ref.addTicket(widget.event);
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) => const OrderPlacedDialog(),
          );
          break;
      }
    });
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ref.isPaymentStateLoading
                ? const CircularProgressIndicator(color: AppColors.red)
                : Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Stripe Payment
                        // _viewModel.makeStripePayment(
                        //   ref,
                        //   widget.event.prices[0].toString(),
                        //   'USD',
                        // );

                        // PayTabs Payment
                        _viewModel.makePayTabsPayment(ref, 100.0);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0,
        centerTitle: false,
        title: const Text("Payment options"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Select a payment option to continue...",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          Image.network(
            'https://raw.githubusercontent.com/SupreetRonad/Cart-screen-App/main/imgs/payment.png',
            height: MediaQuery.of(context).size.height * .3,
          ),
          PaymentOption(
            height: 70,
            index: 0,
            name: 'Credit / Debit Card',
            icon: Icons.credit_card,
            flag: flag,
            onPress: () {
              setState(() {
                flag = 0;
              });
            },
          ),
          PaymentOption(
            height: 70,
            index: 1,
            name: 'Internet Banking',
            icon: Icons.language,
            flag: flag,
            onPress: () {
              setState(() {
                flag = 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
