import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kampusunden/utils.dart';
import '../providers/listing_provider.dart';
import '../providers/auth_provider.dart';
import '../models/listing_model.dart';

class CreateListingApp extends StatefulWidget {
  const CreateListingApp({super.key});

  @override
  State<CreateListingApp> createState() => _CreateListingAppState();
}

class _CreateListingAppState extends State<CreateListingApp> {
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  
  XFile? _selectedImage;
  Uint8List? _imageBytes;
  bool _isUploading = false;
  bool _isWanted = false;
  String _selectedCategory = 'Electronics';
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _brandController.dispose();
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) {
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        setState(() {
          _selectedImage = image;
          _imageBytes = bytes;
        });
      } else {
        setState(() {
          _selectedImage = image;
          _imageBytes = null;
        });
      }
    }
  }

  Future<String> _uploadImage() async {
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference ref = FirebaseStorage.instance.ref().child('listing_images').child('$fileName.jpg');
      
      UploadTask uploadTask;
      if (kIsWeb && _imageBytes != null) {
        uploadTask = ref.putData(_imageBytes!, SettableMetadata(contentType: 'image/jpeg'));
      } else {
        uploadTask = ref.putFile(File(_selectedImage!.path));
      }
      
      final TaskSnapshot snapshot = await uploadTask;
      
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Create Listing',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isWanted = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: !_isWanted ? AppUtils.appBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('📦'),
                            const SizedBox(width: 8),
                            Text(
                              'For Sale',
                              style: TextStyle(color: !_isWanted ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isWanted = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: _isWanted ? AppUtils.appBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('🙏'),
                            const SizedBox(width: 8),
                            Text(
                              'Wanted',
                              style: TextStyle(color: _isWanted ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        image: _selectedImage != null 
                            ? (kIsWeb && _imageBytes != null 
                                ? DecorationImage(image: MemoryImage(_imageBytes!), fit: BoxFit.cover)
                                : DecorationImage(image: FileImage(File(_selectedImage!.path)), fit: BoxFit.cover))
                            : null,
                      ),
                      child: _selectedImage == null ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 28, color: Colors.grey),
                          SizedBox(height: 4),
                          Text('Add Image', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ) : null,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text('Category:', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _selectedCategory = 'Books'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: _selectedCategory == 'Books' ? AppUtils.appBlue : Colors.grey.shade300, width: _selectedCategory == 'Books' ? 2 : 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(children: [const Text('📚'), const SizedBox(width: 4), Text('Books', style: AppUtils.product_card_title,)]),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => setState(() => _selectedCategory = 'Electronics'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: _selectedCategory == 'Electronics' ? AppUtils.appBlue : Colors.grey.shade300, width: _selectedCategory == 'Electronics' ? 2 : 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(children: [const Text('💻'), const SizedBox(width: 4), Text('Electronics', style: AppUtils.product_card_title)]),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => setState(() => _selectedCategory = 'Furniture'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: _selectedCategory == 'Furniture' ? AppUtils.appBlue : Colors.grey.shade300, width: _selectedCategory == 'Furniture' ? 2 : 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(children: [const Text('🪑'), const SizedBox(width: 4), Text('Furniture', style: AppUtils.product_card_title)]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Brand:', style: AppUtils.headerStyle),
                  TextField(controller: _brandController, decoration: const InputDecoration(hintText: 'Enter brand name')),
                  const SizedBox(height: 16),
                  const Text('Description:', style: AppUtils.headerStyle),
                  TextField(controller: _titleController, decoration: const InputDecoration(hintText: 'Enter product description')),
                  const SizedBox(height: 16),
                  const Text('Price:', style: AppUtils.headerStyle),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(hintText: 'Enter price ₺'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          child: GestureDetector(
            onTap: _isUploading ? null : () async {
              if (_titleController.text.isEmpty || _priceController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter title and price')));
                return;
              }
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              final user = authProvider.user;
              if (user == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Not logged in')));
                return;
              }
              
              setState(() {
                _isUploading = true;
              });

              try {
                String uploadedImageUrl = "https://via.placeholder.com/150"; // default fallback
                if (_selectedImage != null) {
                  uploadedImageUrl = await _uploadImage();
                }

                final newListing = ListingModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: _titleController.text.trim(),
                  price: _priceController.text.trim(),
                  imageUrl: uploadedImageUrl,
                  category: _selectedCategory,
                  brand: _brandController.text.trim(),
                  createdBy: user.uid,
                  createdAt: DateTime.now(),
                  isWanted: _isWanted,
                );
                
                await Provider.of<ListingProvider>(context, listen: false).addListing(newListing);
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Listing added successfully')));
                _titleController.clear();
                _priceController.clear();
                _brandController.clear();
                setState(() {
                  _selectedImage = null;
                  _imageBytes = null;
                });
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              } finally {
                if (mounted) {
                  setState(() {
                    _isUploading = false;
                  });
                }
              }
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: _isUploading ? Colors.grey : AppUtils.appBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: _isUploading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Go Live',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
              ),
            ),
          ),
        ),
      );
  }
}