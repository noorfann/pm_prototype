import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pm_prototype/cubit/profile_matching/profile_matching_cubit.dart';
import 'package:pm_prototype/cubit/profile_matching/profile_matching_state.dart';
import 'package:pm_prototype/presentation/profile_matching/task/profile_matching_result_table.dart';
import 'package:pm_prototype/presentation/widgets/header_widget.dart';

class ProfileMatchingResultPage extends StatelessWidget {
  const ProfileMatchingResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderWidget(
          title: 'Profile Matching Result',
        ),
        Expanded(
          child: BlocBuilder<ProfileMatchingCubit, ProfileMatchingState>(
            builder: (context, state) {
              if (state is ProfileMatchingLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProfileMatchingError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is ProfileMatchingSuccess) {
                // Wrap dengan LayoutBuilder untuk mendapatkan constraints
                return Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: ProfileMatchingResultTable(
                    results: state.results,
                  ),
                );
              }

              return const Center(
                child: Text('Start profile matching process'),
              );
            },
          ),
        ),
      ],
    );
  }
}
