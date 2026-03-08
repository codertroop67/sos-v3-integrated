// import 'dart:collection';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:myapp/main.dart';
// import 'package:myapp/models/medication.dart';
// import 'package:myapp/screens/create_alert_screen.dart';
// import 'package:myapp/screens/faq_screen.dart';
// import 'package:myapp/screens/home_screen.dart';
// import 'package:myapp/screens/settings_screen.dart';
// import 'package:myapp/text.dart';
// import 'package:myapp/widgets/bottom_nav_bar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:table_calendar/table_calendar.dart';

// class ReminderScreen extends StatefulWidget {
//   const ReminderScreen({super.key});

//   @override
//   State<ReminderScreen> createState() => _ReminderScreenState();
// }

// class _ReminderScreenState extends State<ReminderScreen> {
//   late final ValueNotifier<List<Medication>> _selectedEvents;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   late PageController _pageController;
//   bool _isCalendarVisible = false;
//   int _selectedIndex = 1;

//   final List<Medication> _medications = [];

//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//     _pageController = PageController();
//     _loadMedications();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _showTestNotification();
//   }

//   void _showTestNotification() {
//     final appTexts = AppTexts.of(context);
//     notificationService.scheduleNotification(
//       id: 999, // A unique ID for the test notification
//       title: appTexts.testNotification,
//       body: appTexts.notificationsWorking,
//       scheduledDate: DateTime.now().add(const Duration(seconds: 3)),
//     );
//   }

//   Future<void> _loadMedications() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final content = prefs.getString('medications');

//       if (content != null) {
//         final List<dynamic> jsonData = jsonDecode(content);

//         setState(() {
//           _medications.clear();
//           _medications.addAll(
//             jsonData.map((item) => Medication.fromJson(item)).toList(),
//           );
//           _selectedEvents.value = _getEventsForDay(_selectedDay!);
//         });
//       }
//     } catch (e, s) {
//       log('Error loading medications', error: e, stackTrace: s);
//     }
//   }

//   void _addMedication(Medication medication) {
//     setState(() {
//       _medications.add(medication);
//       _selectedEvents.value = _getEventsForDay(_selectedDay!);
//     });
//   }

//   void _deleteMedication(Medication medication) {
//     setState(() {
//       _medications.remove(medication);
//       _selectedEvents.value = _getEventsForDay(_selectedDay!);
//     });
//   }

//   LinkedHashMap<DateTime, List<Medication>> get _events {
//     final events = LinkedHashMap<DateTime, List<Medication>>(
//       equals: isSameDay,
//       hashCode: (key) => key.day * 1000000 + key.month * 10000 + key.year,
//     );

//     for (var medication in _medications) {
//       final date = medication.date;
//       if (events[date] == null) {
//         events[date] = [];
//       }
//       events[date]!.add(medication);
//     }

//     return events;
//   }

//   List<Medication> _getEventsForDay(DateTime day) {
//     return _events[day] ?? [];
//   }

//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       setState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//         _isCalendarVisible = false;
//       });
//       _selectedEvents.value = _getEventsForDay(selectedDay);
//     }
//   }

//   void _onItemTapped(int index) {
//     if (_selectedIndex == index) return;

//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const FAQScreen()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomeScreen()),
//         );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const SettingsScreen()),
//         );
//         break;
//       default:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomeScreen()),
//         );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);

//     // Determine the title based on the selected day
//     final String title;
//     if (isSameDay(_selectedDay, DateTime.now())) {
//       title = appTexts.today;
//     } else {
//       title = DateFormat('EEEE, d MMM').format(_selectedDay!);
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           title,
//           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.calendar_today_outlined, color: Colors.white),
//             onPressed: () {
//               setState(() {
//                 _isCalendarVisible = !_isCalendarVisible;
//               });
//             },
//           ),
//         ],
//         backgroundColor: const Color.fromARGB(255, 121, 26, 139),
//         automaticallyImplyLeading: false,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Stack(
//             children: [
//               Column(
//                 children: [
//                   _buildWeekCalendar(constraints),
//                   const SizedBox(height: 20),
//                   Expanded(child: _buildMedicationList(constraints)),
//                 ],
//               ),
//               if (_isCalendarVisible)
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   child: _buildCalendar(constraints),
//                 ),
//             ],
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CreateAlertScreen(
//                 onAddMedication: _addMedication,
//                 selectedDate: _selectedDay!,
//               ),
//             ),
//           );
//         },
//         label: Text(
//           appTexts.addMedicine,
//           style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 18),
//         ),
//         backgroundColor: theme.colorScheme.primary,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }

//   Widget _buildWeekCalendar(BoxConstraints constraints) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final dayLabelFontSize = isTablet ? 16.0 : 12.0;
//     final dateLabelFontSize = isTablet ? 18.0 : 16.0;

//     return Container(
//       color: theme.cardColor,
//       height: 80,
//       child: PageView.builder(
//         controller: _pageController,
//         onPageChanged: (page) {
//           setState(() {
//             _focusedDay = DateTime.now().add(Duration(days: page * 7));
//           });
//         },
//         itemBuilder: (context, pageIndex) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(7, (dayIndex) {
//               final day = _focusedDay.add(
//                 Duration(days: dayIndex - (_focusedDay.weekday % 7)),
//               );
//               final isSelected = isSameDay(_selectedDay, day);

//               return GestureDetector(
//                 onTap: () => _onDaySelected(day, day),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       [
//                         appTexts.sun,
//                         appTexts.mon,
//                         appTexts.tue,
//                         appTexts.wed,
//                         appTexts.thu,
//                         appTexts.fri,
//                         appTexts.sat,
//                       ][day.weekday % 7],
//                       style: TextStyle(
//                         color: isSelected
//                             ? theme.colorScheme.primary
//                             : theme.colorScheme.onSurface.withAlpha(178),
//                         fontWeight: isSelected
//                             ? FontWeight.bold
//                             : FontWeight.normal,
//                         fontSize: dayLabelFontSize,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: isSelected
//                             ? theme.colorScheme.primary
//                             : Colors.transparent,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: Text(
//                           '${day.day}',
//                           style: TextStyle(
//                             color: isSelected
//                                 ? theme.colorScheme.onPrimary
//                                 : theme.textTheme.bodyLarge?.color,
//                             fontWeight: FontWeight.bold,
//                             fontSize: dateLabelFontSize,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCalendar(BoxConstraints constraints) {
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final dayFontSize = isTablet ? 18.0 : 14.0;
//     final titleFontSize = isTablet ? 22.0 : 18.0;

//     return Container(
//       color: theme.cardColor,
//       child: TableCalendar(
//         firstDay: DateTime.utc(2020, 1, 1),
//         lastDay: DateTime.utc(2030, 12, 31),
//         focusedDay: _focusedDay,
//         selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//         onDaySelected: _onDaySelected,
//         eventLoader: _getEventsForDay,
//         calendarStyle: CalendarStyle(
//           todayDecoration: BoxDecoration(
//             color: theme.colorScheme.primary.withAlpha(128),
//             shape: BoxShape.circle,
//           ),
//           selectedDecoration: BoxDecoration(
//             color: theme.colorScheme.primary,
//             shape: BoxShape.circle,
//           ),
//           markersMaxCount: 1,
//           markerDecoration: BoxDecoration(
//             color: theme.colorScheme.error,
//             shape: BoxShape.circle,
//           ),
//           defaultTextStyle: TextStyle(fontSize: dayFontSize),
//           weekendTextStyle: TextStyle(
//             fontSize: dayFontSize,
//             color: theme.colorScheme.error,
//           ),
//           outsideTextStyle: TextStyle(
//             fontSize: dayFontSize,
//             color: theme.hintColor,
//           ),
//         ),
//         headerStyle: HeaderStyle(
//           titleCentered: true,
//           formatButtonVisible: false,
//           titleTextStyle: TextStyle(
//             fontSize: titleFontSize,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMedicationList(BoxConstraints constraints) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final emptyListIconSize = isTablet ? 120.0 : 100.0;
//     final emptyListTitleSize = isTablet ? 26.0 : 22.0;
//     final emptyListSubtitleSize = isTablet ? 18.0 : 16.0;

//     return ValueListenableBuilder<List<Medication>>(
//       valueListenable: _selectedEvents,
//       builder: (context, value, _) {
//         if (value.isEmpty) {
//           return Container(
//             alignment: const Alignment(0.0, -0.6),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.notifications_none,
//                   size: emptyListIconSize,
//                   color: theme.disabledColor,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   appTexts.noReminder,
//                   style: TextStyle(
//                     fontSize: emptyListTitleSize,
//                     fontWeight: FontWeight.bold,
//                     color: theme.textTheme.bodyLarge?.color,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   appTexts.noMedicationScheduleForToday,
//                   style: TextStyle(
//                     fontSize: emptyListSubtitleSize,
//                     color: theme.hintColor,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         return ListView.builder(
//           itemCount: value.length,
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           itemBuilder: (context, index) {
//             final medication = value[index];
//             return _buildMedicationItem(medication, constraints, () => _deleteMedication(medication));
//           },
//         );
//       },
//     );
//   }

//   Widget _buildMedicationItem(
//     Medication medication,
//     BoxConstraints constraints,
//     VoidCallback onDelete,
//   ) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final itemFontSize = isTablet ? 18.0 : 16.0;
//     final timeFontSize = isTablet ? 16.0 : 14.0;
//     final imageSize = isTablet ? 50.0 : 40.0;

//     Color statusColor;
//     String statusText;

//     switch (medication.status) {
//       case MedicationStatus.missed:
//         statusColor = theme.colorScheme.error;
//         statusText = appTexts.missed;
//         break;
//       case MedicationStatus.upcoming:
//         statusColor = theme.colorScheme.secondary;
//         statusText = appTexts.upcoming;
//         break;
//       case MedicationStatus.taken:
//         statusColor = theme.colorScheme.primary;
//         statusText = appTexts.taken;
//         break;
//     }

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       elevation: 2,
//       shadowColor: theme.shadowColor.withAlpha(26),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             Image.asset(
//               medication.imagePath,
//               width: imageSize,
//               height: imageSize,
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     medication.name,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: itemFontSize,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${medication.dosage} - ${medication.time}',
//                     style: TextStyle(
//                       color: theme.hintColor,
//                       fontSize: timeFontSize,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 16),
//             Row(
//               children: [
//                 Container(
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     color: statusColor,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 Text(
//                   statusText,
//                   style: TextStyle(
//                     color: statusColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete, color: Colors.red),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
