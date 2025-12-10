# Documentation Technique - OnBush App

## Table des Matières
1. [Vue d'ensemble du projet](#vue-densemble-du-projet)
2. [Architecture du projet](#architecture-du-projet)
3. [Arborescence des fichiers](#arborescence-des-fichiers)
4. [Stack technique](#stack-technique)
5. [Fonctionnalités implémentées](#fonctionnalités-implémentées)
6. [Fonctionnalités à implémenter](#fonctionnalités-à-implémenter)
7. [Structure des données](#structure-des-données)
8. [Guide de développement](#guide-de-développement)
9. [API et Services](#api-et-services)
10. [Tests](#tests)

---

## Vue d'ensemble du projet

OnBush App est une plateforme d'apprentissage innovante conçue pour accompagner les étudiants dans leur parcours académique. L'application fournit des résumés de cours complets, l'accès aux anciens sujets d'examens corrigés et d'autres ressources pédagogiques pour aider les étudiants à étudier efficacement.

### Caractéristiques principales
- Plateforme éducative mobile développée avec Flutter
- Architecture Clean Architecture pour une meilleure maintenabilité
- Système d'authentification sécurisé avec OTP
- Gestion de contenu académique (cours, matières, PDF)
- Programme ambassadeur avec système de parrainage
- Système de paiement intégré
- Gestion des notifications et rappels
- Support multilingue (Français/Anglais)

### Informations du projet
- **Nom**: onbush
- **Version**: 1.0.0+1
- **SDK Flutter**: >=3.3.3 <4.0.0
- **Plateforme**: Android (iOS en préparation)

---

## Architecture du projet

OnBush App suit les principes de **Clean Architecture** combinés avec le pattern **BLoC** (Business Logic Component) pour la gestion d'état. Cette approche garantit:

- ✅ Séparation des responsabilités
- ✅ Testabilité du code
- ✅ Maintenabilité à long terme
- ✅ Indépendance vis-à-vis des frameworks
- ✅ Indépendance vis-à-vis de la base de données

### Couches de l'architecture

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION                          │
│  (UI, Widgets, Pages, BLoCs/Cubits)                     │
│  - Views: Toutes les pages de l'application            │
│  - BLoCs: Gestion d'état avec flutter_bloc             │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                      DOMAIN                              │
│  (Entities, UseCases, Repository Interfaces)            │
│  - Entities: Objets métier purs                         │
│  - UseCases: Logique métier                             │
│  - Repository Interfaces: Contrats de données           │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                       DATA                               │
│  (Models, DataSources, Repository Implementations)      │
│  - Models: Représentation des données (JSON)            │
│  - DataSources: Local (Isar) & Remote (API)            │
│  - Repositories: Implémentation des interfaces          │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                      CORE                                │
│  (Utils, Constants, Extensions, Networking)             │
│  - Configuration globale de l'application               │
│  - Utilitaires et helpers                               │
└─────────────────────────────────────────────────────────┘
```

### Patterns de conception utilisés

1. **Repository Pattern**: Abstraction de la source de données
2. **Dependency Injection**: Utilisation de `get_it` pour l'injection de dépendances
3. **BLoC Pattern**: Gestion d'état réactive avec `flutter_bloc`
4. **Either Pattern**: Gestion des erreurs avec `dartz`
5. **Mapper Pattern**: Conversion entre Models et Entities

---

## Arborescence des fichiers

### Structure racine
```
onbush/
├── android/                      # Configuration Android native
├── assets/                       # Ressources statiques
│   ├── avatars/                 # Images d'avatars
│   ├── icons/                   # Icônes de l'application
│   └── images/                  # Images générales
├── google_fonts/                 # Polices Google Fonts locales
├── lib/                         # Code source Dart principal
├── screenshots/                  # Captures d'écran de l'app
├── test/                        # Tests unitaires et widgets
├── .env                         # Variables d'environnement
├── pubspec.yaml                 # Dépendances et configuration
└── README.md                    # Documentation générale
```

### Structure détaillée du dossier `lib/`

```
lib/
├── main.dart                    # Point d'entrée de l'application
├── application.dart             # Configuration de l'application Flutter
├── bootstrap.dart               # Initialisation et configuration
├── my_bloc_observer.dart        # Observateur global des BLoCs
├── service_locator.dart         # Configuration de get_it (DI)
│
├── core/                        # Couche Core
│   ├── application/             # Gestion de l'état global de l'app
│   │   ├── cubit/              # ApplicationCubit
│   │   └── pages/              # Pages globales
│   ├── bottom_navigation_bar/   # Barre de navigation principale
│   ├── connectivity/            # Gestion de la connectivité réseau
│   │   └── bloc/               # NetworkCubit
│   ├── constants/               # Constantes de l'application
│   │   ├── colors/             # Palette de couleurs
│   │   └── images/             # Chemins des images
│   ├── database/                # Configuration base de données locale (Isar)
│   ├── device_info/             # Informations de l'appareil
│   ├── exceptions/              # Gestion des exceptions
│   │   ├── auth/               # Exceptions d'authentification
│   │   ├── local/              # Exceptions locales
│   │   └── network/            # Exceptions réseau
│   ├── extensions/              # Extensions Dart
│   ├── hash/                    # Fonctions de hachage
│   ├── networking/              # Configuration réseau (Dio)
│   ├── notifications/           # Configuration des notifications
│   ├── routing/                 # Configuration du routage (auto_route)
│   ├── shared/                  # Widgets partagés
│   │   └── widget/             # Widgets réutilisables
│   ├── theme/                   # Thèmes de l'application
│   └── utils/                   # Utilitaires divers
│
├── data/                        # Couche Data
│   ├── datasources/            # Sources de données
│   │   ├── _mappers/           # Convertisseurs Model ↔ Entity
│   │   ├── local/              # Sources de données locales (Isar)
│   │   │   ├── pdf/            # Gestion locale des PDFs
│   │   │   ├── reminder/       # Gestion locale des rappels
│   │   │   └── subject/        # Gestion locale des matières
│   │   └── remote/             # Sources de données distantes (API)
│   │       ├── college/        # API des établissements
│   │       ├── course/         # API des cours
│   │       ├── mentee/         # API des filleuls (ambassadeurs)
│   │       ├── otp/            # API d'authentification OTP
│   │       ├── payment/        # API de paiement
│   │       ├── pdf/            # API des fichiers PDF
│   │       ├── speciality/     # API des spécialités
│   │       ├── subject/        # API des matières
│   │       └── user/           # API utilisateurs
│   ├── models/                 # Modèles de données (JSON)
│   │   ├── college/            # Modèle Établissement
│   │   ├── course/             # Modèle Cours
│   │   ├── mentee/             # Modèle Filleul
│   │   ├── notification/       # Modèle Notification
│   │   ├── pdf_file/           # Modèle Fichier PDF
│   │   ├── reminder/           # Modèle Rappel
│   │   ├── speciality/         # Modèle Spécialité
│   │   ├── subject/            # Modèle Matière
│   │   └── user/               # Modèle Utilisateur
│   └── repositories/           # Implémentations des repositories
│       ├── academic/           # Repository académique
│       ├── auth/               # Repository authentification
│       ├── otp/                # Repository OTP
│       ├── payment/            # Repository paiement
│       ├── pdf/                # Repository PDF
│       └── reminder/           # Repository rappels
│
├── domain/                      # Couche Domain
│   ├── entities/               # Entités métier
│   │   ├── college/            # Entité Établissement
│   │   ├── course/             # Entité Cours
│   │   ├── mentee/             # Entité Filleul
│   │   ├── notification/       # Entité Notification
│   │   ├── pdf_file/           # Entité Fichier PDF
│   │   ├── reminder/           # Entité Rappel
│   │   ├── speciality/         # Entité Spécialité
│   │   ├── subject/            # Entité Matière
│   │   └── user/               # Entité Utilisateur
│   ├── repositories/           # Interfaces des repositories
│   │   ├── academic/           # Interface repository académique
│   │   ├── auth/               # Interface repository auth
│   │   ├── otp/                # Interface repository OTP
│   │   ├── payment/            # Interface repository paiement
│   │   ├── pdf/                # Interface repository PDF
│   │   └── reminder/           # Interface repository rappels
│   └── usecases/               # Cas d'utilisation (logique métier)
│       ├── academic/           # UseCase académique
│       ├── auth/               # UseCase authentification
│       ├── otp/                # UseCase OTP
│       ├── payment/            # UseCase paiement
│       ├── pdf/                # UseCase PDF
│       └── reminder/           # UseCase rappels
│
├── presentation/                # Couche Presentation
│   ├── blocs/                  # BLoCs/Cubits pour la gestion d'état
│   │   ├── academic/           # BLoC académique (niveaux, écoles, etc.)
│   │   ├── auth/               # BLoC authentification
│   │   ├── otp/                # BLoC OTP
│   │   ├── payment/            # BLoC paiement
│   │   ├── pdf/                # BLoC gestion PDF
│   │   └── reminder/           # BLoC rappels
│   └── views/                  # Interfaces utilisateur
│       ├── auth/               # Pages d'authentification
│       │   ├── pages/          # Écrans de connexion/inscription
│       │   └── widgets/        # Composants d'auth
│       ├── dashboard/          # Tableau de bord principal
│       │   ├── course/         # Module Cours
│       │   │   ├── pages/      # Pages de détail des cours
│       │   │   └── widgets/    # Widgets des cours
│       │   ├── download/       # Module Téléchargements
│       │   │   ├── logic/      # Logique métier téléchargements
│       │   │   ├── pages/      # Pages de téléchargements
│       │   │   └── widgets/    # Widgets téléchargements
│       │   ├── history/        # Historique d'activités
│       │   │   ├── data/       # Modèles locaux
│       │   │   ├── logic/      # Logique historique
│       │   │   ├── pages/      # Pages historique
│       │   │   └── widgets/    # Widgets historique
│       │   ├── home/           # Page d'accueil
│       │   │   ├── pages/      # home_screen.dart
│       │   │   └── widgets/    # Widgets d'accueil
│       │   ├── notification/   # Module Notifications
│       │   │   ├── pages/      # Pages notifications
│       │   │   └── widgets/    # Widgets notifications
│       │   └── profil/         # Module Profil utilisateur
│       │       ├── pages/      # Pages profil
│       │       └── widgets/    # Widgets profil
│       ├── onboarding/         # Écrans d'onboarding
│       │   ├── pages/          # Pages d'introduction
│       │   └── widgets/        # Widgets onboarding
│       ├── otp_screen/         # Écrans OTP
│       │   └── pages/          # Pages de vérification OTP
│       ├── pricing/            # Module Tarification
│       │   ├── pages/          # Pages de pricing
│       │   └── widgets/        # Widgets pricing
│       ├── reminder/           # Module Rappels
│       │   ├── pages/          # Pages rappels
│       │   └── widgets/        # Widgets rappels
│       └── splash_screen/      # Écran de démarrage
│
├── services/                    # Services externes
│   ├── payment/                # Service de paiement
│   └── reminder/               # Service de notifications/rappels
│
└── l10n/                        # Internationalisation (i18n)
    └── app_localizations.dart   # Fichiers de traduction
```

### Statistiques du projet
- **Nombre total de fichiers Dart**: ~197 fichiers
- **Lignes de code estimées**: ~15,000+ lignes
- **Nombre de packages utilisés**: 50+ dépendances

---

## Stack technique

### Framework et langage
- **Flutter**: Framework UI multiplateforme
- **Dart**: Langage de programmation (SDK >=3.3.3 <4.0.0)

### Gestion d'état
- **flutter_bloc** (^8.1.5): Pattern BLoC pour la gestion d'état
- **bloc** (^8.1.4): Core library BLoC
- **provider** (^6.1.2): State management alternatif
- **equatable** (^2.0.5): Comparaisons d'objets

### Réseau et API
- **dio** (^5.4.3+1): Client HTTP
- **http** (^1.2.2): Client HTTP alternatif
- **connectivity_plus** (^6.0.4): Détection de connectivité

### Base de données locale
- **isar** (^3.1.0+1): Base de données NoSQL performante
- **shared_preferences** (^2.2.3): Stockage clé-valeur simple
- **path_provider** (^2.1.5): Accès aux répertoires système

### UI et Design
- **flutter_screenutil** (^5.9.0): Adaptation responsive
- **google_fonts** (^6.2.1): Polices Google
- **flutter_svg** (^2.0.10+1): Support SVG
- **animate_do** (^3.3.4): Animations
- **gap** (^3.0.1): Espacements
- **flashy_tab_bar2** (^0.0.10): Barre de navigation stylée
- **carousel_slider** (^5.0.0): Carrousels d'images
- **shimmer** (^3.0.0): Effets de chargement
- **cached_network_image** (^3.4.0): Cache d'images
- **percent_indicator** (^4.2.4): Indicateurs de progression
- **smooth_page_indicator** (^1.2.1): Indicateurs de page

### Navigation
- **auto_route** (^8.0.3): Routing déclaratif
- **go_router** (^14.6.2): Routing avec navigation déclarative
- **modal_bottom_sheet** (^3.0.0): Modales bottom sheet

### Authentification et validation
- **intl_phone_number_input** (^0.7.4): Saisie de numéros de téléphone
- **pin_code_fields** (^8.0.1): Champs de code PIN
- **form_builder_validators** (^11.2.0): Validation de formulaires
- **crypto** (^3.0.3): Cryptographie
- **convert** (^3.1.1): Encodage/décodage

### PDF et documents
- **syncfusion_flutter_pdfviewer** (^30.1.42): Visualiseur PDF
- **flutter_windowmanager_plus** (^1.0.1): Protection contre les captures d'écran

### Notifications et rappels
- **flutter_local_notifications** (^19.1.0): Notifications locales
- **timezone** (^0.10.1): Gestion des fuseaux horaires

### Utilitaires
- **logger** (^2.2.0): Logging
- **uuid** (^4.5.1): Génération d'UUID
- **intl**: Internationalisation
- **device_info_plus** (^11.0.0): Informations sur l'appareil
- **flutter_dotenv** (^5.2.1): Variables d'environnement
- **dartz** (^0.10.1): Programmation fonctionnelle (Either, Option)
- **json_annotation** (^4.9.0): Sérialisation JSON

### Partage et intégrations
- **share_plus** (^10.0.0): Partage de contenu
- **webview_flutter** (^4.10.0): WebView intégrée
- **url_launcher** (^6.3.1): Ouverture d'URLs
- **android_intent_plus** (^5.3.0): Intents Android

### Messages utilisateur
- **another_flushbar** (^1.12.30): Notifications in-app élégantes
- **fluttertoast** (^8.2.12): Messages toast

### Développement
- **build_runner** (^2.4.9): Génération de code
- **auto_route_generator** (^8.0.0): Génération de routes
- **json_serializable** (^6.8.0): Génération de sérialisateurs
- **isar_generator** (^3.1.0+1): Génération de schémas Isar
- **flutter_lints** (^3.0.0): Règles de lint
- **mockito** (^5.4.4): Mocking pour tests
- **mocktail** (^1.0.4): Alternative à Mockito

---

## Fonctionnalités implémentées

### 1. ✅ Système d'authentification et inscription

**Description**: Système complet d'authentification avec vérification OTP.

**Composants**:
- **UseCase**: `AuthUseCase` - Gestion de la connexion et inscription
- **BLoC**: `AuthCubit` - État d'authentification global
- **Pages**: 
  - Écran de connexion (login avec email)
  - Écran d'inscription (avec informations académiques)
  - Écran de vérification OTP
- **DataSources**:
  - `UserRemoteDataSource`: API utilisateur
  - `OtpRemoteDataSource`: API OTP

**Fonctionnalités**:
- Connexion avec email et ID d'appareil
- Inscription avec validation de formulaire
- Vérification par code OTP (6 chiffres)
- Identification unique de l'appareil
- Persistance de la session utilisateur
- Gestion des erreurs réseau

**Endpoints API**:
- `POST /connexion` - Connexion utilisateur
- `POST /login` - Authentification avec email
- `POST /register` - Inscription nouvel utilisateur
- `POST /otp/verify` - Vérification du code OTP
- `POST /otp/resend` - Renvoi du code OTP

---

### 2. ✅ Gestion académique

**Description**: Système complet de gestion des données académiques (établissements, spécialités, matières, cours).

**Composants**:
- **UseCase**: `AcademicUseCase`
- **BLoC**: `AcademyCubit`
- **Entities**: `College`, `Speciality`, `Subject`, `Course`

**Fonctionnalités**:

#### 2.1 Gestion des établissements (Colleges)
- Récupération de la liste des établissements
- Informations: nom, logo, type, etc.

#### 2.2 Gestion des spécialités (Specialities)
- Récupération des spécialités par établissement
- Filtrage par niveau académique
- Informations: nom, description, durée

#### 2.3 Gestion des matières (Subjects)
- Récupération des matières par spécialité et niveau
- Stockage local avec Isar pour accès hors ligne
- Synchronisation automatique
- Informations: nom, code, semestre, crédits

#### 2.4 Gestion des cours (Courses)
- Récupération des cours par matière
- Types de cours: résumés, TD, TP, examens corrigés
- Informations: titre, description, auteur, date de publication

**DataSources**:
- Remote: `CollegeRemoteDataSource`, `SpecialityRemoteDataSource`, `SubjectRemoteDataSource`, `CourseRemoteDataSource`
- Local: `SubjectLocalDataSource` (Isar)

**Endpoints API**:
- `GET /colleges` - Liste des établissements
- `GET /specialities` - Spécialités par établissement
- `GET /subjects` - Matières par spécialité et niveau
- `GET /courses` - Cours par matière

---

### 3. ✅ Gestion des fichiers PDF

**Description**: Système de visualisation, téléchargement et gestion des fichiers PDF de cours.

**Composants**:
- **UseCase**: `PdfUseCase`
- **BLoC**: `PdfFileCubit`, `PdfManagerCubit`
- **Service**: Service de téléchargement local
- **DataSources**:
  - `PdfRemoteDataSource`: API des PDFs
  - `PdfLocalDataSource`: Stockage local avec Isar

**Fonctionnalités**:
- Visualisation de PDF avec Syncfusion PDF Viewer
- Téléchargement de PDFs pour lecture hors ligne
- Gestion des PDFs téléchargés
- Protection contre les captures d'écran (sécurité)
- Suivi de la progression de lecture
- Historique de consultation
- Recherche dans les PDFs

**Sécurité**:
- Protection DRM
- Désactivation des captures d'écran lors de la lecture
- Vérification des droits d'accès

**Endpoints API**:
- `GET /pdfs/:id` - Récupération d'un PDF
- `GET /pdfs/course/:courseId` - PDFs d'un cours
- `POST /pdfs/track` - Suivi de consultation

---

### 4. ✅ Module de téléchargements

**Description**: Gestion complète des téléchargements de cours et PDFs.

**Composants**:
- **Cubit**: `DownloadCubit` (local à la vue)
- **Pages**: Page de liste des téléchargements
- **Local Storage**: Gestion avec path_provider

**Fonctionnalités**:
- Liste des fichiers téléchargés
- Indicateurs de progression de téléchargement
- Gestion de l'espace de stockage
- Suppression de téléchargements
- Filtrage par type de contenu
- Tri par date, taille, nom

---

### 5. ✅ Programme ambassadeur (Referral System)

**Description**: Système de parrainage permettant aux utilisateurs de devenir ambassadeurs et de parrainer d'autres étudiants.

**Composants**:
- **Entity**: `Mentee` (filleul)
- **DataSource**: `MenteeRemoteDataSource`
- **Pages**: Page ambassadeur avec liste des filleuls

**Fonctionnalités**:
- Génération de code de parrainage unique
- Partage du code de parrainage (WhatsApp, SMS, etc.)
- Liste des filleuls parrainés
- Suivi des récompenses et commissions
- Statistiques de parrainage
- Classement des ambassadeurs

**Endpoints API**:
- `GET /mentees` - Liste des filleuls
- `POST /referral/create` - Création de code parrainage
- `POST /referral/validate` - Validation d'un code

---

### 6. ✅ Système de paiement

**Description**: Intégration du système de paiement pour les abonnements premium.

**Composants**:
- **UseCase**: `PaymentUseCase`
- **BLoC**: `PaymentCubit`
- **Service**: `PaymentHandler` (gestion des transactions)
- **DataSource**: `PaymentRemoteDataSource`

**Fonctionnalités**:
- Consultation des plans tarifaires
- Initiation de paiement
- Vérification du statut de paiement
- Historique des transactions
- Gestion des abonnements actifs
- Renouvellement automatique

**Plans disponibles**:
- Essai gratuit
- Abonnement mensuel
- Abonnement trimestriel
- Abonnement annuel

**Endpoints API**:
- `GET /pricing/plans` - Liste des plans
- `POST /payment/initiate` - Initier un paiement
- `GET /payment/status/:id` - Statut de paiement
- `GET /payment/history` - Historique

---

### 7. ✅ Système de rappels et notifications

**Description**: Système de notifications locales et rappels pour les études.

**Composants**:
- **UseCase**: `ReminderUseCase`
- **BLoC**: `ReminderBloc`
- **Service**: `ReminderNotificationService`
- **DataSource**: 
  - `ReminderLocalDataSource` (Isar)
  - Notifications locales (flutter_local_notifications)

**Fonctionnalités**:
- Création de rappels personnalisés
- Notifications push locales
- Planification de rappels récurrents
- Rappels par matière/cours
- Gestion des fuseaux horaires
- Personnalisation des sons et vibrations
- Historique des rappels

**Types de rappels**:
- Rappels de révision
- Rappels d'examens
- Rappels de sessions d'étude
- Rappels personnalisés

---

### 8. ✅ Module profil utilisateur

**Description**: Gestion du profil et des paramètres utilisateur.

**Composants**:
- **Pages**: Pages de profil et paramètres
- **Entity**: `UserEntity`
- **DataSource**: `UserRemoteDataSource`

**Fonctionnalités**:
- Affichage des informations personnelles
- Modification du profil
- Gestion des paramètres de compte
- Statistiques d'utilisation
- Historique d'activité
- Gestion de l'abonnement
- Préférences de notification
- Changement de langue (FR/EN)
- Déconnexion
- Suppression de compte

**Informations affichées**:
- Nom et prénom
- Email et téléphone
- Établissement et spécialité
- Niveau académique
- Photo de profil
- Code ambassadeur

---

### 9. ✅ Page d'accueil (Dashboard)

**Description**: Tableau de bord principal avec accès rapide aux fonctionnalités.

**Composants**:
- **Page**: `home_screen.dart`
- **Navigation**: Bottom navigation bar avec tabs

**Fonctionnalités**:
- Vue d'ensemble des cours récents
- Accès rapide aux matières
- Notifications récentes
- Statistiques de progression
- Suggestions de contenu
- Accès aux fonctionnalités principales

**Sections**:
- Accueil (Home)
- Cours (Courses)
- Téléchargements (Downloads)
- Historique (History)
- Profil (Profile)

---

### 10. ✅ Écrans d'onboarding

**Description**: Introduction à l'application pour les nouveaux utilisateurs.

**Composants**:
- **Pages**: Écrans d'onboarding multiples
- **Widgets**: Indicateurs de page, boutons navigation

**Fonctionnalités**:
- Présentation des fonctionnalités clés
- Navigation par slides
- Indicateurs de progression
- Option de skip
- Transition vers l'inscription/connexion

---

### 11. ✅ Système de notifications

**Description**: Gestion des notifications in-app et système.

**Composants**:
- **Pages**: Page de liste des notifications
- **Entity**: `NotificationEntity`
- **Service**: Configuration des notifications

**Fonctionnalités**:
- Affichage des notifications reçues
- Marquer comme lu/non lu
- Suppression de notifications
- Filtrage par type
- Notifications push système
- Badges de notification

**Types de notifications**:
- Nouveaux cours disponibles
- Rappels d'étude
- Mises à jour système
- Promotions et offres
- Notifications des ambassadeurs

---

### 12. ✅ Gestion de la connectivité

**Description**: Détection et gestion de l'état de connexion réseau.

**Composants**:
- **BLoC**: `NetworkCubit`
- **Service**: `connectivity_plus`

**Fonctionnalités**:
- Détection de la connexion internet
- Affichage d'un banner en cas de déconnexion
- Synchronisation automatique à la reconnexion
- Mode hors ligne pour contenu téléchargé
- Mise en file d'attente des actions en mode hors ligne

---

### 13. ✅ Thème et personnalisation

**Description**: Système de thème personnalisable.

**Composants**:
- **Core**: `theme/light_theme.dart`
- **Configuration**: Thème Material Design

**Fonctionnalités**:
- Thème clair (Light)
- Adaptation responsive avec ScreenUtil
- Polices personnalisées (Google Fonts - Roboto)
- Palette de couleurs cohérente
- Design moderne et épuré

---

### 14. ✅ Internationalisation (i18n)

**Description**: Support multilingue pour l'application.

**Composants**:
- **L10n**: `lib/l10n/`
- **Configuration**: `flutter_localizations`

**Langues supportées**:
- Français (fr) - Langue principale
- Anglais (en)

**Fonctionnalités**:
- Changement de langue dynamique
- Traduction de toutes les interfaces
- Formatage localisé des dates et nombres
- Support des pluriels

---

### 15. ✅ Historique d'activité

**Description**: Suivi des activités de l'utilisateur dans l'app.

**Composants**:
- **Cubit**: `HistoryCubit`
- **Pages**: Page d'historique
- **Local Storage**: Modèles et repositories locaux

**Fonctionnalités**:
- Historique de consultation de cours
- Historique de téléchargements
- Statistiques d'utilisation
- Temps passé par matière
- Filtrage par période
- Export de l'historique

---

## Fonctionnalités à implémenter

### 🔲 1. Système de recherche avancée

**Priorité**: Haute

**Description**: Moteur de recherche global pour trouver rapidement des cours, matières, PDFs.

**Fonctionnalités prévues**:
- Recherche en temps réel
- Filtres avancés (niveau, matière, type de document)
- Recherche par mots-clés
- Historique de recherche
- Suggestions intelligentes
- Recherche vocale (optionnel)

**Composants à créer**:
- `SearchUseCase`
- `SearchCubit`
- Pages de recherche
- Widget de barre de recherche

---

### 🔲 2. Mode sombre (Dark Mode)

**Priorité**: Moyenne

**Description**: Ajout d'un thème sombre pour améliorer le confort visuel.

**Fonctionnalités prévues**:
- Thème sombre complet
- Basculement automatique selon l'heure
- Option dans les paramètres
- Préservation du choix utilisateur
- Adaptation de toutes les pages

**Composants à modifier**:
- `core/theme/dark_theme.dart` (à créer)
- `application.dart` (configuration thème)
- Préférences utilisateur

---

### 🔲 3. Système de favoris

**Priorité**: Moyenne

**Description**: Permettre aux utilisateurs de marquer leurs cours favoris.

**Fonctionnalités prévues**:
- Marquer/retirer des favoris
- Liste des cours favoris
- Synchronisation entre appareils
- Accès rapide aux favoris
- Tri et organisation

**Composants à créer**:
- `FavoriteLocalDataSource` (Isar)
- `FavoriteUseCase`
- `FavoriteCubit`
- Bouton favori dans les cartes de cours

---

### 🔲 4. Système de commentaires et notes

**Priorité**: Moyenne-Basse

**Description**: Permettre aux étudiants de noter et commenter les cours.

**Fonctionnalités prévues**:
- Notation des cours (1-5 étoiles)
- Commentaires sur les cours
- Modération des commentaires
- Affichage de la moyenne des notes
- Filtrage par note

**Composants à créer**:
- `RatingEntity`, `CommentEntity`
- `RatingRemoteDataSource`
- `RatingUseCase`, `RatingCubit`
- Widgets de notation et commentaires

**Endpoints API à créer**:
- `POST /courses/:id/rate`
- `POST /courses/:id/comment`
- `GET /courses/:id/comments`

---

### 🔲 5. Quiz et exercices interactifs

**Priorité**: Haute

**Description**: Module de quiz pour tester les connaissances des étudiants.

**Fonctionnalités prévues**:
- Quiz par matière/chapitre
- Questions à choix multiples (QCM)
- Questions ouvertes
- Correction automatique
- Score et statistiques
- Classement des étudiants
- Mode entraînement vs mode examen

**Composants à créer**:
- `QuizEntity`, `QuestionEntity`, `AnswerEntity`
- `QuizRemoteDataSource`
- `QuizUseCase`, `QuizCubit`
- Pages de quiz et résultats
- Timer pour les quiz chronométrés

**Endpoints API à créer**:
- `GET /quizzes/:subjectId`
- `POST /quizzes/:id/submit`
- `GET /quizzes/leaderboard`

---

### 🔲 6. Mode étude collaborative

**Priorité**: Basse

**Description**: Permettre aux étudiants d'étudier en groupe.

**Fonctionnalités prévues**:
- Création de groupes d'étude
- Chat de groupe
- Partage de notes
- Sessions d'étude planifiées
- Tableau blanc collaboratif (optionnel)

**Composants à créer**:
- `GroupEntity`, `MessageEntity`
- `ChatRemoteDataSource`
- `GroupUseCase`, `ChatCubit`
- Pages de chat et groupes
- Intégration WebSocket pour chat en temps réel

---

### 🔲 7. Statistiques avancées

**Priorité**: Moyenne

**Description**: Tableaux de bord avec statistiques détaillées de progression.

**Fonctionnalités prévues**:
- Graphiques de progression
- Temps d'étude par matière
- Objectifs d'étude personnalisés
- Badges et récompenses
- Comparaison avec la moyenne
- Prédictions de performance

**Composants à créer**:
- `StatisticsUseCase`
- `StatisticsCubit`
- Pages de statistiques avec charts
- Widgets de graphiques (fl_chart)

---

### 🔲 8. Support iOS

**Priorité**: Haute

**Description**: Adaptation et déploiement sur iOS/App Store.

**Tâches**:
- Configuration Xcode project
- Adaptation des permissions iOS
- Tests sur simulateurs et devices iOS
- Adaptation des notifications iOS
- Soumission App Store
- Gestion des certificats et profils

---

### 🔲 9. Support hors ligne amélioré

**Priorité**: Moyenne

**Description**: Amélioration du mode hors ligne.

**Fonctionnalités prévues**:
- Téléchargement en masse
- Synchronisation intelligente
- Indicateurs de contenu disponible hors ligne
- Gestion automatique du cache
- Priorisation des téléchargements

**Composants à améliorer**:
- `PdfLocalDataSource`
- `SubjectLocalDataSource`
- Logique de synchronisation

---

### 🔲 10. Système de badges et gamification

**Priorité**: Basse

**Description**: Système de récompenses pour motiver les étudiants.

**Fonctionnalités prévues**:
- Badges de progression
- Niveaux d'expérience
- Défis quotidiens/hebdomadaires
- Classements
- Récompenses déblocables
- Streak de connexion

**Composants à créer**:
- `BadgeEntity`, `AchievementEntity`
- `GamificationUseCase`
- `BadgeCubit`
- Pages de badges et achievements

---

### 🔲 11. Intégration de vidéos de cours

**Priorité**: Haute

**Description**: Support des vidéos de cours en plus des PDFs.

**Fonctionnalités prévues**:
- Lecteur vidéo intégré
- Téléchargement de vidéos
- Contrôle de vitesse de lecture
- Sous-titres
- Reprise de lecture
- Playlists de vidéos

**Packages à ajouter**:
- `video_player` ou `chewie`
- `youtube_player_flutter` (si intégration YouTube)

**Composants à créer**:
- `VideoEntity`
- `VideoRemoteDataSource`
- `VideoUseCase`, `VideoCubit`
- Pages de lecture vidéo

---

### 🔲 12. Calendrier académique

**Priorité**: Moyenne

**Description**: Calendrier intégré pour gérer les dates importantes.

**Fonctionnalités prévues**:
- Vue calendrier mensuel/hebdomadaire
- Ajout d'événements (examens, TD, etc.)
- Rappels automatiques
- Synchronisation avec calendrier système
- Import/export d'événements
- Vue agenda

**Packages à ajouter**:
- `table_calendar` ou `syncfusion_flutter_calendar`

**Composants à créer**:
- `EventEntity`
- `CalendarUseCase`
- `CalendarCubit`
- Pages de calendrier

---

### 🔲 13. Amélioration de getSubjectByLevel

**Priorité**: Basse (Bug/TODO existant)

**Description**: Implémenter la méthode `getSubjectByLevel` dans `SubjectRemoteDataSource`.

**Fichier**: `lib/data/datasources/remote/subject/subject_remote_data_source_impl.dart`

**TODO trouvé**:
```dart
// TODO: implement getSubjectByLevel
```

**Action requise**:
- Implémenter la logique de récupération des matières par niveau
- Ajouter l'endpoint API correspondant
- Tester la fonctionnalité

---

## Structure des données

### Entités principales

#### 1. UserEntity
```dart
class UserEntity {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String studentId;
  final String device;
  final int academyLevel;
  final int schoolId;
  final int majorStudy;
  final String role;
  final String birthDate;
  final String gender;
  final String? referralCode;
  final bool isPremium;
  final DateTime? premiumExpiryDate;
}
```

#### 2. CollegeEntity
```dart
class CollegeEntity {
  final int id;
  final String name;
  final String? logo;
  final String? description;
  final String type;
}
```

#### 3. SpecialityEntity
```dart
class SpecialityEntity {
  final int id;
  final String name;
  final int collegeId;
  final String? description;
  final int duration;
}
```

#### 4. SubjectEntity
```dart
class SubjectEntity {
  final int id;
  final String name;
  final String code;
  final int specialityId;
  final int level;
  final int semester;
  final int credits;
}
```

#### 5. CourseEntity
```dart
class CourseEntity {
  final int id;
  final String title;
  final String? description;
  final int subjectId;
  final String type; // resume, td, tp, exam
  final String? author;
  final DateTime publishedDate;
  final int viewCount;
  final double? rating;
}
```

#### 6. PdfFileEntity
```dart
class PdfFileEntity {
  final int id;
  final int courseId;
  final String filename;
  final String url;
  final int sizeInBytes;
  final int pageCount;
  final bool isDownloaded;
  final String? localPath;
}
```

#### 7. MenteeEntity
```dart
class MenteeEntity {
  final String id;
  final String name;
  final String email;
  final DateTime joinedDate;
  final bool isActive;
  final double commission;
}
```

#### 8. ReminderEntity
```dart
class ReminderEntity {
  final String id;
  final String title;
  final String? description;
  final DateTime scheduledTime;
  final bool isRecurring;
  final String? recurrencePattern;
  final int? subjectId;
  final bool isActive;
}
```

#### 9. NotificationEntity
```dart
class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final String type;
  final DateTime createdAt;
  final bool isRead;
  final Map<String, dynamic>? data;
}
```

---

## Guide de développement

### Prérequis

1. **Flutter SDK**: Version >=3.3.3 <4.0.0
2. **Dart SDK**: Inclus avec Flutter
3. **IDE**: VS Code ou Android Studio
4. **Émulateur**: Android Emulator ou appareil physique
5. **Git**: Pour le contrôle de version

### Installation

```bash
# 1. Cloner le repository
git clone https://github.com/darrelX/onbush.git
cd onbush

# 2. Installer les dépendances
flutter pub get

# 3. Configurer les variables d'environnement
# Copier .env.example vers .env et remplir les valeurs
cp .env.example .env

# 4. Générer les fichiers de code
flutter pub run build_runner build --delete-conflicting-outputs

# 5. Lancer l'application
flutter run
```

### Structure de développement

#### Ajout d'une nouvelle fonctionnalité

**1. Créer l'entité dans `domain/entities/`**
```dart
class MyEntity {
  final String id;
  final String name;
  // ...
}
```

**2. Créer le model dans `data/models/`**
```dart
@JsonSerializable()
class MyModel extends MyEntity {
  MyModel({required String id, required String name})
      : super(id: id, name: name);
  
  factory MyModel.fromJson(Map<String, dynamic> json) =>
      _$MyModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$MyModelToJson(this);
}
```

**3. Créer l'interface repository dans `domain/repositories/`**
```dart
abstract class MyRepository {
  Future<Either<NetworkException, List<MyEntity>>> getItems();
}
```

**4. Créer la data source dans `data/datasources/`**
```dart
abstract class MyRemoteDataSource {
  Future<List<MyModel>> getItems();
}

class MyRemoteDataSourceImpl implements MyRemoteDataSource {
  final Dio dio;
  
  @override
  Future<List<MyModel>> getItems() async {
    final response = await dio.get('/items');
    return (response.data as List)
        .map((e) => MyModel.fromJson(e))
        .toList();
  }
}
```

**5. Implémenter le repository dans `data/repositories/`**
```dart
class MyRepositoryImpl implements MyRepository {
  final MyRemoteDataSource remoteDataSource;
  
  @override
  Future<Either<NetworkException, List<MyEntity>>> getItems() async {
    try {
      final items = await remoteDataSource.getItems();
      return Right(items);
    } catch (e) {
      return Left(NetworkException.fromError(e));
    }
  }
}
```

**6. Créer le use case dans `domain/usecases/`**
```dart
class MyUseCase {
  final MyRepository repository;
  
  Future<Either<NetworkException, List<MyEntity>>> getItems() {
    return repository.getItems();
  }
}
```

**7. Créer le BLoC/Cubit dans `presentation/blocs/`**
```dart
class MyCubit extends Cubit<MyState> {
  final MyUseCase useCase;
  
  MyCubit(this.useCase) : super(MyInitial());
  
  Future<void> loadItems() async {
    emit(MyLoading());
    final result = await useCase.getItems();
    result.fold(
      (error) => emit(MyError(error.message)),
      (items) => emit(MyLoaded(items)),
    );
  }
}
```

**8. Créer les pages dans `presentation/views/`**
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyCubit>()..loadItems(),
      child: BlocBuilder<MyCubit, MyState>(
        builder: (context, state) {
          if (state is MyLoading) {
            return CircularProgressIndicator();
          }
          // ...
        },
      ),
    );
  }
}
```

**9. Enregistrer dans le service locator**
```dart
// service_locator.dart
void setupLocator() {
  // DataSources
  getIt.registerLazySingleton<MyRemoteDataSource>(
    () => MyRemoteDataSourceImpl(getIt()),
  );
  
  // Repositories
  getIt.registerLazySingleton<MyRepository>(
    () => MyRepositoryImpl(getIt()),
  );
  
  // UseCases
  getIt.registerLazySingleton(() => MyUseCase(getIt()));
  
  // BLoCs
  getIt.registerFactory(() => MyCubit(getIt()));
}
```

### Génération de code

```bash
# Générer les routes
flutter pub run build_runner build --delete-conflicting-outputs

# Générer en mode watch (régénération automatique)
flutter pub run build_runner watch --delete-conflicting-outputs

# Nettoyer les fichiers générés
flutter pub run build_runner clean
```

### Conventions de code

#### Nommage
- **Fichiers**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables et fonctions**: `camelCase`
- **Constantes**: `SCREAMING_SNAKE_CASE`

#### Organisation des imports
```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter packages
import 'package:flutter/material.dart';

// 3. Packages tiers
import 'package:dio/dio.dart';

// 4. Imports locaux
import 'package:onbush/core/...';
```

#### Structure des fichiers
- Un widget/classe par fichier (sauf pour les petits widgets privés)
- Les fichiers générés (.g.dart, .freezed.dart) ne doivent pas être modifiés manuellement

### Linting

```bash
# Analyser le code
flutter analyze

# Formater le code
flutter format .

# Corriger les problèmes de style automatiquement
dart fix --apply
```

### Tests

```bash
# Lancer tous les tests
flutter test

# Lancer un test spécifique
flutter test test/widget_test.dart

# Lancer les tests avec coverage
flutter test --coverage
```

### Build

```bash
# Build APK (Android)
flutter build apk --release

# Build App Bundle (Android - recommandé pour Play Store)
flutter build appbundle --release

# Build iOS (nécessite macOS)
flutter build ios --release
```

---

## API et Services

### Configuration API

Les URLs des API sont définies dans le fichier `.env`:

```env
API_ACCOUNT = "https://api.accounts.onbush237.com/v1"
API_DATA = "https://api.data.onbush237.com/v1"
API_KEY = "YOUR_API_KEY_HERE"  # Replace with your actual API key
```

### APIs utilisées

#### 1. API Account (Authentification)
**Base URL**: `https://api.accounts.onbush237.com/v1`

**Endpoints**:
- `POST /connexion` - Vérification de l'appareil
- `POST /login` - Connexion avec email
- `POST /register` - Inscription
- `POST /otp/send` - Envoi OTP
- `POST /otp/verify` - Vérification OTP
- `GET /user/profile` - Profil utilisateur
- `PUT /user/profile` - Mise à jour profil

#### 2. API Data (Contenu académique)
**Base URL**: `https://api.data.onbush237.com/v1`

**Endpoints**:
- `GET /colleges` - Établissements
- `GET /specialities` - Spécialités
- `GET /subjects` - Matières
- `GET /courses` - Cours
- `GET /pdfs/:id` - Fichiers PDF
- `GET /mentees` - Filleuls ambassadeur
- `GET /pricing/plans` - Plans tarifaires
- `POST /payment/initiate` - Initier paiement

### Configuration Dio

Le client HTTP Dio est configuré dans `core/networking/` avec:
- Intercepteurs pour l'authentification
- Logging des requêtes
- Gestion des erreurs
- Timeout configuration
- Retry policy

### Sécurité

- **API Key**: Requise dans les headers pour toutes les requêtes
- **Device ID**: Identification unique de l'appareil
- **Token JWT**: Pour l'authentification des utilisateurs connectés
- **HTTPS**: Toutes les communications sont chiffrées

---

## Tests

### Structure des tests

```
test/
├── widget_test.dart           # Tests de widgets
└── test.dart                  # Tests généraux
```

### Types de tests à implémenter

1. **Tests unitaires**: Tester la logique métier (UseCases, Repositories)
2. **Tests de widgets**: Tester l'UI
3. **Tests d'intégration**: Tester les flux complets

### Exemple de test unitaire

```dart
void main() {
  group('AuthUseCase', () {
    late AuthUseCase authUseCase;
    late MockAuthRepository mockRepository;
    
    setUp(() {
      mockRepository = MockAuthRepository();
      authUseCase = AuthUseCase(mockRepository);
    });
    
    test('login should return UserEntity on success', () async {
      // Arrange
      when(mockRepository.login(any, any))
          .thenAnswer((_) async => Right(mockUser));
      
      // Act
      final result = await authUseCase.login(
        device: 'device123',
        email: 'test@test.com',
      );
      
      // Assert
      expect(result.isRight(), true);
    });
  });
}
```

---

## Ressources externes

### Documentation officielle
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)

### Packages principaux
- [flutter_bloc](https://bloclibrary.dev/)
- [dio](https://pub.dev/packages/dio)
- [isar](https://isar.dev/)
- [auto_route](https://pub.dev/packages/auto_route)

### Design
- Material Design 3: [Guidelines](https://m3.material.io/)
- Flutter UI: [Widget catalog](https://docs.flutter.dev/ui/widgets)

---

## Contributeurs

### Comment contribuer

1. Fork le projet
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

### Standards de contribution

- Suivre les conventions de code Flutter/Dart
- Ajouter des tests pour les nouvelles fonctionnalités
- Documenter les fonctions publiques
- Mettre à jour cette documentation si nécessaire

---

## Licence

Ce projet est propriétaire et confidentiel.
© 2025 OnBush. Tous droits réservés.

---

## Contact et support

- **Site web**: https://onbush237.com
- **Support technique**: Via WhatsApp +237659410057
- **Suggestions**: https://wa.link/pyvwwc
- **Bugs**: https://wa.link/46vrn4

---

**Dernière mise à jour**: Décembre 2025
**Version de la documentation**: 1.0.0
