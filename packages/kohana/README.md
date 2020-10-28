# Kohana
[![pub](https://img.shields.io/pub/v/kohana?color=orange)](https://pub.dev/packages/kohana) [![pub](https://img.shields.io/github/last-commit/sidinaz/kohana)](https://pub.dev/packages/kohana)  
State management (flutter_hooks based), validators, common models, event bus, responsive layout and more in one codebase.  
### State management  
State management and widget lifecycle events
```dart
void handleManagedFields() {}
void componentDidMount() {}
void componentWillUnmount() {}
WidgetBuilder managedView(String path, [Map<String, dynamic> params]);
void setState([VoidCallback fn]);
var mounted = false;
```
### Various models  
Models with properties like disposeBag, T data , void dispose(), isWaiting...
```dart
class BaseViewModel<T extends BaseModel>
class BaseModel
class SingleItemsModel<T> extends BaseModel
class Tuple
class Sink
class EventBus
```  
### Validators
Including Validator<T>,
          TextFieldValidator,
          RequiredValidator,
          MaxLengthValidator,
          MinLengthValidator,
          EmailValidator,
          AlphanumericValidator,
          PatternValidator,
          MultiValidator,
          MatchValidator...  
          
```dart
final validator = MultiValidator([
  MinLengthValidator(validators.charactersCount),
  AlphanumericValidator(),
]);
```
### Views
Utils for building responsive layouts:  
```dart
class SizingInformation
class ScreenTypeLayout
class ResponsiveBuilder
class OrientationLayout
```