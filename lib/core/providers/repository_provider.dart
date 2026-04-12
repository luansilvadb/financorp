import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository.dart';

/// Provider that exposes the AppRepository to the rest of the app.
/// The repository is stateless, so a simple Provider is sufficient.
final repositoryProvider = Provider<AppRepository>(
  (ref) => AppRepository(),
);
