import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/auth_repository.dart';

// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// AuthState Enum to represent session state
enum AppAuthState {
  initial,
  authenticated,
  unauthenticated,
}

class AuthNotifier extends AsyncNotifier<AppAuthState> {
  late final AuthRepository _authRepository;
  StreamSubscription<AuthState>? _authStateSubscription;

  @override
  FutureOr<AppAuthState> build() {
    _authRepository = ref.watch(authRepositoryProvider);

    // Initialize state
    final currentUser = _authRepository.currentUser;
    final initialState = currentUser != null
        ? AppAuthState.authenticated
        : AppAuthState.unauthenticated;

    // Listen to changes
    _authStateSubscription = _authRepository.authStateChanges.listen((data) {
      final session = data.session;
      if (session != null) {
        state = const AsyncValue.data(AppAuthState.authenticated);
      } else {
        state = const AsyncValue.data(AppAuthState.unauthenticated);
      }
    });

    ref.onDispose(() {
      _authStateSubscription?.cancel();
    });

    return initialState;
  }
}

// Provider for AuthNotifier
final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AppAuthState>(() {
  return AuthNotifier();
});
