// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:intl/intl.dart';
// import 'package:myapp/main.dart';
// import 'package:myapp/models/medication.dart';
// import 'package:myapp/screens/faq_screen.dart';
// import 'package:myapp/screens/home_screen.dart';
// import 'package:myapp/screens/settings_screen.dart';
// import 'package:myapp/text.dart';
// import 'package:myapp/widgets/bottom_nav_bar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// enum FrequencyType { daily, weekly }

// class MedicationType {
//   final String name;
//   final IconData icon;
//   final String imagePath;

//   MedicationType({
//     required this.name,
//     required this.icon,
//     required this.imagePath,
//   });
// }

// class CreateAlertScreen extends StatefulWidget {
//   final Function(Medication) onAddMedication;
//   final DateTime selectedDate;
//   const CreateAlertScreen({
//     super.key,
//     required this.onAddMedication,
//     required this.selectedDate,
//   });

//   @override
//   State<CreateAlertScreen> createState() => _CreateAlertScreenState();
// }

// class _CreateAlertScreenState extends State<CreateAlertScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   TimeOfDay _selectedTime = TimeOfDay.now();
//   DateTime _startDate = DateTime.now();
//   late MedicationType _selectedMedicationType;
//   int _quantity = 1;
//   FrequencyType _selectedFrequency = FrequencyType.daily;
//   final List<bool> _selectedWeekdays = List.filled(7, false);
//   int _selectedIndex = 1; // Default to reminder screen

//   late List<MedicationType> _medicationTypes;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final appTexts = AppTexts.of(context);
//     _medicationTypes = [
//       MedicationType(
//         name: appTexts.tablet,
//         icon: Icons.tablet,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.capsule,
//         icon: BoxIcons.bxs_capsule,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.liquid,
//         icon: Icons.science_outlined,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.lotion,
//         icon: Bootstrap.droplet,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.spray,
//         icon: BoxIcons.bxs_spray_can,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.ointment,
//         icon: BoxIcons.bxs_vial,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.drops,
//         icon: Bootstrap.eyedropper,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.gel,
//         icon: LineAwesome.tint_solid,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.suppository,
//         icon: BoxIcons.bxs_capsule,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.injection,
//         icon: BoxIcons.bxs_injection,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.cream,
//         icon: Icons.medication,
//         imagePath: 'assets/images/Health.png',
//       ),
//       MedicationType(
//         name: appTexts.powder,
//         icon: Icons.blur_on,
//         imagePath: 'assets/images/Health.png',
//       ),
//     ];
//     _selectedMedicationType = _medicationTypes[0];
//   }

//   @override
//   void initState() {
//     super.initState();
//     _startDate = widget.selectedDate;
//   }

//   Future<void> _saveMedications(List<Medication> medications) async {
//     final prefs = await SharedPreferences.getInstance();
//     final existingContent = prefs.getString('medications');
//     final List<dynamic> existingMedications = existingContent != null
//         ? jsonDecode(existingContent)
//         : [];
//     final newMedications = medications.map((med) => med.toJson()).toList();
//     existingMedications.addAll(newMedications);
//     await prefs.setString('medications', jsonEncode(existingMedications));
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
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           appTexts.addMedication,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: const Color.fromARGB(255, 121, 26, 139),
//         automaticallyImplyLeading: false,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: ListView(
//                 children: [
//                   _buildTextField(
//                     appTexts.medicationName,
//                     _nameController,
//                     appTexts.medicationName,
//                     constraints,
//                   ),
//                   const SizedBox(height: 20),
//                   _buildMedicationTypeSelector(constraints),
//                   const SizedBox(height: 20),
//                   _buildDatePicker(
//                     appTexts.date,
//                     _startDate,
//                     () => _pickDate(true),
//                     constraints,
//                   ),
//                   const SizedBox(height: 20),
//                   _buildQuantityRow(constraints),
//                   const SizedBox(height: 20),
//                   _buildFrequencySelector(constraints),
//                   const SizedBox(height: 20),
//                   _buildTimePicker(constraints),
//                   const SizedBox(height: 40),
//                   _buildActionButtons(constraints),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }

//   Widget _buildTextField(
//     String label,
//     TextEditingController controller,
//     String hint,
//     BoxConstraints constraints,
//   ) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final titleFontSize = isTablet ? 20.0 : 16.0;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//             fontSize: titleFontSize,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: hint,
//             filled: true,
//             fillColor: theme.colorScheme.surfaceContainerHighest,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: theme.colorScheme.outline),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: theme.colorScheme.primary),
//             ),
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return '${appTexts.pleaseEnterA} $label';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildMedicationTypeSelector(BoxConstraints constraints) {
//     final theme = Theme.of(context);
//     final appTexts = AppTexts.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final titleFontSize = isTablet ? 20.0 : 16.0;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           appTexts.medicationType,
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//             fontSize: titleFontSize,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: theme.colorScheme.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: theme.colorScheme.outline),
//           ),
//           child: ListTile(
//             title: Text(_selectedMedicationType.name),
//             trailing: const Icon(Icons.arrow_drop_down),
//             onTap: () => _showMedicationTypeSheet(constraints),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showMedicationTypeSheet(BoxConstraints constraints) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final titleFontSize = isTablet ? 24.0 : 20.0;
//     final iconSize = isTablet ? 50.0 : 40.0;
//     final crossAxisCount = isTablet ? 4 : 3;

//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     appTexts.selectMedication,
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontSize: titleFontSize,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: crossAxisCount,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                   ),
//                   itemCount: _medicationTypes.length,
//                   itemBuilder: (context, index) {
//                     final type = _medicationTypes[index];
//                     final isSelected =
//                         type.name == _selectedMedicationType.name;
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedMedicationType = type;
//                         });
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? theme.colorScheme.primaryContainer
//                               : theme.colorScheme.surface,
//                           borderRadius: BorderRadius.circular(10),
//                           border: isSelected
//                               ? Border.all(
//                                   color: theme.colorScheme.primary,
//                                   width: 2,
//                                 )
//                               : Border.all(color: theme.colorScheme.outline),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               type.icon,
//                               size: iconSize,
//                               color: isSelected
//                                   ? theme.colorScheme.primary
//                                   : theme.colorScheme.onSurface,
//                             ),
//                             const SizedBox(height: 8),
//                             Text(type.name, textAlign: TextAlign.center),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDatePicker(
//     String label,
//     DateTime date,
//     VoidCallback onTap,
//     BoxConstraints constraints,
//   ) {
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final titleFontSize = isTablet ? 20.0 : 16.0;
//     final bodyFontSize = isTablet ? 18.0 : 16.0;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//             fontSize: titleFontSize,
//           ),
//         ),
//         const SizedBox(height: 8),
//         InkWell(
//           onTap: onTap,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//             decoration: BoxDecoration(
//               color: theme.colorScheme.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: theme.colorScheme.outline),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   DateFormat('MMM dd, yyyy').format(date),
//                   style: theme.textTheme.bodyLarge?.copyWith(
//                     fontSize: bodyFontSize,
//                   ),
//                 ),
//                 Icon(Icons.calendar_today, color: theme.colorScheme.primary),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildQuantityRow(BoxConstraints constraints) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final titleFontSize = isTablet ? 20.0 : 16.0;
//     final quantityFontSize = isTablet ? 22.0 : 18.0;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           appTexts.quantity,
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//             fontSize: titleFontSize,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 60,
//           decoration: BoxDecoration(
//             color: theme.colorScheme.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: theme.colorScheme.outline),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 appTexts.quantity,
//                 style: theme.textTheme.bodyLarge?.copyWith(
//                   fontSize: titleFontSize,
//                 ),
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.remove),
//                     onPressed: () {
//                       setState(() {
//                         if (_quantity > 1) {
//                           _quantity--;
//                         }
//                       });
//                     },
//                   ),
//                   Text(
//                     '$_quantity'.padLeft(2, '0'),
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontSize: quantityFontSize,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.add),
//                     onPressed: () {
//                       setState(() {
//                         _quantity++;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFrequencySelector(BoxConstraints constraints) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final titleFontSize = isTablet ? 20.0 : 16.0;
//     final buttonPadding = isTablet ? 24.0 : 16.0;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           appTexts.setFrequency,
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//             fontSize: titleFontSize,
//           ),
//         ),
//         const SizedBox(height: 8),
//         ToggleButtons(
//           isSelected: [
//             _selectedFrequency == FrequencyType.daily,
//             _selectedFrequency == FrequencyType.weekly,
//           ],
//           onPressed: (index) {
//             setState(() {
//               if (index == 0) {
//                 _selectedFrequency = FrequencyType.daily;
//               } else if (index == 1) {
//                 _selectedFrequency = FrequencyType.weekly;
//               }
//             });
//           },
//           borderRadius: BorderRadius.circular(10),
//           selectedColor: Colors.white,
//           fillColor: theme.colorScheme.primary,
//           color: theme.colorScheme.onSurface,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: buttonPadding),
//               child: Text(appTexts.daily),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: buttonPadding),
//               child: Text(appTexts.weekly),
//             ),
//           ],
//         ),
//         if (_selectedFrequency == FrequencyType.weekly)
//           const SizedBox(height: 16),
//         if (_selectedFrequency == FrequencyType.weekly)
//           _buildWeekdaySelector(constraints),
//       ],
//     );
//   }

//   Widget _buildWeekdaySelector(BoxConstraints constraints) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final itemSize = isTablet ? 50.0 : 40.0;
//     final weekdays = [
//       appTexts.M,
//       appTexts.T,
//       appTexts.W,
//       appTexts.T,
//       appTexts.F,
//       appTexts.S,
//       appTexts.S,
//     ];
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(7, (index) {
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedWeekdays[index] = !_selectedWeekdays[index];
//               });
//             },
//             child: Container(
//               width: itemSize,
//               height: itemSize,
//               decoration: BoxDecoration(
//                 color: _selectedWeekdays[index]
//                     ? theme.colorScheme.primary
//                     : theme.colorScheme.surfaceContainerHighest,
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Text(
//                   weekdays[index],
//                   style: TextStyle(
//                     color: _selectedWeekdays[index]
//                         ? theme.colorScheme.onPrimary
//                         : theme.colorScheme.onSurface,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildTimePicker(BoxConstraints constraints) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final titleFontSize = isTablet ? 18.0 : 16.0;

//     return Container(
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: theme.colorScheme.outline),
//       ),
//       child: ListTile(
//         title: Text(
//           appTexts.scheduleTime,
//           style: TextStyle(fontSize: titleFontSize),
//         ),
//         trailing: InkWell(
//           onTap: _pickTime,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.access_time, color: theme.colorScheme.secondary),
//               const SizedBox(width: 8),
//               Text(
//                 _selectedTime.format(context),
//                 style: TextStyle(
//                   color: theme.colorScheme.secondary,
//                   fontSize: titleFontSize,
//                 ),
//               ),
//               Icon(Icons.arrow_drop_down, color: theme.colorScheme.secondary),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButtons(BoxConstraints constraints) {
//     final appTexts = AppTexts.of(context);
//     final theme = Theme.of(context);
//     final isTablet = constraints.maxWidth > 600;
//     final buttonHeight = isTablet ? 60.0 : 50.0;
//     final buttonFontSize = isTablet ? 20.0 : 16.0;

//     return Row(
//       children: [
//         Expanded(
//           child: ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               minimumSize: Size(double.infinity, buttonHeight),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: Text(
//               appTexts.cancel,
//               style: theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: buttonFontSize,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//           child: ElevatedButton(
//             onPressed: _saveMedication,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: theme.colorScheme.primary,
//               minimumSize: Size(double.infinity, buttonHeight),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: Text(
//               appTexts.done,
//               style: theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: theme.colorScheme.onPrimary,
//                 fontSize: buttonFontSize,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _pickDate(bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _startDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null) {
//       setState(() {
//         _startDate = picked;
//       });
//     }
//   }

//   Future<void> _pickTime() async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//     );
//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked;
//       });
//     }
//   }

//   void _saveMedication() async {
//     final appTexts = AppTexts.of(context);

//     if (_formKey.currentState!.validate()) {
//       List<Medication> newMedications = [];

//       final newMedication = Medication(
//         name: _nameController.text,
//         dosage: '$_quantity',
//         time: _selectedTime.format(context),
//         status: MedicationStatus.upcoming,
//         imagePath: _selectedMedicationType.imagePath,
//         date: _startDate,
//       );
//       newMedications.add(newMedication);
//       widget.onAddMedication(newMedication);

//       final scheduledDate = DateTime(
//         _startDate.year,
//         _startDate.month,
//         _startDate.day,
//         _selectedTime.hour,
//         _selectedTime.minute,
//       );

//       notificationService.scheduleNotification(
//         id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
//         title: appTexts.medicationReminder,
//         body: "${appTexts.itsTimeToTakeYour} ${_nameController.text}.",
//         scheduledDate: scheduledDate,
//       );

//       await _saveMedications(newMedications);
//       if (!mounted) return;
//       Navigator.pop(context);
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }
// }
