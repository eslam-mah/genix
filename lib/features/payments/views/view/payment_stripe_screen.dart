import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/payments/data/models/stripe_form.dart';
import 'package:genix/features/payments/view_model/create_stripe/create_stripe_cubit.dart';
import 'package:genix/features/settings%20screen/views/widgets/custom_billing_widget.dart';

class PaymentStripeScreen extends StatefulWidget {
  static const String routeName = '/payment_stripe_screen';
  final num amount;

  const PaymentStripeScreen({super.key, required this.amount});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentStripeScreenState createState() => _PaymentStripeScreenState();
}

class _PaymentStripeScreenState extends State<PaymentStripeScreen> {
  Future<void> _displayPaymentSheet(
      BuildContext context, String clientSecret) async {
    try {
      // Initialize payment sheet with client secret
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Genix',
        ),
      );

      // Display payment sheet
      await Stripe.instance.presentPaymentSheet();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment completed successfully!')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Initiate the payment request to get the client_secret
    context
        .read<CreateStripeCubit>()
        .createStripe(data: StripeForm(amount: widget.amount));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: Text(
          'Stripe Payment',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
      ),
      body: BlocConsumer<CreateStripeCubit, CreateStripeState>(
        listener: (context, state) {
          if (state is CreateStripeSuccess) {
            _displayPaymentSheet(context, state.clientSecret);
          } else if (state is CreateStripeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is CreateStripeLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            ));
          }

          return Padding(
            padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
            child: Column(
              children: [
                CustomBillingWidget(
                    isSelected: 0,
                    numberSelected: 0,
                    amount: widget.amount,
                    isNightModeEnabled: ThemeCubit().state == ThemeState.dark)
              ],
            ),
          );
        },
      ),
    );
  }
}
