# Todo S6 - Stories + API + backlog (OpenAPI/Swagger + GitHub) (fiche + mini TP + exemple Cassandre)

## Fiche de cours (S6)

Préparer la réalisation, c’est faire le lien entre le besoin et le code à venir. On transforme les scénarios en **user stories**, puis on imagine l’API qui permettra au front d’échanger avec le back. On ne cherche pas l’exhaustivité: on vise une API minimale cohérente avec le MVP.

Une **API REST** expose des ressources (ex: users, sessions) via des URL. Les verbes HTTP indiquent l’action:

* GET: lire
* POST: créer
* PUT/PATCH: modifier
* DELETE: supprimer

**OpenAPI** (souvent via Swagger UI) permet de décrire cette API de façon standard: endpoints, paramètres, schémas de données, réponses, erreurs. Même sans implémentation, la spec sert de contrat entre front et back.

### Encadré vocabulaire

* **Endpoint**: route d’API (ex: POST /login).
* **Payload**: données envoyées (body JSON).
* **Code HTTP**: résultat (200 OK, 201 Created, 400 Bad Request, 401 Unauthorized, 404 Not Found).

## Mini TP (S6)

1. On prend 2 scénarios du MVP (ex: login, profil).
2. On écrit 2 user stories + critères d’acceptation.
3. On dérive 2-3 endpoints REST.
4. On rédige une mini spec OpenAPI:

   * 2 endpoints
   * schémas JSON (request/response)
   * au moins 2 codes d’erreur
5. On crée les Issues GitHub correspondantes et on les met dans un Project (Ready).

## Exemple Cassandre (S6)

Stories:

* US: “On veut se connecter afin d’accéder au tableau de bord.”
* US: “On veut consulter son profil afin de vérifier ses informations.”

Endpoints minimum:

* POST `/api/login` (crée une session)
* GET `/api/me` (renvoie le profil)

Exemple OpenAPI (extrait minimal, style YAML):

```yaml
openapi: 3.0.0
info:
  title: Cassandre API
  version: 1.0.0
paths:
  /api/login:
    post:
      summary: Connexion utilisateur
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              required: [email, password]
              properties:
                email: { type: string, format: email }
                password: { type: string }
      responses:
        "200":
          description: OK
        "401":
          description: Identifiants invalides
  /api/me:
    get:
      summary: Profil utilisateur courant
      responses:
        "200":
          description: OK
        "401":
          description: Non authentifié
```
