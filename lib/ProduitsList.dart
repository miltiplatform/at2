import 'package:flutter/material.dart';
import 'produit.dart';
import 'produitBox.dart';
import 'add_produit_form.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  final List<Produit> _produits = [];
  final List<bool> _selectedFlags = [];

  // Add a new product
  void _addProduit(Produit produit) {
    setState(() {
      _produits.add(produit);
      _selectedFlags.add(false);
    });
  }

  // Delete product at index
  void _deleteProduit(int index) {
    setState(() {
      _produits.removeAt(index);
      _selectedFlags.removeAt(index);
    });
  }

  // Toggle selected state
  void _toggleSelection(bool? value, int index) {
    setState(() {
      _selectedFlags[index] = value ?? false;
    });
  }

  // Delete all selected products
  void _deleteSelected() {
    setState(() {
      for (int i = _produits.length - 1; i >= 0; i--) {
        if (_selectedFlags[i]) {
          _produits.removeAt(i);
          _selectedFlags.removeAt(i);
        }
      }
    });
  }

  // Show form to add a new product
  void _showAddForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProduitForm(onSubmit: _addProduit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Produits'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: "Supprimer les produits sélectionnés",
            onPressed: _deleteSelected,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddForm,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: _produits.isEmpty
          ? const Center(child: Text('Aucun produit ajouté'))
          : ListView.builder(
              itemCount: _produits.length,
              itemBuilder: (context, index) {
                final produit = _produits[index];
                return ProduitBox(
                  produit: produit,
                  selProduit: _selectedFlags[index],
                  onChanged: (value) => _toggleSelection(value, index),
                  delProduit: () => _deleteProduit(index),
                );
              },
            ),
    );
  }
}
