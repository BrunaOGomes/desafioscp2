import 'package:flutter/material.dart';
import 'di/locator.dart';
import 'presentation/mission_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy Monitor',
      debugShowCheckedModeBanner: false,
      home: const MissionListScreen(),
    );
  }
}
/* A utilização de um padrão arquitetural como MVVM em aplicações Flutter é importante porque promove a separação de responsabilidades, organizando o código em camadas bem definidas.

No padrão MVVM, a View é responsável apenas pela interface, o Model representa os dados e o ViewModel gerencia a lógica de negócio e o estado da aplicação. Essa separação evita que a interface fique sobrecarregada com regras e chamadas de API.

Isso melhora a organização do projeto, pois cada camada possui uma responsabilidade específica. Também facilita a manutenção, já que alterações em uma parte do sistema não afetam diretamente as demais.

Além disso, contribui para a escalabilidade, permitindo que novas funcionalidades sejam adicionadas de forma estruturada e reutilizável. O ViewModel pode ser testado de forma isolada, o que melhora a qualidade do código e reduz a chance de erros.

🧠 RESPOSTA – Pergunta Extra

O método WidgetsFlutterBinding.ensureInitialized() garante que o binding entre o framework Flutter e o motor da aplicação esteja inicializado antes da execução de qualquer código.

Ele deve ser utilizado quando há necessidade de executar código antes do runApp(), como inicialização de dependências, uso de plugins, chamadas assíncronas ou configuração de serviços.

Caso não seja chamado quando necessário, podem ocorrer erros como falha na inicialização de plugins, exceções indicando que o binding não foi inicializado ou comportamentos inesperados ao executar código antes da aplicação estar pronta. */