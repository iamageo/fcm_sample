# FCM Sample Flutter App

Um exemplo completo de integração Flutter com Firebase Cloud Messaging (FCM), mostrando como:

- Solicitar permissões de notificação
- Capturar o token de dispositivo
- Tratar notificações em **foreground**, **background** e **ao abrir**
- Configurar um handler de background
- Exibir logs amigáveis e com emojis para facilitar o debug

---

## 🚀 Funcionalidades

- **`configureFirebaseMessaging()`**: inicializa o FCM, pede permissões e loga o token
- **`onMessage`**: capta notificações em primeiro plano
- **`onMessageOpenedApp`**: detecta quando o usuário toca na notificação
- **Background handler**: registra notificações mesmo com o app em background ou fechado
- **Logs formatados** com emojis para rápida identificação

---

## 📋 Pré-requisitos

- Flutter 3.x ou superior
- Conta Firebase e projeto configurado
- FlutterFire CLI instalado e Firebase inicializado (`flutterfire configure`)
- Adicione o arquivo de configuração gerado (`firebase_options.dart`)
