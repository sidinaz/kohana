### Example
[Kohana in action (Daggerito app)](https://github.com/sidinaz/daggerito/tree/master/example) 
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
