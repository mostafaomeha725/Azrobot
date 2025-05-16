
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:azrobot/features/auth/presentation/manager/cubits/reminder_cubit/cubit/reminder_cubit.dart';
import 'package:azrobot/features/home/presentation/views/widgets/add_reminders_card.dart';
import 'package:azrobot/features/home/presentation/views/widgets/reminder_card_widget.dart';

class RemindersViewBody extends StatelessWidget {
  const RemindersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const AddRemindersCard(),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<ReminderCubit, ReminderState>(
              builder: (context, state) {
                if (state is ReminderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReminderFailure) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is ReminderSuccess) {
                  final reminders = state.reminders;
                  if (reminders.isEmpty) {
                    return const Center(child: Text('No reminders yet.'));
                  }

                  return ListView.builder(
                    itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = reminders[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ReminderCardWidget(
                          title: reminder.reminderText,
                          repeat: reminder.repeat,
                          dateTime: reminder.dateTime, reminderKey: index,
                          // يمكنك إضافة زر للتعديل أو الحذف لاحقًا
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Unexpected state.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}




