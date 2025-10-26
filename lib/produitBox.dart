import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'produit_details.dart';
import 'produit.dart';

class ProduitBox extends StatelessWidget {
  final Produit produit;
  final bool selProduit;
  final Function(bool?)? onChanged;
  final VoidCallback? delProduit;

  const ProduitBox({
    super.key,
    required this.produit,
    this.selProduit = false,
    this.onChanged,
    this.delProduit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Slidable(
        key: ValueKey(produit.id),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                if (delProduit != null) delProduit!();
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProduitDetails(produit: produit),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.yellow[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: selProduit,
                  onChanged: onChanged,
                ),
                if (produit.photo != null && produit.photo!.isNotEmpty)
                  Image.file(
                    File(produit.photo!),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                else
                  Image.asset(
                    'assets/images/placeholder.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    produit.libelle ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
