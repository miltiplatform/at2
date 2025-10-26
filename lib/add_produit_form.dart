import 'package:flutter/material.dart';
import 'package:flutter_application_5/AddProduitFormState.dart';
import 'produit.dart';


class AddProduitForm extends StatefulWidget {
  final Function(Produit) onSubmit;

  const AddProduitForm({super.key, required this.onSubmit});

  @override
  State<AddProduitForm> createState() => AddProduitFormState();
}
