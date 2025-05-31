import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/constants/images/enums/enums.dart';
import 'package:onbush/core/database/key_storage.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/presentation/blocs/payment/payment_cubit.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/services/payment/payment_handler.dart';

@RoutePage()
class PaymentPendingScreen extends StatelessWidget {
  final String paymentId;
  final String email;

  const PaymentPendingScreen({
    super.key,
    required this.paymentId,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final paymentCubit = getIt<PaymentCubit>()..reset();

    return BlocProvider.value(
      value: paymentCubit,
      child: PaymentPendingContent(
        paymentCubit: paymentCubit,
        paymentId: paymentId,
        email: email,
      ),
    );
  }
}

class PaymentPendingContent extends StatefulWidget {
  final PaymentCubit paymentCubit;
  final String paymentId;
  final String email;

  const PaymentPendingContent({
    super.key,
    required this.paymentCubit,
    required this.paymentId,
    required this.email,
  });

  @override
  State<PaymentPendingContent> createState() => _PaymentPendingContentState();
}

class _PaymentPendingContentState extends State<PaymentPendingContent> {
  late final PaymentHandler _paymentHandler;
  Timer? _countdownTimer;
  int _countdownValue = _initialCountdown;
  bool _isVerificationSuccessful = false;
  late final _applicationCubit = getIt<ApplicationCubit>();

  static const int _initialCountdown = 90;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.paymentCubit.verifying(
          transactionId: widget.paymentId,
          device: getIt<LocalStorage>().getString(StorageKeys.deviceId)!);
    });
    _initializeHandler();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _initializeHandler() {
    _paymentHandler = PaymentHandler(
      context: context,
      paymentCubit: widget.paymentCubit,
      setState: setState,
      goToApplication: () => context.router.push(const ApplicationRoute()),
      onCompleted: _handleVerificationSuccess,
    );
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_countdownValue > 0) {
          _countdownValue--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _handleVerificationSuccess() {
    if (mounted) {
      setState(() {
        _isVerificationSuccessful = true;
      });
    }
  }

  String _formatSeconds(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2)}:${seconds.toString().padLeft(2, "0")}min';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) async {
        await _paymentHandler.handle(
          state,
          widget.paymentId,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: SafeArea(child: _buildContent()),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        _isVerificationSuccessful ? "Paiement réussi" : "Paiement initialisé",
        style: TextStyle(
          color: _isVerificationSuccessful ? AppColors.green : AppColors.orange,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Gap(40.h),
          Center(
              child: Visibility(
                  visible: !_isVerificationSuccessful,
                  child: Text(
                    "Temps restant :${_formatSeconds(_countdownValue)}",
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          Gap(90.h),
          Image.asset(
            AppImage.getAvatarImage(
                getIt.get<ApplicationCubit>().getUserGender(),
                _isVerificationSuccessful
                    ? AvatarState.success
                    : AvatarState.thinking),
            height: 150.h,
            width: 150.w,
          ),
          Gap(60.h),
          _buildActionButton(),
          Gap(20.h),
          Visibility(
            visible: _isVerificationSuccessful,
            child: Text(
              "Cool tu as buy,\n😏 tu peux yamo onbush oklm 🤪",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            AppImage.allOnBush,
            height: 60.h,
            width: 60.w,
          ),
          Gap(40.h),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    final isEnabled = _countdownValue == 0 || _isVerificationSuccessful;

    return IgnorePointer(
      ignoring: !isEnabled,
      child: Opacity(
        opacity: isEnabled ? 1 : 0.5,
        child: AppButton(
          onPressed: () {
            if (_isVerificationSuccessful) {
              _applicationCubit.setUserGender(
                  getIt.get<ApplicationCubit>().getUserGender().name);
              context.router.push(const ReminderRoute());
            } else {
              context.router.push(PriceRoute(email: widget.email));
            }
          },
          text: _isVerificationSuccessful ? "Continuer" : "Recommencer",
          bgColor: AppColors.primary,
          width: double.infinity,
        ),
      ),
    );
  }
}
