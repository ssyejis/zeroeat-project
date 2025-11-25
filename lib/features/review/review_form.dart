import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeroeat/config/routes.dart';


class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  int _currentRating = 0;
  final List<XFile> _images = [];

  void _updateRating(int rating) {
    setState(() {
      _currentRating = rating;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('카메라로 촬영'),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6EC),
        title: const Text(
          '리뷰 작성',
          style: TextStyle(
            color: Color(0xFF3E2F1C),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E2F1C)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 5; i++)
                  IconButton(
                    onPressed: () => _updateRating(i + 1),
                    icon: Icon(
                      i < _currentRating ? Icons.star : Icons.star_border,
                      color: Color(0xFFF4A261),
                      size: 40,
                    ),
                  )
                ],
              ),
              const Text(
                '제품에 대한 솔직한 평가를 남겨주세요!'
              ),
              const SizedBox(height: 16),
              
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _showImageSourceSheet,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7EFE3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.camera_alt, color: Color(0xFF3E2F1C)),
                      ),
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _images.map((img) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Stack(
                                children: [
                                  kIsWeb
                                      ? Image.network(
                                          img.path,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(img.path),
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _images.remove(img);
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(2),
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                maxLines: 7,
                maxLength: 500,
                cursorColor: Color.fromARGB(255, 31, 31, 31),
                decoration: const InputDecoration(
                  hintText: '리뷰를 작성해주세요.',
                  hintStyle: TextStyle(
                    color: Color(0xFFBDBDBD),
                    fontWeight: FontWeight.normal
                  ),
                  filled: true,
                  fillColor: Color(0xFFF7EFE3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: TextStyle(color: Colors.red)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || _currentRating == 0) {
                    return '별점 선택 및 리뷰를 작성해주세요.';
                  }
                  return null;
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                 
                  if (!isValid || _currentRating == 0) {return;}

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('리뷰 작성을 완료하였습니다.'),
                        duration: Duration(seconds: 2)
                      )
                    );

                    Navigator.of(context).pop(true);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3E2F1C),
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )
                ),
                child: const Text(
                  '제출',
                ),
              )
            ],
          )
        )
        
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}