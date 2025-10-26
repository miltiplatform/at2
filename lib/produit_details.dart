import 'dart:io';
import 'package:flutter/material.dart';
import 'produit.dart';

class ProduitDetails extends StatelessWidget {
  final Produit produit;

  const ProduitDetails({super.key, required this.produit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          produit.libelle ?? 'Produit',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image
              if (produit.photo != null && produit.photo!.isNotEmpty)
                Image.file(
                  File(produit.photo!),
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                )
              else
                Image.asset(
                  'assets/images/placeholder.png',
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                ),

              const SizedBox(height: 16),

              // Price
              Text(
                'Prix: ${produit.prix}',
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                'Description: ${produit.description ?? ""}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
