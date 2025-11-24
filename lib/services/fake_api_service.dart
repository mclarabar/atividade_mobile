import 'package:dio/dio.dart';
import '../db/propriedades_dao.dart';
import '../domain/propriedade.dart';

class FakeApiService {
  final PropriedadesDao _dao = PropriedadesDao();
  final Dio _dio = Dio();

  final String baseUrl = 'https://my-json-server.typicode.com/mclarabar/fake_api';

  Future<List<Criadores>> fetchCreatorsOnline() async {
    try {
      List<Criadores> lista = [];
      final response = await _dio.get('$baseUrl/criadores');

      if (response.statusCode == 200) {
        print('Dados carregados da API online.');
        for(var json in response.data){
          lista.add(Criadores.fromJson(json));
        }
        return lista;
      } else {
        throw Exception('Erro ao carregar criadores da API.');
      }
    } catch (e) {
      print('Erro ao acessar API online: $e');
      print('Carregando dados do banco local como alternativa...');
      return fetchCreatorsFromDatabase();
    }
  }

  // Future<List<Map<String, dynamic>>> fetchCreatorsFromDatabase2() async {
  //   final List<Criadores> propriedades = await _dao.listarPropriedades();
  //
  //
  //   return propriedades.map((p) => {
  //     'id': p.id,
  //     'image': p.image ?? '',
  //     'nome': p.nome ?? '',
  //     'local': p.local ?? '',
  //   }).toList();
  // }

  Future<List<Criadores>> fetchCreatorsFromDatabase() async {
    final List<Criadores> propriedades = await _dao.listarPropriedades();
    return propriedades;
  }
}
