# Projet CryptoShell – Ransomware éducatif en Bash

![Note](https://img.shields.io/badge/Validation_Académique-18,5%2F20_(Très_Bien)-2ea44f?style=for-the-badge)

> **AVERTISSEMENT ÉTHIQUE ET LÉGAL**
> 
> Ce dépôt a été créé dans un cadre **strictement académique** pour l'étude des mécanismes de logiciels malveillants et le développement de contre-mesures.
> 
> Toute utilisation de ces techniques en dehors d'un environnement de laboratoire isolé et autorisé est strictement interdite et illégale. En France, les atteintes aux Systèmes de Traitement Automatisé de Données (STAD) sont punies par le Code pénal (articles 323-1 à 323-8), avec des peines pouvant aller jusqu'à 10 ans d'emprisonnement et 300 000 € d'amende selon la loi LOPMI n° 2023-22.
> 
> **Le code source offensif de ce dépôt a été volontairement désarmé via un garde-fou de sécurité pour empêcher toute exécution accidentelle sur un système réel.**

### DESCRIPTION ET SCÉNARIO

Ce projet a été réalisé dans le cadre du module de Sécurité Informatique. Il s'agit d'un projet de Ransomware éducatif en Bash.

**Scénario :** En tant qu'analyste junior au sein d'une équipe de réponse aux incidents (CERT), l'objectif était d'étudier le code d'un ransomware ciblant les environnements Linux (`CryptoShell`), d'en analyser les mécanismes par ingénierie inverse, puis de développer les outils de détection et de récupération des données.

> ### À propos de ce dépôt
> Ce répertoire a été préparé pour mes candidatures en Master afin d'illustrer mes compétences en Scripting Bash et en Cybersécurité. 
> Il s'agit d'une version consolidée du projet académique. **Pour des raisons de sécurité, la charge utile a été neutralisée** : le script principal intègre un garde-fou strict bloquant toute exécution en dehors d'un dossier nommé `lab/`, ainsi qu'une bannière d'avertissement interactive exigeant un consentement explicite de l'utilisateur avant toute action.

### ANALYSE DES MÉCANISMES

Pour comprendre l'attaque, le malware éducatif a été décortiqué autour des concepts suivants :
* **Reconnaissance :** Parcours récursif pour cibler les extensions spécifiques (`.txt`, `.dat`).
* **Chiffrement XOR :** Utilisation de l'opérateur logique XOR avec génération de clés aléatoires.
* **Déclencheur (Bombe Logique) :** Activation différée basée sur des conditions temporelles ou événementielles pour échapper aux analyses dynamiques de base.
* **Furtivité :** Falsification des horodatages via la technique du `timestomping` pour tromper la surveillance des métadonnées, et nettoyage automatique des traces temporaires via l'interception des signaux de terminaison.

### OUTILS DE DÉFENSE DÉVELOPPÉS

Le cœur de mon travail a consisté à concevoir les contre-mesures face à cette menace :

1. **Analyse Théorique & Stratégie :** Modélisation préliminaire du cycle de vie du malware selon la classification d'Adleman (phases d'infection, d'incubation et de maladie), et cartographie des Indicateurs de Compromission (IoC) pour préparer la réponse technique.
2. **Détection (`scanner.sh`) :** Développement d'un scanner automatisé pour l'analyse comportementale et heuristique, capable de repérer les IoC comme les fichiers chiffrés, les notes de rançon, les fichiers d'état cachés et les motifs suspects.
3. **Récupération (`recovery.sh`) :** Outil de remédiation automatisé qui extrait la clé de chiffrement du système compromis, restaure l'intégralité des fichiers originaux en exploitant la propriété d'auto-inverse du XOR, et nettoie les artefacts malveillants.

### UTILISATION EN ENVIRONNEMENT ISOLÉ

Si vous souhaitez auditer les scripts, le projet inclut une sécurité interdisant son exécution en dehors d'un répertoire de test spécifique.

```bash
# 1. Créer le laboratoire de test obligatoire
mkdir lab && cd lab
touch donnees_importantes.txt

# 2. Lancer le malware éducatif (Démonstration)
../cryptoshell.sh
# -> Une bannière de sécurité interactive s'affichera. Appuyez sur [ENTRÉE] pour consentir au test.

# 3. Exécuter le scanner d'IoC (Défense)
../scanner.sh .

# 4. Exécuter le script de remédiation (Défense)
../recovery.sh
```
