import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/user_profile.dart';
import '../cubit/account_cubit.dart';
import '../cubit/account_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final gender = TextEditingController();
  final dob = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    gender.dispose();
    dob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          final p = state.profile;
          if (p == null) {
            return const Center(child: CircularProgressIndicator());
          }
          name.text = p.name;
          email.text = p.email;
          phone.text = p.phone;
          gender.text = p.gender;
          dob.text = p.dob;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(radius: 50, backgroundImage: NetworkImage(p.avatar)),
                const SizedBox(height: 16),
                TextField(controller: name, decoration: const InputDecoration(labelText: 'Full Name')),
                TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
                TextField(controller: phone, decoration: const InputDecoration(labelText: 'Phone')),
                TextField(controller: gender, decoration: const InputDecoration(labelText: 'Gender')),
                TextField(controller: dob, decoration: const InputDecoration(labelText: 'Date of Birth')),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.gradientBlueTop, AppColors.primaryBlue]),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextButton(
                      onPressed: () {
                        context.read<AccountCubit>().saveProfile(
                              UserProfile(
                                name: name.text,
                                email: email.text,
                                phone: phone.text,
                                gender: gender.text,
                                dob: dob.text,
                                avatar: p.avatar,
                              ),
                            );
                        Navigator.maybePop(context);
                      },
                      child: const Text('SAVE CHANGES', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
