// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:hotels/GTX/Models/GuestModel.dart';

// class GuestFormWidget extends StatefulWidget {
//   final void Function(GuestModel) onGuestAdded;

//   const GuestFormWidget({Key? key, required this.onGuestAdded}) : super(key: key);

//   @override
//   State<GuestFormWidget> createState() => _GuestFormWidgetState();
// }

// class _GuestFormWidgetState extends State<GuestFormWidget> {
//   final _formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   String? gender;
//   int? ageFrom;
//   int? ageTo;
//   File? idCardImage;

//   Future<void> _pickImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         idCardImage = File(picked.path);
//       });
//     }
//   }

//   void _submitGuest() {
//     if (_formKey.currentState!.validate() && gender != null && idCardImage != null && ageFrom != null && ageTo != null) {
//       final guest = GuestModel(
//         name: nameController.text,
//         phone: phoneController.text,
//         gender: gender!,
//         ageFrom: ageFrom!,
//         ageTo: ageTo!,
//         idCardImage: idCardImage!,
//       );
//       widget.onGuestAdded(guest);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تمت إضافة الضيف')));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى تعبئة جميع الحقول')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'الاسم'),
//                 validator: (value) => value!.isEmpty ? 'أدخل الاسم' : null,
//               ),
//               TextFormField(
//                 controller: phoneController,
//                 decoration: const InputDecoration(labelText: 'رقم الهاتف'),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) => value!.isEmpty ? 'أدخل رقم الهاتف' : null,
//               ),
//               DropdownButtonFormField<String>(
//                 value: gender,
//                 items: const [
//                   DropdownMenuItem(value: 'male', child: Text('ذكر')),
//                   DropdownMenuItem(value: 'female', child: Text('أنثى')),
//                 ],
//                 onChanged: (val) => setState(() => gender = val),
//                 decoration: const InputDecoration(labelText: 'الجنس'),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButtonFormField<int>(
//                       value: ageFrom,
//                       items: List.generate(80, (i) => i + 1).map((e) => DropdownMenuItem(value: e, child: Text('$e'))).toList(),
//                       onChanged: (val) => setState(() => ageFrom = val),
//                       decoration: const InputDecoration(labelText: 'العمر من'),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: DropdownButtonFormField<int>(
//                       value: ageTo,
//                       items: List.generate(80, (i) => i + 1).map((e) => DropdownMenuItem(value: e, child: Text('$e'))).toList(),
//                       onChanged: (val) => setState(() => ageTo = val),
//                       decoration: const InputDecoration(labelText: 'إلى'),
//                     ),
//                   ),
//                 ],
//               ),
//               ElevatedButton.icon(
//                 onPressed: _pickImage,
//                 icon: const Icon(Icons.image),
//                 label: const Text('صورة الهوية'),
//               ),
//               if (idCardImage != null) Image.file(idCardImage!, height: 80),
//               ElevatedButton(
//                 onPressed: _submitGuest,
//                 child: const Text('إضافة هذا الضيف'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
