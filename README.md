# Teste Técnico Sw Flutter - Pedidos

### Requisitos Atendidos
- **Autenticação OAuth 2.0** com refresh token automático
- **CRUD de Pedidos**: Listar, criar e finalizar pedidos
- **Interface intuitiva** com filtros e métricas
- **Gerenciamento de estado** com Provider
- **Injeção de dependências** com AutoInjector

###  Funcionalidades Extras
- **Card de métricas** em tempo real (total, finalizados, pendentes)
- **Filtros avançados** por status e data de criação
- **Ordenação automática** por data (mais recentes primeiro)
- **Sistema de cores centralizado** e responsivo
- **Splash screen** com verificação de autenticação
- **Formatação de datas** em português brasileiro
- **Gerenciamento centralizado de rotas**

## 🏗️ Arquitetura

### Padrão MVVM (Model-View-ViewModel)
```
lib/
├── src/
│   ├── core/           # Camada de infraestrutura
│   │   ├── env/        # Configurações de ambiente
│   │   ├── manager/    # Injeção de dependências
│   │   ├── routes/     # Gerenciamento de rotas
│   │   ├── rest/       # Cliente HTTP e OAuth
│   │   ├── ui/         # Componentes UI reutilizáveis
│   │   └── utils/      # Utilitários (formatação de data)
│   ├── models/         # Modelos de dados
│   ├── viewmodels/     # Lógica de negócio e estado
│   ├── views/          # Telas da aplicação
│   └── widgets/        # Widgets customizados
```

### Tecnologias Utilizadas
- **Flutter 3.7.2** - Framework principal
- **Provider 6.1.2** - Gerenciamento de estado
- **AutoInjector 2.0.0** - Injeção de dependências
- **Dio 5.4.3** - Cliente HTTP
- **Flutter Secure Storage 9.0.0** - Armazenamento seguro
- **Intl 0.19.0** - Formatação de datas

##  Como Executar

### Pré-requisitos
- Flutter SDK 3.7.2 ou superior
- Dart SDK
- Android Studio / VS Code
- Emulador Android ou dispositivo físico

### Credenciais de Teste
Para autenticação, utilize as credenciais fornecidas no teste técnico.

##  Decisões Arquiteturais

### 1. **Injeção de Dependências (AutoInjector)**
- **Decisão**: Utilizar AutoInjector ao invés de GetIt ou manual
- **Motivo**: Sintaxe mais limpa e fácil manutenção
- **Benefício**: Facilita testes unitários e troca de implementações

## 🔧 Funcionalidades Técnicas

### Autenticação OAuth 2.0
- Login com username/password
- Armazenamento seguro de access_token e refresh_token
- Renovação automática de tokens expirados
- Verificação de autenticação na inicialização

## 📱 Telas da Aplicação

### 1. **Splash Screen**
- Verificação de autenticação
- Redirecionamento automático

### 2. **Login Screen**
- Formulário de autenticação
- Validação de credenciais

### 3. **Order List Screen**
- Lista de pedidos com filtros
- Card de métricas
- Botão para adicionar pedidos
- Funcionalidade de finalizar pedidos

##  Estrutura do Projeto

```
lib/src/
├── core/
│   ├── env/env.dart                    # Configurações de ambiente
│   ├── manager/
│   │   ├── app_initialization.dart     # Inicialização da app
│   │   └── injector.dart              # Configuração de DI
│   ├── routes/
│   │   └── app_routes.dart            # Gerenciamento de rotas
│   ├── rest/
│   │   ├── api_client.dart            # Cliente HTTP
│   │   └── oauth_manager.dart         # Gerenciamento OAuth
│   ├── ui/
│   │   ├── app_colors.dart            # Sistema de cores
│   │   └── custom/                    # Componentes UI
│   └── utils/
│       └── date_utils.dart            # Formatação de datas
├── models/
│   └── order_model.dart               # Modelo de pedido
├── viewmodels/
│   ├── auth_viewmodel.dart            # Lógica de autenticação
│   ├── order_form_viewmodel.dart      # Lógica de formulário
│   └── order_list_viewmodel.dart      # Lógica de listagem
└── views/
    ├── login/
    │   └── login_screen.dart          # Tela de login
    ├── orders/
    │   ├── order_list_screen.dart     # Lista de pedidos
    │   ├── order_form_dialog.dart     # Dialog de criação
    │   └── widgets/                   # Widgets específicos
    └── splash/
        └── splash_screen.dart         # Tela inicial
```
