# WK Studio — WK-V3

## Ouvrir le site dans VS Code

1. Extraire ce ZIP.
2. Dans VS Code : Fichier > Ouvrir le dossier > WK-V3.
3. Si Python est installé, ouvrir le terminal et lancer :

   python -m http.server 8000 --directory dist

4. Ouvrir http://localhost:8000 dans le navigateur.

Autre possibilité : avec Live Server, ouvrir dist comme dossier de travail et lancer index.html avec Live Server.

Les liens internes commencent par / : utiliser un serveur local, plutôt que de double-cliquer sur index.html.

## Envoyer sur GitHub depuis le terminal de VS Code

Dans le dossier WK-V3 :

    git init -b main
    git add .
    git commit -m "Ajout du site WK Studio"
    git remote add origin https://github.com/rockleea/WK-V3.git
    git push -u origin main

Ces commandes supposent que le dépôt GitHub est toujours vide. S'authentifier auprès de GitHub si demandé.

## Hébergement

Site statique : aucun build nécessaire. Dossier à publier : dist.
Calendly est intégré dans une fenêtre sur le site.
Le formulaire de contact ouvre la messagerie du visiteur.
Les liens légaux d'origine restent externes et étaient introuvables lors de la copie.
