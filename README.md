Flutter Redux
===============
• **StoreProvider** - The base Widget. It will pass the given Redux Store to all descendants that request it.

• **StoreBuilder** - A descendant Widget that gets the Store from a StoreProvider and passes it to a Widget builder function.

• **StoreConnector** - A descendant Widget that gets the Store from the nearest StoreProvider ancestor, converts the Store into a ViewModel with the given converter function, and passes the ViewModel to a builder function. Any time the Store emits a change event, the Widget will automatically be rebuilt. No need to manage subscriptions!

Here are the rules:
===============

1. Must return any value besides 'undefined'.
2. Produces 'state' or data to be used inside of your app using only previous state and the action.
3. Must not reach outside of itself to decide what value to return. Must not mutate its input state argument.


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
