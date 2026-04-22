import 'package:flutter/material.dart';
import 'di/locator.dart';
import 'views/mission_list_screen.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'AstroLab',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const MissionListScreen(),
    );
  }
}
/*RESPOSTA – Pergunta Subjetiva

Concentrar toda a lógica de negócio e consumo de API na View é uma má prática porque viola o princípio da separação de responsabilidades, tornando o código difícil de manter, testar e escalar. Quando a View acumula múltiplas funções, qualquer alteração na lógica pode impactar diretamente a interface, aumentando o risco de erros e dificultando a reutilização de código.

Além disso, essa abordagem gera um alto acoplamento entre interface e regras de negócio, tornando o sistema menos flexível para mudanças futuras, como troca de API ou evolução de funcionalidades.

A aplicação do padrão MVVM resolve esse problema ao dividir a aplicação em três camadas:

A View é responsável apenas pela interface e interação com o usuário.

O ViewModel gerencia o estado e a lógica de negócio, funcionando como intermediário entre a View e os dados.

O Model representa os dados estruturados da aplicação.

Com essa separação, o código se torna mais organizado, facilitando a manutenção, permitindo testes unitários no ViewModel e possibilitando a reutilização de componentes. Além disso, a escalabilidade melhora, pois novas funcionalidades podem ser adicionadas sem impactar diretamente a interface.

🧠 RESPOSTA – Pergunta Extra

O método WidgetsFlutterBinding.ensureInitialized() garante que o vínculo entre o framework Flutter e o motor da aplicação esteja inicializado antes da execução de qualquer código.

Ele deve ser utilizado quando há necessidade de executar código antes do runApp(), como inicialização de dependências, uso de plugins, chamadas assíncronas ou configuração de serviços.

Caso não seja chamado quando necessário, podem ocorrer erros como falhas na inicialização de plugins, exceções relacionadas ao binding não inicializado ou comportamento inesperado ao executar código assíncrono antes da inicialização completa da aplicação. */