# therapy_calendar

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Development

If you want to help develop this app you will need to generate some code. The app is using [built_value](https://github.com/google/built_value.dart) for its model classes. Therefore you will have to start the `build_runner` once. You also can find these calls in the [.gitlab-ci.yml](.gitlab-ci.yml) file, as the CI does the same here.

To run the once:
```shell script
$ flutter pub run build_runner build
```

If you want to make some changes to the model you probably want to start the `build_runner` in `watch`-mode for automatic redeploy:
```shell script
$ flutter pub run build_runner watch
```

If you already had generated files there it might be necessary to add the option `--delete-conflicting-outputs` to override them.

## Live Templates

We 'developed' (adapted) our own live-template for a `built_value` class.

```dart
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part '$FILE_NAME$';

abstract class $CLASS_NAME$ implements Built<$CLASS_NAME$, $CLASS_NAME$Builder> {
  factory $CLASS_NAME$([void Function($CLASS_NAME$Builder) updates]) = _$$$CLASS_NAME$;
  $CLASS_NAME$._();
  
  $END$
  
  static Serializer<$CLASS_NAME$> get serializer => _$$$CAMEL_CLASS_NAME$Serializer;
}
```

Variables:

<dl>
    <dt>FILE_NAME</dt><dd>regularExpression(fileName(), ".dart", ".g.dart")</dd><dd>skipIfDefined: true</dd>
    <dt>CLASS_NAME</dt><dd>capitalize(underscoresToCamelCase(regularExpression(fileName(), ".dart", "")))</dd><dd>skipIfDefined: false</dd>
    <dt>CAMEL_CLASS_NAME</dt><dd>camelCase(CLASS_NAME)</dd><dd>skipIfDefined: true</dd>
</dl>

## i18n and l10n

We worked with the `Flutter Intl`-Plugin for IntelliJ which worked pretty well. If you want to try it without the plugin, you can try to run:

```shell script
flutter pub global list
flutter pub global run intl_utils:generate
```

This should generate the files in `lib/generated`.
