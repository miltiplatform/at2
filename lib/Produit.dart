class Produit {
  String? id;
  String? libelle;
  String? description;
  double? prix;
  String? photo;
  bool selected; // <-- add this field

  Produit({
    this.id,
    this.libelle,
    this.description,
    this.prix,
    this.photo,
    this.selected = false, // default value
  });

  // Convenience constructor for empty product
  Produit.empty()
      : id = '',
        libelle = '',
        description = '',
        prix = 0,
        photo = '',
        selected = false;
}
