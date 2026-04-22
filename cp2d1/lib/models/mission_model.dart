class MissionModel {
  final int? id;
  final String name;
  final String launchDate;
  final String status;

  MissionModel({
    this.id,
    required this.name,
    required this.launchDate,
    required this.status,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id'],
      name: json['name'],
      launchDate: json['launch_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'launch_date': launchDate,
      'status': status,
    };
  }
}

/* resposta:
RESPOSTA – Pergunta Subjetiva

O fluxo de envio de dados utilizando POST em uma aplicação Flutter com arquitetura MVVM ocorre da seguinte forma:

A View é responsável por capturar os dados inseridos pelo usuário por meio de formulários e interações visuais. Ao acionar uma ação, como um botão de envio, ela delega essa operação ao ViewModel, sem conter regras de negócio ou acesso direto à API.

O ViewModel recebe os dados da View, valida e organiza essas informações, criando uma instância do Model. Em seguida, ele chama um serviço responsável pela comunicação com a API.

O Model representa a estrutura dos dados da aplicação, contendo atributos tipados e métodos de conversão, como toJson e fromJson, permitindo transformar os dados para o formato JSON exigido pela API.

O Service realiza a requisição HTTP utilizando o método POST, enviando os dados em formato JSON para a API. Após receber a resposta, ele retorna o resultado ao ViewModel.

O ViewModel trata a resposta da API, atualiza o estado da aplicação (como loading, sucesso ou erro) e notifica a View.

A View, ao ser notificada, atualiza a interface do usuário automaticamente, exibindo mensagens, listas atualizadas ou feedback visual.

A injeção de dependência com GetIt permite desacoplar a criação das classes, fornecendo instâncias de serviços e ViewModels de forma centralizada, facilitando testes, manutenção e reutilização de código.

🧠 RESPOSTA – Pergunta Extra

O método WidgetsFlutterBinding.ensureInitialized() é responsável por garantir que o vínculo entre o framework Flutter e o motor da aplicação esteja inicializado antes da execução de qualquer código que dependa dessa integração.

Ele deve ser utilizado principalmente antes da execução de código assíncrono no método main(), como inicialização de serviços, uso de plugins, acesso a banco de dados, chamadas HTTP iniciais ou configuração de injeção de dependência.

Caso esse método não seja chamado quando necessário, podem ocorrer erros como falha na inicialização de plugins, exceções relacionadas ao binding não inicializado ou comportamento inesperado na execução de código assíncrono antes do runApp().*/