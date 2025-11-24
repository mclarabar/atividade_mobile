class Criadores {
  int? id;
  String image;
  String nome;
  String local;

  Criadores({
    this.id,
    required this.image,
    required this.nome,
    required this.local,
  });

  factory Criadores.fromJson(Map<String, dynamic> json) {
    return Criadores(
      id: json['id'] as int?,
      image: json['image'] as String,
      nome: json['nome'] as String,
      local: json['local'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'nome': nome,
      'local': local,
    };
  }
}
