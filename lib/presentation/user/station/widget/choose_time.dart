import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/user/station/station_provider.dart';

class RescheduleSessionDialog extends StatelessWidget {
  const RescheduleSessionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: const Color(0xFF121C24),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Book Your Session",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Choose a date and time that works best for you.",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),

            // Date Picker
            const Text(
              "Select Date",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final selected = await showDatePicker(
                  context: context,
                  initialDate: provider.selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: driverPrimaryColor,
                          // onPrimary: Colors.white,
                          // onSurface: Colors.white,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: driverPrimaryColor,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (selected != null) {
                  provider.setSelectedDate(selected);
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2E3E2E)),
                ),
                child: Center(
                  child: Text(
                    provider.selectedDate != null
                        ? "${provider.selectedDate!.year}-${provider.selectedDate!.month.toString().padLeft(2, '0')}-${provider.selectedDate!.day.toString().padLeft(2, '0')}"
                        : "Select Date",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "Select Start and End Time",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            _buildTimeSelector(context, provider),
            const SizedBox(height: 24),
            _buildRescheduleButton(context, provider),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector(BuildContext context, StationProvider provider) {
    return Row(
      children: [
        // Start Time
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: provider.startTime ?? TimeOfDay.now(),
              );
              if (time != null) {
                provider.setStartTime(time);
                // Reset end time if invalid
                // if (provider.endTime != null &&
                //     _timeToDouble(provider.endTime!) <=
                //         _timeToDouble(provider.startTime!)) {
                //   provider.setEndTime(null);
                // }
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2E3E2E)),
              ),
              child: Center(
                child: Text(
                  provider.startTime != null
                      ? _formatTime(provider.startTime!)
                      : "Start Time",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // End Time
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime:
                    provider.endTime ?? provider.startTime ?? TimeOfDay.now(),
              );
              if (time != null) {
                provider.setEndTime(time);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2E3E2E)),
              ),
              child: Center(
                child: Text(
                  provider.endTime != null
                      ? _formatTime(provider.endTime!)
                      : "End Time",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRescheduleButton(
    BuildContext context,
    StationProvider provider,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: driverPrimaryColor,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        if (provider.selectedDate != null &&
            provider.startTime != null &&
            provider.endTime != null) {
          print(
            "Selected Date: ${provider.selectedDate}, Start: ${_formatTime(provider.startTime!)}, End: ${_formatTime(provider.endTime!)}",
          );
          Navigator.pop(context);
        } else {
          CustomSnackbar.show(
            context,
            message: "Please, select the date and time",
            backgroundColor: Colors.red,
          );
        }
      },
      child: const Text(
        "Done",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  double _timeToDouble(TimeOfDay time) => time.hour + time.minute / 60.0;
}
