# Transfert de fichiers entre 2 PC Windows avec SuperGrate

Guide pour copier **tout le profil utilisateur** (documents, réglages, comptes) d'un ancien PC vers un PC Windows neuf, **via le réseau** — même quand les PC n'arrivaient pas à se voir au départ.

Outil utilisé : [SuperGrate](https://github.com/belowaverage-org/SuperGrate) (gratuit, open source) qui pilote **USMT** de Microsoft.

---

## Les 2 PC

| Rôle | Adresse IP |
|------|------------|
| PC qui **envoie** (ancien, avec les données) | `172.20.10.7` |
| PC qui **reçoit** (neuf) | `172.20.10.6` |

> Astuce réseau : les 2 PC sont sur le **même hotspot téléphone**, ce qui leur permet de se voir (la box bloquait avant).

---

## Étape 1 — Préparer les DEUX PC (automatique)

1. Sur chaque PC, télécharge le fichier **`preparer-pc.bat`** de ce dépôt
   (bouton vert **Code → Download ZIP**, ou ouvre le fichier puis **Download raw**).
2. **Clic droit** sur `preparer-pc.bat` → **Exécuter en tant qu'administrateur**.
3. Le script fait tout seul :
   - réseau en **Privé**
   - **Partage de fichiers** + **Découverte réseau** activés
   - **Ping** autorisé
   - déblocage de l'**accès admin réseau** (clé registre `LocalAccountTokenFilterPolicy`)
4. À la fin, il affiche l'**adresse IP** du PC.

> ⚠️ À faire sur **les 2 PC**.

---

## Étape 2 — Vérifier que les PC se voient

Sur le PC qui reçoit (`172.20.10.6`), ouvre `cmd` et tape :

```
ping 172.20.10.7
```

Tu dois voir **« Réponse de … »**. Fais l'inverse depuis l'autre PC.

---

## Étape 3 — Compte administrateur avec mot de passe

SuperGrate **refuse les comptes sans mot de passe**. Sur **chaque PC** :

- Réglages → **Comptes** → **Options de connexion** → **Mot de passe** → en mettre un si vide.
- Note bien **le nom du compte + le mot de passe** des 2 PC.

---

## Étape 4 — Installer et lancer SuperGrate

À faire sur le **PC qui reçoit** (`172.20.10.6`) :

1. Va sur **https://github.com/belowaverage-org/SuperGrate/releases**
2. Télécharge la dernière version (**SuperGrate.exe**)
3. Ouvre-le. Si Windows affiche « Windows a protégé votre PC » →
   **Informations complémentaires → Exécuter quand même**.
4. Dans SuperGrate :
   - **Source Computer** : `172.20.10.7`
   - **Destination Computer** : `172.20.10.6`
   - **List Source** → saisis le **compte admin + mot de passe** de l'ancien PC
   - Coche le **profil utilisateur** à transférer
   - **Start**

> Si SuperGrate demande les fichiers **USMT** la première fois, note le message — il faut alors installer le « Windows ADK » (USMT). Demande de l'aide avec le message exact.

---

## Si ça bloque

| Problème | Solution |
|----------|----------|
| Ping « Délai d'attente dépassé » | Relance `preparer-pc.bat` en admin sur les 2 PC |
| SuperGrate : « accès refusé » | Vérifie compte admin **avec mot de passe** + clé registre appliquée |
| SuperGrate ne voit pas la source | Utilise l'**IP** (`172.20.10.7`) et non le nom du PC |
| « Délai d'attente dépassé » à la connexion | Les 2 PC doivent rester sur le **même hotspot** |

---

*Plan B sans réseau : capturer le profil sur une **clé USB / disque externe** (USMT hors-ligne), puis l'appliquer sur le PC neuf.*
