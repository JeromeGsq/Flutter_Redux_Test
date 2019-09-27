Flutter Redux
===============

**Flutter Redux package**: https://pub.dev/packages/flutter_redux
**Tuto Fr:** https://www.didierboelens.com/fr/2019/04/bloc---scopedmodel---redux---comparaison/

_______________
> This ReadMe does not reflect the classes and screens used in this repository.
> You will find a simplified example of how I use Flutter Redux in this ReadMe.
_______________

• **files and folders**
```
Project
+-- lib
    +-- redux
        +-- app
            |-- app_actions.dart
            |-- app_middleware.dart
            |-- app_reducer.dart
            +-- app_store.dart
        +-- examplepage
            |-- examplepage_actions.dart
            |-- examplepage_middleware.dart
            |-- examplepage_reducer.dart
            +-- examplepage_state.dart         
        +-- anotherpage
            +-- ... 
```

Example Page
===============

• **examplepage_actions.dart**

Declare actions here, you can create `Action` without parameters.
`Actions` are the only types of information that are accepted by the `Store`.
`Actions` are used by `Middleware` and `Reducer` to process certain functions, which could result in a modification of the State.

```dart
class LoadDataAction {
  final String url;
  LoadDataAction(this.url);
}

class DataLoadedAction {
  final Data data;
  DataLoadedAction(this.data);
}

class BusyAction{
  final bool isBusy;
  BusyAction(this.isBusy);
}

```

• **examplepage_middleware.dart**

`Middleware `is a function generally used for asynchronous (but not necessarily) execution, based on an `Action`. A `Middleware` simply uses a `State` (or an `Action` as a trigger) but does not modify the `State`.

```dart
class ExamplePageMiddleware extends MiddlewareClass<ExamplePageState> {
  @override
  Future<Null> call(Store<ExamplePageState> store, dynamic action, NextDispatcher next) async {

    // LoadDataAction is received by the Middleware (and by the Reducer too !)
    if (action is LoadDataAction) {
      // You can dispatch Actions anytime
      store.dispatch(BusyAction(isBusy: true));

      // TODO: don't do that directly with ApiClient()
      var data = await ApiClient().getData(action.url);
      // You dispatch a new Action with data.
      // this Action will be received by the Reducer (and this Middleware too !)
      store.dispatch(DataLoadedAction(data: data));

      store.dispatch(BusyAction(isBusy: false));
    }

    next(action);
  }
}
```

• **examplepage_reducer.dart**

A `Reducer` is a normally synchronous function that performs some processing depending on the `Action` - `State` combination. The result of the treatment could lead to a new `State`.
The `Reducer` is the only one allowed to change the `State`.

```dart
ExamplePageState examplePageReducer(ExamplePageState state, dynamic action) {
  // Something has dispatched an Event:

  // Is this a BusyAction ?
  if (action is BusyAction) {
    // Copy the current State, edit the new State, then return it
    return state.copyWith(
      isBusy: action.isBusy,
    );
  }

  if (action is DataLoadedAction) {
    // We can do synchronous treatment here
    if (action?.data != null) {
      state.data = action.data;
    }
    return state.copyWith(
      data: state.data,
    );
  }

  return state;
}
```

• **examplepage_state.dart**



```dart
@immutable
class ExamplePageState {
  ExamplePageState({
    @required this.isBusy,
    @required this.data,
  });

  final bool isBusy;
  final Data data;

  factory ExamplePageState.initial() {
    return ExamplePageState(
      isBusy: false,
      data: Data(),
    );
  }

  ExamplePageState copyWith({
    bool isBusy,
    Data data,
  }) {
    return HomePageState(
      isBusy: isBusy ?? this.isBusy,
      data: data ?? this.data,
    );
  }
}
```

App
===============
• **app_actions.dart**
```dart
class BusyAction {
  final bool isBusy;

  BusyAction({
    this.isBusy,
  });
}
```

• **app_middleware.dart**
```dart
// Nothing here at the moment
```

• **app_reducer.dart**
```dart
AppState appStoreReducer(AppState state, dynamic action) {
  return AppState(
    examplePageState: examplePageReducer(state.examplePageState, action),
    anotherPageState: anotherPageReducer(state.anotherPageState, action),
    ...
  );
}
```

• **app_store.dart**
```dart
@immutable
class AppStore {
  const AppStore({
    this.examplePageState,
    this.anotherPageState,
    ...
  });

  final ExamplePageState examplePageState;
  final AnotherPageState anotherPageState;

  factory AppStore.initial() {
    return AppStore(
      examplePageState: ExamplePageState.initial(),
      anotherPageState: AnotherPageState.initial(),
      ...
    );
  }
}
```

Widgets
===============

• **StoreProvider** - The base Widget. It will pass the given Redux Store to all descendants that request it.

• **StoreBuilder** - A descendant Widget that gets the Store from a StoreProvider and passes it to a Widget builder function.

• **StoreConnector** - A descendant Widget that gets the Store from the nearest StoreProvider ancestor, converts the Store into a ViewModel with the given converter function, and passes the ViewModel to a builder function. Any time the Store emits a change event, the Widget will automatically be rebuilt. No need to manage subscriptions!

Here are the rules for reducers:
===============

1. Must return any value besides 'undefined'.
2. Produces 'state' or data to be used inside of your app using only previous state and the action.
3. Must not reach outside of itself to decide what value to return.
Must not mutate its input state argument.


Pro/Cons
===============
• Dans mon cas, 4 fichiers nécessaires pour 1 écran :
* action : `movie_details_action.dart`
* state : `movie_details_state.dart`
* reducer : `movie_details_reducer.dart`
* middleware : `movie_details_middleware.dart`

• C'est lourd de devoir englober notre widget dans un **StoreConnector** à chaque fois (comme **ScopedModel**).

• Il faut créer beaucoup d'actions.

• Il ne faut pas oublier de reset les **States** quand on navigue dessus afin de ne pas se retrouver avec d'anciennes valeurs.
> Avant de naviguer sur l'écran détails d'un film, il faut reseter le contenu du `movie_details_state.dart` sinon l'écran affichera l'ancien contenu le temps de recevoir les nouvelles informations du webservice.

• Design pattern complexe pour un junior.

• On doit re créer un **State** à chaque modifications.

• Accès et modifications très facile grâce aux **States**. Une seule source de données pour tous.


https://www.didierboelens.com/fr/2019/04/bloc---scopedmodel---redux---comparaison/
