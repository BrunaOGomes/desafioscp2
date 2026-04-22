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
      title: 'Orbital Systems',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const MissionListScreen(),
    );
  }
}
/*Injeção de dependência é um padrão de projeto que consiste em fornecer as dependências de uma classe externamente, em vez de criá-las dentro da própria classe. Isso reduz o acoplamento entre os componentes do sistema, tornando o código mais flexível e fácil de manter.

No Flutter, o uso do GetIt permite gerenciar essas dependências de forma centralizada, funcionando como um localizador de serviços. Em vez de instanciar objetos diretamente, as classes solicitam suas dependências ao GetIt, que fornece as instâncias já configuradas.

Isso contribui para a redução do acoplamento porque as classes deixam de depender de implementações concretas e passam a depender apenas de abstrações. Além disso, melhora a testabilidade, pois é possível substituir facilmente dependências reais por versões simuladas (mocks) durante testes.

Como resultado, o código se torna mais modular, reutilizável e preparado para mudanças futuras, facilitando a manutenção e evolução da aplicação.

🧠 RESPOSTA – Pergunta Extra

O método WidgetsFlutterBinding.ensureInitialized() garante que o binding entre o framework Flutter e o motor da aplicação esteja inicializado antes da execução de qualquer código.

Ele deve ser utilizado quando é necessário executar código antes do runApp(), como inicialização de serviços, uso de plugins, chamadas assíncronas ou configuração de injeção de dependência.

Caso não seja chamado quando necessário, podem ocorrer erros como falha na inicialização de plugins, exceções indicando que o binding não foi inicializado ou comportamento inesperado ao executar código antes da aplicação estar pronta. */