# Judo Club Seclin
[![Website](https://github.com/JudoClubSeclin/judoseclin/actions/workflows/firebase-hosting-merge.yml/badge.svg?branch=main)](https://github.com/JudoClubSeclin/judoseclin/actions/workflows/firebase-hosting-merge.yml) 
[![Github Page](https://github.com/JudoClubSeclin/judoseclin/actions/workflows/github-pages.yml/badge.svg?branch=main)](https://github.com/JudoClubSeclin/judoseclin/actions/workflows/github-pages.yml)
[![codecov](https://codecov.io/github/JudoClubSeclin/judoseclin/branch/main/graph/badge.svg?token=YH9ZPC2F6S)](https://codecov.io/github/JudoClubSeclin/judoseclin)

![Logo](./assets/images/logo-fond-blanc.png)

## Quel objectif ?

L'objectif de cette application est de présenter le Club, informer et permettre aux membres de gérer leur adhésion.

### Les fonctionnalités
- SinglePage: page de présentation, contiendra une description du club, les news, la documentation ainsi que les compétitions
- EspaceMembre
    - Inscription de soi-même ou d'un membre de sa famille aux cours
    - Inscription aux compétitions
    - Réception de notifications
    - Communication avec le bureau
    - Envoie de documents
    - Règlement via carte bancaire
    - Téléchargement de facture
- Administration
    - Publication de news
    - Création d'évènements (compétitions)
    - Suivi des membres et de leurs adhérents

### Outillage
- Espace projet : [Notion](https://bfontaine.notion.site/Judo-Club-Seclin-b323b86695e84ea7b19bafd3b2be8c80)
- Sources : [Github](https://github.com/JudoClubSeclin/judoseclin)
- API et hébergement : [Firebase](https://console.firebase.google.com/project/jcs-app-da13e/)
- Gestion du domaine : [OVH](https://ovh.com/manager/)

## Stacks techniques

Pour fournir quelque chose de fonctionnel au plus vite et expérimenter quelques designs, nous avons créé une première page web.

### Flutter

Framework multi-plateforme phare de Google, il nous permet de créer des applications destinées aux Stores iOS, Android, MacOS et Windows ainsi qu'au web.

Nous nous concentrerons, dans un premier temps, sur les stores mobiles et le web.

## Nos pratiques

Pour une qualité et une lisibilité optimale du code, pour un code réellement adapté au besoin et, enfin, pour un code avec une quantité minimale de bug/vulnérabilité, et ce, quelque soit la technologie, il nous faut des outils techniques mais aussi méthodologiques.

Pour la technique, l'indispensable et le minimum à avoir sont :

- Un IDE (VSCode, Android Studio, IntelliJ, etc.)
- Un linter (TSLint, StyleLint, DartLint, etc.)
- Un language ou superset typé

Pour la méthodologie, vous trouverez tout ce qu'il ci-dessous.

### TDD (Test Driven Development)

Le TDD (Développement piloté par les tests en français) est une méthode de développement qui consiste à réaliser les tests avant d'écrire le code de production.

Le principe est simple :

1. On écrit un test qui correspond au besoin
2. On vérifie qu'il échoue (si ce n'est pas le cas, c'est que le test doit être revu)
3. On implémente du code de production jusqu'à ce que le test passe au vert
4. On refactorise en faisant attention de garder tous ses tests au vert
5. On passe au test suivant

Dans le cas d'une résolution de bug, le traitement est sensiblement le même :

1. On écrit deux tests : une qui reproduit le bug (vert) et un qui correspond au comportement attendu (rouge)
2. On implémente du code de production qui inverse le résultat des deux tests
3. On supprime le test qui reproduit le bug
4. On refactorise en faisant attention de garder tous ses tests au vert
5. On passe au bug suivant

#### De l'intérêt des mocks

Mocker un élément de son code est un couplage fort entre le test et la modélisation, ce qui augmente drastiquement la compléxité et la maintenabilité des tests. Multiplier les mocks force votre code de production à être "testable", pas dans le bon terme mais celui qui érode le code et le rend moins lisible.

Sur un projet front web (Javascript), le seul mock réellement indispensable est celui qui communique avec l'API (le fetch ou le getJson pour RxJS)

Il existe un très bon article (en anglais) sur le sujet [Mocking is a code smell](https://goo.gl/7VXZAS)

### BDD (Behavior Driven Development)

Le BDD (développement piloté par les comportements) reste un développement piloté par les tests mais ces tests sont des tests de comportement.

En gros, nous définissons un comportement attendu avec des exemples concrets et nous nous en servons comme base pour réaliser nos tests qui piloteront nos développements.

L'avantage de cette pratique, face aux tests unitaires, est l'utilisation du language [Gherkin](https://docs.cucumber.io/gherkin/reference/). Il permet de rendre les tests compréhensibles dans un non-spécialiste du développement (un PO, un client, etc.). Il peut ainsi, popentiellement, aller directement chercher dans le code et comprendre le comportement de l'application.

Pour plus d'informations sur le BDD, je vous conseille le site [cucumber.io](https://docs.cucumber.io/bdd/)

### SOLID

SOLID est un ensemble de principes qui répond à une problématique d'évolutivité du code source. Ils sont dans le livre `Agile Software Development, Pinciples, Patterns and Practices` de Robert C. Martin.

#### Single responsibility principle

Comme son nom l’indique, ce principe signifie qu’une classe ne doit posséder qu’une et une seule responsabilité.

#### Open close principle

Les classes et les méthodes doivent être ouvertes à l'extension mais fermées à la modification.

#### Liskov principle

"[...]La notion de sous-type telle que définie par Liskov et Wing est fondée sur la notion de substituabilité : si `S` est un sous-type de `T`, alors tout objet de type `T` peut être remplacé par un objet de type `S` sans altérer les propriétés désirables du programme concerné.

Le principe de Liskov impose des restrictions sur les signatures sur la définition des sous-types :

- Contravariance des arguments de méthode dans le sous-type.
- Covariance du type de retour dans le sous-type.
- Aucune nouvelle exception ne doit être générée par la méthode du sous-type, sauf si celles-ci sont elles-mêmes des sous-types des exceptions levées par la méthode du supertype.
- On définit également un certain nombre de conditions comportementales (voir la section Conception par contrat).(...)", [Wikipedia](https://fr.wikipedia.org/wiki/Principe_de_substitution_de_Liskov)

#### Interface segregation principle

L'objectif est d'utiliser les interfaces pour définir des contrats qui répondent à un besoin fonctionnel pour créer une abstraction et réduire le couplage.

**ATTENTION**

> L'utilisation systèmatique des interfaces pour chaque classe est un anti-pattern.

> Pensez à faire preuve de bon sens et de pragmatisme !

#### Dependency inversion principle

Ce principe consiste à rendre indépendant les modules de haut niveau de eux de bas niveau en inversant ces relations.

En gros :

- Les modules de haut niveau et les modules de bas niveau dépendent d'abstractions pour casser le lien de dépendance haut vers bas.
- Les abstractions ne doivent pas dépendre des détails. Les détails doivent dépendre des abstractions.

### Clean Code, Refactoring, Code Review

Ces termes résumes 3 principes de base du développeur :

- Rendre le code dans un meilleur état que celui dans lequel on l'a trouvé.
- L'état de l'art évolue et la perfection n'existe pas, il faut donc toujours retravailler son code
- Tout code rédigé ne peut être intégré s'il n'a pas été revu par vos pairs

Pour les code review, il existe deux outils :

1. **Revue de code :** moment passé entre développeurs pour trouver un maximum de bug, vulnérabilité ou code smell.
2. **Pull request :** même principe que la revue de code mais de façon asynchrone.

#### Regrouper son code par fonctionnalité métier

L'objectif est de regrouper le code source de façon à ce qu'un product owner ou un client puisse s'y retrouver.

Voici un exemple en typescript :

```typescript
src
 |_ ma-premiere-fonctionnalité
     |_ ma-premiere-fonctionnalité.feature // Définition de comportement attendu
     |_ ma-premiere-fonctionnalité.feature.spec.ts // automatisation des tests
     |_ sous-fonctionnalité-1
        |_ sous-fonctionnalité-1.feature
        |_ ...
     |_ sous-fonctionnalité-2
     |_ ...
  |_ ma-seconde-fonctionnalité
  |_ ...
```

#### Pourquoi utiliser `typescript` ?

Pour quelques raisons simples :

- L'utilisation des types sécurise le code et vous alerte de toute incohérence
- Vous aide à mieux comprendre comment fonctionne vos libraries (`recompose` n'est pas magique)
- Vous permet d'être dans l'état de l'art du javascript en avance de phase (oui, Typescript, c'est du Javascript !)

#### Le Domain Driven Design

Le Domain Driven Design (DDD, terme inventé par Eric Evans dans son livre du même titre) est une approche du développement logiciel pour des besoins complexes en connectant l' implémentation à un modèle évolutif.

DDD est basé sur deux principes :

- Toute conception métier complexe doit se baser sur un modèle de domaine.
- Se focaliser en premier sur le cœur de métier et sa logique au lieu des contraintes techniques.

Le DDD intervient sur des projets où les concepts métiers sont difficiles à comprendre et il est assez difficile à apréhender. Ainsi, nous ferons preuve de pragmatisme : l'objectif est de regrouper le code source de façon à ce qu'un product owner ou un client puisse s'y retrouver.

Voici un exemple en typescript :

```typescript
src
 |_ ma-premiere-fonctionnalité
     |_ ma-premiere-fonctionnalité.feature // Définition de comportement attendu
     |_ ma-premiere-fonctionnalité.feature.spec.ts // automatisation des tests
     |_ sous-fonctionnalité-1
        |_ sous-fonctionnalité-1.feature
        |_ ...
     |_ sous-fonctionnalité-2
     |_ ...
  |_ ma-seconde-fonctionnalité
  |_ ...
```

Nous aurons ici une approche hybride entre le TDD, le BDD et le DDD :

- Tout notre code sera testé mais la couverture sera partagée entre tests unitaires et tests de comportement
- Tous nos tests serons automatisés et piloteront nos développements et notre design
- L'approche sera orientée métier exclusivement, la technique (ou technologie) ne sera abordée que comme solution à un problème fonctionnel
- Les scenarios Gherkin seront co-écris entre le développeur, le testeur et le spécialiste métier
- L'avancement du projet se fera de façon itérative priorisé par la valeur business.

![approche hybride](doc/img/approche-hybride.jpeg)

#### Clean Architecture

La Clean Architecture vise à réduire les dépendances de votre logique métier avec les services que vous consommez (API, Base de données, Framework, Librairies tierces), pour maintenir une application stable au cours de ses évolutions, de ses tests mais également lors de changements ou mises à jour des ressources externes.

![Clean Architecture](doc/img/CleanArchitecture.jpeg)

Lors de l’implémentation de cette architecture il existe des règles, ayant toutes pour maître-mot « **l’indépendance** ».

La logique implémentée doit :

- Être **indépendante des frameworks** : les frameworks et librairies doivent être des outils, sans pour autant vous contraindre.
- Être **testable** indépendamment : les tests doivent pouvoir être réalisés sans éléments externes (interface utilisateur, base de données ...)
- Être **indépendante de l’interface utilisateur** : l’interface utilisateur doit pouvoir changer de forme (console, interface web ...)
- Être **indépendante de la base de données** : il doit être possible de changer de SGBD.
- Être **indépendante de tout service ou système externe** : en résumé elle ne doit pas avoir conscience de ce qui l’entoure.

De même que pour nos pratique, nous en aurons une approche pragmatique et progressive.
