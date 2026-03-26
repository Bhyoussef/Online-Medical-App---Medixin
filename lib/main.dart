import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_colors.dart';
import 'core/network/dio_client.dart';
import 'features/account/data/datasources/account_remote_datasource.dart';
import 'features/account/data/repositories/account_repository_impl.dart';
import 'features/account/domain/usecases/get_profile_usecase.dart';
import 'features/account/presentation/cubit/account_cubit.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/get_auth_prefill_usecase.dart';
import 'features/auth/domain/usecases/request_reset_code_usecase.dart';
import 'features/auth/domain/usecases/reset_password_usecase.dart';
import 'features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'features/clinic/data/repositories/clinic_repository_impl.dart';
import 'features/clinic/domain/usecases/get_doctors_usecase.dart';
import 'features/clinic/domain/usecases/get_past_appointments_usecase.dart';
import 'features/clinic/domain/usecases/get_upcoming_appointments_usecase.dart';
import 'features/clinic/presentation/cubit/clinic_cubit.dart';
import 'features/inbox/data/repositories/inbox_repository_impl.dart';
import 'features/inbox/domain/usecases/get_messages_usecase.dart';
import 'features/inbox/domain/usecases/get_threads_usecase.dart';
import 'features/inbox/presentation/cubit/inbox_cubit.dart';
import 'features/notification/data/repositories/notification_repository_impl.dart';
import 'features/notification/domain/usecases/get_notifications_usecase.dart';
import 'features/notification/presentation/cubit/notification_cubit.dart';
import 'features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'features/onboarding/domain/usecases/get_onboarding_slides_usecase.dart';
import 'features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'features/onboarding/presentation/pages/splash_page.dart';
import 'features/payment/data/repositories/payment_repository_impl.dart';
import 'features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'features/payment/presentation/cubit/payment_cubit.dart';

void main() {
  final dioClient = DioClient();
  final onboardingRepository = OnboardingRepositoryImpl();
  final getSlidesUseCase = GetOnboardingSlidesUseCase(onboardingRepository);

  final authRepository = AuthRepositoryImpl();
  final getAuthPrefillUseCase = GetAuthPrefillUseCase(authRepository);
  final requestResetCodeUseCase = RequestResetCodeUseCase(authRepository);
  final verifyResetCodeUseCase = VerifyResetCodeUseCase(authRepository);
  final resetPasswordUseCase = ResetPasswordUseCase(authRepository);

  final clinicRepository = ClinicRepositoryImpl();
  final getDoctorsUseCase = GetDoctorsUseCase(clinicRepository);
  final getUpcomingAppointmentsUseCase =
      GetUpcomingAppointmentsUseCase(clinicRepository);
  final getPastAppointmentsUseCase = GetPastAppointmentsUseCase(clinicRepository);

  final inboxRepository = InboxRepositoryImpl();
  final getThreadsUseCase = GetThreadsUseCase(inboxRepository);
  final getMessagesUseCase = GetMessagesUseCase(inboxRepository);

  final notificationRepository = NotificationRepositoryImpl();
  final getNotificationsUseCase =
      GetNotificationsUseCase(notificationRepository);

  final paymentRepository = PaymentRepositoryImpl();
  final getPaymentMethodsUseCase = GetPaymentMethodsUseCase(paymentRepository);

  final accountRemote = AccountRemoteDataSource(dioClient);
  final accountRepository = AccountRepositoryImpl(accountRemote);
  final getProfileUseCase = GetProfileUseCase(accountRepository);

  runApp(
    MedixinApp(
      getSlidesUseCase: getSlidesUseCase,
      getAuthPrefillUseCase: getAuthPrefillUseCase,
      requestResetCodeUseCase: requestResetCodeUseCase,
      verifyResetCodeUseCase: verifyResetCodeUseCase,
      resetPasswordUseCase: resetPasswordUseCase,
      getDoctorsUseCase: getDoctorsUseCase,
      getUpcomingAppointmentsUseCase: getUpcomingAppointmentsUseCase,
      getPastAppointmentsUseCase: getPastAppointmentsUseCase,
      getThreadsUseCase: getThreadsUseCase,
      getMessagesUseCase: getMessagesUseCase,
      getNotificationsUseCase: getNotificationsUseCase,
      getPaymentMethodsUseCase: getPaymentMethodsUseCase,
      getProfileUseCase: getProfileUseCase,
    ),
  );
}

class MedixinApp extends StatelessWidget {
  const MedixinApp({
    super.key,
    required this.getSlidesUseCase,
    required this.getAuthPrefillUseCase,
    required this.requestResetCodeUseCase,
    required this.verifyResetCodeUseCase,
    required this.resetPasswordUseCase,
    required this.getDoctorsUseCase,
    required this.getUpcomingAppointmentsUseCase,
    required this.getPastAppointmentsUseCase,
    required this.getThreadsUseCase,
    required this.getMessagesUseCase,
    required this.getNotificationsUseCase,
    required this.getPaymentMethodsUseCase,
    required this.getProfileUseCase,
  });

  final GetOnboardingSlidesUseCase getSlidesUseCase;
  final GetAuthPrefillUseCase getAuthPrefillUseCase;
  final RequestResetCodeUseCase requestResetCodeUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final GetDoctorsUseCase getDoctorsUseCase;
  final GetUpcomingAppointmentsUseCase getUpcomingAppointmentsUseCase;
  final GetPastAppointmentsUseCase getPastAppointmentsUseCase;
  final GetThreadsUseCase getThreadsUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;
  final GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  final GetProfileUseCase getProfileUseCase;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnboardingCubit(getSlidesUseCase)),
        BlocProvider(create: (_) => AuthCubit(getAuthPrefillUseCase)),
        BlocProvider(
          create: (_) => ForgotPasswordCubit(
            requestResetCodeUseCase,
            verifyResetCodeUseCase,
            resetPasswordUseCase,
          ),
        ),
        BlocProvider(
          create: (_) => ClinicCubit(
            getDoctorsUseCase,
            getUpcomingAppointmentsUseCase,
            getPastAppointmentsUseCase,
          ),
        ),
        BlocProvider(create: (_) => InboxCubit(getThreadsUseCase, getMessagesUseCase)),
        BlocProvider(create: (_) => NotificationCubit(getNotificationsUseCase)),
        BlocProvider(create: (_) => PaymentCubit(getPaymentMethodsUseCase)),
        BlocProvider(create: (_) => AccountCubit(getProfileUseCase)),
      ],
      child: MaterialApp(
        title: 'Medixin Onboarding',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
