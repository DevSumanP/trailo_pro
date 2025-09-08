import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trailo_pro/features/authentication/presentation/pages/signin_screen.dart';
import 'package:trailo_pro/features/authentication/presentation/provider/auth_provider.dart';
import 'package:trailo_pro/features/onboarding/presentation/pages/splash_screen.dart';


class AuthGuard extends ConsumerWidget{
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return authState.when(
      initial: () => const SplashScreen(),
      loading: () => const Center(child: CircularProgressIndicator()),
      authenticated: (user) => child,
      unauthenticated: () => const SignInScreen(),
      error: (message) => const SignInScreen(),
    );
  }
}