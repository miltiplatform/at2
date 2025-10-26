import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'produit.dart';
import 'add_produit_form.dart';

class AddProduitFormState extends State<AddProduitForm> {
  final _formKey = GlobalKey<FormState>();
  final _produit = Produit.empty();
  String? _pickedImagePath;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      _pickedImagePath = pickedFile.path;
      _produit.photo = _pickedImagePath;
    });
  }

  void _saveProduit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _produit.id = DateTime.now().millisecondsSinceEpoch.toString();
      _produit.photo = _pickedImagePath;
      widget.onSubmit(_produit);
      Navigator.pop(context);
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Ajouter un produit')),
    body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Libellé
            TextFormField(
              decoration: const InputDecoration(labelText: 'Libellé'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Champ requis' : null,
              onSaved: (value) => _produit.libelle = value,
            ),
            // Description
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Champ requis' : null,
              onSaved: (value) => _produit.description = value,
            ),
            // Prix
            TextFormField(
              decoration: const InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Champ requis' : null,
              onSaved: (value) =>
                  _produit.prix = double.tryParse(value ?? '0') ?? 0.0,
            ),
            const SizedBox(height: 16),
            // Image Picker
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    color: Theme.of(context).primaryColorLight,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _pickedImagePath != null
                          ? FileImage(File(_pickedImagePath!))
                          : const AssetImage('assets/images/placeholder.png') as ImageProvider,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    setState(() { _pickedImagePath = null; });
                  },
                  icon: const Icon(Icons.restore_from_trash_rounded),
                  label: const Text('Réinitialiser'),
                ),
                ElevatedButton(
                  onPressed: _saveProduit,
                  child: const Text('Enregistrer'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}}
