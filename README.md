# FloraFocus App

Een mobiele applicatie die gebruikers helpt bij het scannen van plantenzaden, het bijhouden van statistieken, en het bekijken van een ranglijst op basis van het aantal gescande zaden. FloraFocus ondersteunt gebruikers met een overzichtelijk profiel en biedt eenvoudige navigatie tussen verschillende functionaliteiten.

## Inhoudsopgave
- [Architectuur](#architectuur)
- [Functionaliteiten](#functionaliteiten)
  - [Login Page](#login-page)
  - [Home Page](#home-page)
  - [Statistics Page](#statistics-page)
  - [Leaderboard Page](#leaderboard-page)
- [API Service](#api-service)
- [Beveiliging](#beveiliging)
- [API Endpoints](#api-endpoints)

## Architectuur

De app maakt gebruik van een service-gestuurde architectuur om communicatie met de backend te beheren en gegevens efficiënt te laden. Dit wordt weergegeven in het volgende diagram:

```mermaid
graph TD
    A[API Service] --> B[Login Page]
    A --> C[Home Page]
    A --> D[Statistics Page]
    A --> E[Leaderboard Page]
    B --> C
    C --> D
    C --> E
    A --> F[(Backend Server)]
    style F fill:#f9f,stroke:#333,stroke-width:2px
```

## Functionaliteiten

### Login Page

De loginpagina ondersteunt gebruikers om in te loggen of een nieuw account aan te maken.

- **Login Flow**: Gebruikers vullen hun email en wachtwoord in. Indien succesvol, worden ze doorgestuurd naar de Home Page.
- **Registratie Flow**: Gebruikers kunnen een nieuw account aanmaken door hun email en wachtwoord in te voeren. Na succesvolle registratie worden ze geïnformeerd over het succes of falen.

### Home Page

Na het inloggen komen gebruikers op de Home Page. Hier kunnen zij navigeren naar verschillende functies zoals statistieken, ranglijst en producten.

**Functionaliteiten:**
- Welkomstbericht met gebruikersnaam
- Grid-layout met vier hoofdfuncties
- Een zwevende knop voor de camera om producten te scannen

### Statistics Page

Geeft een overzicht van de gescande producten per gebruiker.

- **Data Flow**: Maakt verbinding met de backend om real-time data op te halen en de statistieken bij te werken.
- **Functionaliteiten**:
  - Toont gescande producten met SKU-code
  - Real-time data-updates en visuele statistieken

### Leaderboard Page

Toont een ranglijst van gebruikers gebaseerd op het aantal gescande producten.

- **Ranking Systeem**: Gebruikers worden gesorteerd op basis van het aantal gescande producten.
- **Functionaliteiten**:
  - Rangschikking per gebruiker met gebruikersnaam en aantal gescande producten
  - Real-time updates van de ranglijst

## API Service

De ApiService-klasse verzorgt alle communicatie met de backend. Enkele kernfuncties zijn:

- `fetchUsers()`: Haalt alle gebruikers op voor de ranglijst
- `loginUser()`: Authenticeert gebruikers
- `fetchUserProducts()`: Haalt producten op voor een specifieke gebruiker
- `fetchProductBySku()`: Zoekt een product op basis van SKU-code

## Beveiliging

De app implementeert basisbeveiliging voor gegevensvalidatie en veilig gebruik van API's.

- **Email Validatie**: Controleert of het ingevoerde email-formaat geldig is
- **Veilige API-endpoints**: Beschermde endpoints voor gebruikersgegevens

## API Endpoints

| Methode | Endpoint | Beschrijving |
|---------|----------|--------------|
| GET | `/users` | Haalt alle gebruikers op |
| GET | `/users/{id}` | Haalt een specifieke gebruiker op |
| POST | `/api/user` | Maakt een nieuwe gebruiker aan |
| PUT | `/user/{id}` | Bijwerken van gebruikersgegevens |
| GET | `/products/all` | Haalt alle producten op |
| GET | `/products?skuCode={sku}` | Zoekt een product op SKU |