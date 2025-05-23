import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final String? displayName;
  final String? photoUrl;
  final String? lpkName;

  const EditProfilePage({
    super.key,
    this.displayName,
    this.photoUrl,
    this.lpkName,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _lpkController;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.displayName ?? '');
    _lpkController = TextEditingController(text: widget.lpkName ?? '');
    _photoUrl = widget.photoUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lpkController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(_nameController.text);
    // Untuk update photoUrl dan nama LPK, Anda bisa simpan ke Firestore jika perlu
    if (mounted) {
      Navigator.pop(context, {
        'displayName': _nameController.text,
        'photoUrl': _photoUrl,
        'lpkName': _lpkController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final picker = ImagePicker();
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() {
                    _photoUrl = picked.path; // Sementara pakai path lokal
                  });
                  // TODO: Upload ke Firebase Storage jika ingin simpan online
                }
              },
              child: CircleAvatar(
                radius: 40,
                backgroundImage: _photoUrl != null && _photoUrl!.isNotEmpty
                    ? (_photoUrl!.startsWith('http')
                        ? NetworkImage(_photoUrl!)
                        : FileImage(File(_photoUrl!)) as ImageProvider)
                    : null,
                child: _photoUrl == null || _photoUrl!.isEmpty
                    ? const Icon(Icons.person, size: 40)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lpkController,
              decoration: const InputDecoration(labelText: 'Nama LPK'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}