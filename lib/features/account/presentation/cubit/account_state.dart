import 'package:equatable/equatable.dart';

import '../../domain/entities/user_profile.dart';

class AccountState extends Equatable {
  const AccountState({required this.profile, required this.isLoading});

  factory AccountState.initial() => const AccountState(profile: null, isLoading: false);

  final UserProfile? profile;
  final bool isLoading;

  AccountState copyWith({UserProfile? profile, bool? isLoading}) => AccountState(
        profile: profile ?? this.profile,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [profile, isLoading];
}
