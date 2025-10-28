class Propriedade {
  int? id;
  String image;
  String nome;

  Propriedade({
    this.id,
    required this.image,
    required this.nome,
  });

  factory Propriedade.fromJson(Map<String, dynamic> json) {
    return Propriedade(
      id: json['id'] as int?,
      image: json['image'] as String,
      nome: json['nome'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'nome': nome,
    };
  }
}
