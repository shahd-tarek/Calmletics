import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sports_mind/community/coachCommunity/showSuccessDialog.dart';
import 'package:sports_mind/constant.dart';
import 'package:sports_mind/widgets/custom_button.dart';

class BookVRSessionPage extends StatefulWidget {
  const BookVRSessionPage({super.key});

  @override
  _BookVRSessionPageState createState() => _BookVRSessionPageState();
}

class _BookVRSessionPageState extends State<BookVRSessionPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int? selectedTimeSlotIndex;

  // Hardcoded time slots
  final List<String> timeSlots = [
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "12:00 PM - 1:00 PM",
    "1:00 PM - 2:00 PM",
    "2:00 PM - 3:00 PM",
  ];

  void bookSession() {
    if (_selectedDay == null || selectedTimeSlotIndex == null) {
      Get.snackbar("Error", "Please select a date and time slot",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    String sessionDetails =
        "${_selectedDay?.day ?? "N/A"}/${_selectedDay?.month ?? "N/A"}/${_selectedDay?.year ?? "N/A"}, ${selectedTimeSlotIndex != null ? timeSlots[selectedTimeSlotIndex!] : "N/A"}";

    // Show success dialog
    showSuccessDialog(context, sessionDetails);

    setState(() {
      _selectedDay = null;
      selectedTimeSlotIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Select Date",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // Table Calendar (One Week View with Horizontal Scroll)
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime(2100, 12, 31),
              calendarFormat: CalendarFormat.week, // Show only one week
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // Keep track of the focused day
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false, // Hide format button
                titleCentered: true,
              ),
            ),

            const SizedBox(height: 20),

            // Time Slots List
            Expanded(
              child: ListView.builder(
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedTimeSlotIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedTimeSlotIndex = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green[100] : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        timeSlots[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Confirm Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: "Confirm",
                  ontap: bookSession,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}










/*class BookVRSessionPage extends StatefulWidget {
  const BookVRSessionPage({super.key});

  @override
  _BookVRSessionPageState createState() => _BookVRSessionPageState();
}

class _BookVRSessionPageState extends State<BookVRSessionPage> {
  int? selectedDateIndex;
  int? selectedTimeSlotIndex;
  List<Map<String, dynamic>> dates = [];
  List<String> timeSlots = [];
  bool isLoading = true;

  final String apiBaseUrl = "https://your-api.com"; // Replace with your API URL

  @override
  void initState() {
    super.initState();
    fetchAvailableDates();
  }

  Future<void> fetchAvailableDates() async {
    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/available-dates'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          dates =
              data.map((e) => {'day': e['day'], 'date': e['date']}).toList();
          isLoading = false;
        });
      } else {
        Get.snackbar("Error", "Failed to fetch dates",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> fetchAvailableTimeSlots(int date) async {
    setState(() {
      timeSlots = [];
      isLoading = true;
    });

    try {
      final response = await http
          .get(Uri.parse('$apiBaseUrl/available-time-slots?date=$date'));
      if (response.statusCode == 200) {
        setState(() {
          timeSlots = List<String>.from(jsonDecode(response.body));
          isLoading = false;
        });
      } else {
        Get.snackbar("Error", "Failed to fetch time slots",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> bookSession() async {
    if (selectedDateIndex == null || selectedTimeSlotIndex == null) {
      Get.snackbar("Error", "Please select a date and time slot",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final selectedDate = dates[selectedDateIndex!];
    final selectedTime = timeSlots[selectedTimeSlotIndex!];

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/book-session'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'date': selectedDate['date'],
          'day': selectedDate['day'],
          'time': selectedTime,
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar("Success", "VR session booked successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);

        setState(() {
          selectedDateIndex = null;
          selectedTimeSlotIndex = null;
        });
      } else {
        Get.snackbar("Error", "Failed to book session",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book VR Session'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Feb 2024",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(dates.length, (index) {
                      bool isSelected = selectedDateIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedDateIndex = index);
                          fetchAvailableTimeSlots(dates[index]['date']);
                        },
                        child: Column(
                          children: [
                            Text(dates[index]['day'],
                                style: TextStyle(color: Colors.grey[700])),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ?  const Color.fromRGBO(106, 149, 122, 0.5)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                dates[index]['date'].toString(),
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  timeSlots.isEmpty
                      ? Center(child: Text("No time slots available"))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: timeSlots.length,
                            itemBuilder: (context, index) {
                              bool isSelected = selectedTimeSlotIndex == index;
                              return GestureDetector(
                                onTap: () => setState(
                                    () => selectedTimeSlotIndex = index),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.green[100]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Text(
                                    timeSlots[index],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: bookSession,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Center(
                      child: Text("Confirm",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
*/