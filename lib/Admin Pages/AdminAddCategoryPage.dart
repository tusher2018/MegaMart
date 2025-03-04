// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     home: AdminAddCategoryPage(),
//   ));
// }

// class AdminAddCategoryPage extends StatefulWidget {
//   const AdminAddCategoryPage({super.key});

//   @override
//   _AdminAddCategoryPageState createState() => _AdminAddCategoryPageState();
// }

// class _AdminAddCategoryPageState extends State<AdminAddCategoryPage> {
//   final _categoryNameController = TextEditingController();
//   final List<Map<String, dynamic>> _items = [];

//   final _itemNameController = TextEditingController();
//   final _itemPriceController = TextEditingController();
//   final _itemDescriptionController = TextEditingController();
//   List<File> _itemImages = [];
//   final picker = ImagePicker();

//   Future<void> _pickImages() async {
//     final pickedFiles = await picker.pickMultiImage();
//     setState(() {
//       _itemImages =
//           pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
//     });
//   }

//   Future<List<String>> _uploadImages() async {
//     List<String> imageUrls = [];
//     for (File image in _itemImages) {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference storageReference =
//           FirebaseStorage.instance.ref().child('products/$fileName');
//       UploadTask uploadTask = storageReference.putFile(image);
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//       imageUrls.add(downloadUrl);
//     }
//     return imageUrls;
//   }

//   void _addItem() async {
//     List<String> imageUrls = await _uploadImages();

//     setState(() {
//       _items.add({
//         'name': _itemNameController.text,
//         'price': _itemPriceController.text,
//         'description': _itemDescriptionController.text,
//         'imageUrls': imageUrls,
//       });

//       _itemNameController.clear();
//       _itemPriceController.clear();
//       _itemDescriptionController.clear();
//       _itemImages.clear();
//     });
//   }

//   void _saveCategory() {
//     String categoryName = _categoryNameController.text;
//     // Here you would normally save the category and items to your backend or database.
//     print('Category: $categoryName');
//     print('Items: $_items');

//     // Clear everything after saving
//     _categoryNameController.clear();
//     setState(() {
//       _items.clear();
//     });

//     // Display a confirmation
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Category saved successfully!')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Category'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _categoryNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Category Name',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               _buildAddItemForm(),
//               const SizedBox(height: 16),
//               const SizedBox(height: 16),
//               const Text(
//                 'Items',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: _items.length,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Card(
//                     elevation: 3,
//                     child: ListTile(
//                       leading: _items[index]['imageUrls'] != null &&
//                               _items[index]['imageUrls'].isNotEmpty
//                           ? Image.network(
//                               _items[index]['imageUrls'][0],
//                               width: 50,
//                               height: 50,
//                               fit: BoxFit.cover,
//                             )
//                           : const Icon(Icons.image),
//                       title: Text(_items[index]['name']),
//                       subtitle: Text(
//                           '${_items[index]['price']} - ${_items[index]['description']}'),
//                     ),
//                   );
//                 },
//               ),
//               Center(
//                 child: CustomWidgets.elevatedButtonCustom(
//                   onPressedButton: _saveCategory,
//                   hintText: 'Save Category',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAddItemForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           controller: _itemNameController,
//           decoration: InputDecoration(
//             labelText: 'Item Name',
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: _itemPriceController,
//           decoration: InputDecoration(
//             labelText: 'Item Price',
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//           keyboardType: TextInputType.number,
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: _itemDescriptionController,
//           keyboardType: TextInputType.multiline,
//           minLines: 5,
//           maxLines: 5,
//           decoration: InputDecoration(
//             labelText: 'Item Description',
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//         const SizedBox(height: 8),
//         ElevatedButton(
//           onPressed: _pickImages,
//           child: const Text('Pick Images'),
//         ),
//         const SizedBox(height: 8),
//         _itemImages.isNotEmpty
//             ? Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: _itemImages.map((image) {
//                   return Image.file(
//                     image,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   );
//                 }).toList(),
//               )
//             : const Text('No images selected'),
//         const SizedBox(height: 8),
//         ElevatedButton(
//           onPressed: _addItem,
//           child: const Text('Add Item'),
//         ),
//       ],
//     );
//   }
// }
