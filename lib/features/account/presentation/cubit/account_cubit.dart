import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._getProfileUseCase) : super(AccountState.initial());

  final GetProfileUseCase _getProfileUseCase;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    final profile = await _getProfileUseCase();
    emit(state.copyWith(profile: profile, isLoading: false));
  }

  void saveProfile(UserProfile profile) {
    emit(state.copyWith(profile: profile));
  }
}
