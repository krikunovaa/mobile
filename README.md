# Flutter + Supabase Auth Demo

Небольшое веб-приложение на Flutter с авторизацией через Supabase.

## Функционал

- Регистрация:
  - Логин
  - Email
  - Пароль
- Вход:
  - по логину **или** email + пароль
- На почту отправляется одноразовый код (OTP)
- После успешного ввода кода пользователь попадает на экран:
  > Здравствуйте, \<логин\>
- Кнопка «Выйти» завершает сессию и возвращает на экран входа

## Supabase

Необходимы:

- включённый Email provider
- таблица `profiles` (schema `public`) со столбцами:
  - `id uuid` (PK, ссылка на `auth.users.id`)
  - `username text`
  - `email text`
- RLS для `profiles` отключён или настроены политики

Email-шаблон для OTP должен содержать `{{ .Token }}`, чтобы на почту приходил именно код.

## Секреты

Реальные ключи Supabase хранятся в `lib/supabase_secrets.dart`, этот файл **игнорируется** git’ом.

В репозиторий кладётся только пример:

```dart
// lib/supabase_secrets.example.dart
const String supabaseUrl = 'https://YOUR-PROJECT-ID.supabase.co';
const String supabaseAnonKey = 'YOUR_ANON_PUBLIC_KEY';
