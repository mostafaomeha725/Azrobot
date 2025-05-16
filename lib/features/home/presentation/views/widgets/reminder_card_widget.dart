import 'package:azrobot/core/api_services/api_service.dart';
import 'package:azrobot/features/account/data/note_model.dart';
import 'package:azrobot/features/auth/presentation/manager/cubits/reminder_cubit/cubit/reminder_cubit.dart';
import 'package:azrobot/features/auth/presentation/widgets/hint_text_auth.dart';
import 'package:flutter/material.dart';
import 'package:azrobot/core/utils/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ReminderCardWidget extends StatelessWidget {
  final String title;
  final String repeat;
  final String dateTime;
  final int reminderKey;

  const ReminderCardWidget({
    super.key,
    required this.title,
    required this.repeat,
    required this.dateTime,
    required this.reminderKey,
  });

  // Function to show the update reminder dialog
  void _showUpdateReminderDialog(BuildContext context) {
    final TextEditingController _titleController = TextEditingController(
      text: title,
    );
    final TextEditingController _dateController = TextEditingController(
      text: dateTime,
    );
    String _selectedRepeat = repeat;

    Future<void> _selectDateTime(BuildContext context) async {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
      );

      if (selectedDate != null) {
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (selectedTime != null) {
          int hour =
              selectedTime.hourOfPeriod == 0 ? 12 : selectedTime.hourOfPeriod;
          String amPm = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';

          DateFormat dateFormat = DateFormat('MM/dd/yyyy');
          String formattedDate = dateFormat.format(selectedDate);

          String formattedDateTime =
              "$formattedDate $hour:${selectedTime.minute.toString().padLeft(2, '0')} $amPm";
          _dateController.text = formattedDateTime;
        }
      }
    }

    showDialog(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff44ded1),
                      ),
                      child: Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Update Reminder',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    HintTextAuth(hint: 'Date & Time'),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDateTime(context),
                        ),
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),
                    HintTextAuth(hint: 'Reminder for:'),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    HintTextAuth(hint: "Repeat :"),
                    SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      value: _selectedRepeat,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items: <String>[
                        'Once',
                        'Daily',
                        'Monthly',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        _selectedRepeat = newValue!;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff134FA2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                  onPressed: () {
  final updatedReminder = ReminderModel(
    reminderText: _titleController.text,
    repeat: _selectedRepeat,
    dateTime: _dateController.text,
  );

  context.read<ReminderCubit>().updateReminder(
    userId: userId!,
    index: reminderKey,
    updatedReminder: updatedReminder,
  ).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reminder updated successfully!'),
      ),
    );
    GoRouter.of(context).pop();
  });
},

                      child: Text(
                        'Update',
                        style: TextStyles.bold12w500.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF41D5C5),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_alarm, color: Colors.white, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    '$repeat - $dateTime',
                    style: TextStyles.bold12w400.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0062CC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.chevron_right_sharp,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                _showUpdateReminderDialog(context); // Show update dialog
              },
            ),
          ),
        ],
      ),
    );
  }
}
