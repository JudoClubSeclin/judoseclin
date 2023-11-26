# Documentation Fonctionnelle

## Objectif

L'objectif de cette application est de présenter le Club de Judo, de fournir des informations et de permettre aux membres de gérer leur adhésion.

## Fonctionnalités

1. **Landing Page**
2. **Espace Membre**
3. **Administration**

### 1. Landing Page

La page de présentation servira d'introduction au club. Elle contiendra une description du club, les dernières nouvelles, la documentation et les compétitions à venir.

```mermaid
graph LR
  A[Page de Présentation] --> B{Description du Club}
  A --> C{News}
  A --> D{Documentation}
  A --> E{Compétitions à venir}
```

### 2. Espace Membre

L'Espace Membre permettra aux membres de gérer leur adhésion. Ils pourront s'inscrire eux-mêmes ou inscrire un membre de leur famille aux cours, s'inscrire aux compétitions, recevoir des notifications, communiquer avec le bureau, envoyer des documents, régler via carte bancaire et télécharger des factures.

```mermaid
graph LR
  A[Espace Membre] --> B{Inscription aux cours}
  A --> C{Inscription aux compétitions}
  A --> D{Réception de notifications}
  A --> E{Communication avec le bureau}
  A --> F{Envoi de documents}
  A --> G{Règlement via carte bancaire}
  A --> H{Téléchargement de factures}
```

### 3. Administration

L'administration permettra la publication de nouvelles, la création d'événements (compétitions), et le suivi des membres et de leurs adhérents.

```mermaid
graph LR
  A[Administration] --> B{Publication de news}
  A --> C{Création d'événements}
  A --> D{Suivi des membres et de leurs adhérents}
```

## Schéma global de l'application

```mermaid
graph TB
  A[Application du Club de Judo]
  A --> B[Landing Page]
  A --> C[Espace Membre]
  A --> D[Administration]
```
Cette documentation donne une vue globale de la façon dont l'application du Club de Judo sera structurée. Les différentes fonctionnalités permettront à la fois une gestion efficace du club par l'administration et une meilleure expérience pour les membres.

## Données

### News et Compétitions

``` mermaid
classDiagram
class News {
    + String titre
    + DateTime datePublication
    + Bloc description
}

class Competitions {
    + Geocode adresse
    + String titre
    + String sousTitre
    + DateTime dateDebut
    + DateTime dateFin
    + DateTime limiteInscription
    + Bloc description
}
```

### Compte et Adhésions

``` mermaid
classDiagram
Utilisateur <.. Adherents
class Utilisateur {
    - String id
    + String nom
    + String prenom
    + String emailContact
    + String telephone
    + String UID
}

class Adherents {
    + String nom
    + String prenom
    + DateTime dateDeNaissance
    + String Ceinture
    + String ecoleFrequentee
    + String NumeroLicense
    + Boolean droitAlImage
    + Boolean droitAppelSecours
    + Boolean certificatMedicalOk 
    + Boolean paiementEffectue
    + Boolean judo
    + Boolean selfDefense
    + Boolean taiso
}
```

### Inscription aux compétitions

``` mermaid
classDiagram
Adherents <.. InscrtiptionCompetition
Competitions <.. InscrtiptionCompetition
class Adherents {
    + String nom
    + String prenom
    + DateTime dateDeNaissance
    + String Ceinture
    + String ecoleFrequentee
    + String NumeroLicense
    + Boolean droitAlImage
    + Boolean droitAppelSecours
    + Boolean certificatMedicalOk 
    + Boolean paiementEffectue
    + Boolean judo
    + Boolean selfDefense
    + Boolean taiso
}

class Competitions {
    - String id
    + Geocode adresse
    + String titre
    + String sousTitre
    + DateTime dateDebut
    + DateTime dateFin
    + DateTime limiteInscription
    + Bloc description
}

class InscrtiptionCompetition {
  - String idUtilisateur
  - String idCompetition
  + DateTime dateInscription
  + Boolean estValide
}
```