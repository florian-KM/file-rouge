## **1) Conteneurisation de l’application web.** 

### Dockerfile Explication

Ce Dockerfile est utilisé pour créer une image Docker pour une application Flask basée sur Python 3.6 et Alpine Linux. Voici une explication détaillée de chaque partie du Dockerfile :

1. **Utiliser l'image de base `python:3.6-alpine`**

    ```dockerfile
    FROM python:3.6-alpine
    ```

    Cette ligne spécifie que l'image de base pour notre conteneur sera `python:3.6-alpine`. Alpine est une distribution Linux légère qui aide à minimiser la taille de l'image Docker.

2. **Définir le répertoire `/opt` comme répertoire de travail**

    ```dockerfile
    WORKDIR /opt
    ```

    Cette instruction définit le répertoire de travail à `/opt`. Toutes les commandes suivantes (comme `RUN`, `CMD`, `ENTRYPOINT`, etc.) seront exécutées dans ce répertoire.

3. **Copier les dossiers et fichiers dans le répertoire de travail**

    ```dockerfile
    ADD . /opt
    ```

    La commande `ADD` copie tous les fichiers et dossiers du contexte de construction (le répertoire où se trouve le Dockerfile) dans le répertoire de travail `/opt` à l'intérieur du conteneur.

4. **Installer le module Flask à l’aide de `pip install`**

    ```dockerfile
    RUN pip install Flask
    ```

    Cette commande installe le module Flask en utilisant `pip`, le gestionnaire de paquets de Python.

5. **Exposer le port 8080**

    ```dockerfile
    EXPOSE 8080
    ```

    Cette instruction informe Docker que le conteneur écoute sur le port 8080 au runtime. Ce port est utilisé par l'application Flask.

6. **Créer les variables d’environnement `ODOO_URL` et `PGADMIN_URL`**

    ```dockerfile
    ENV ODOO_URL='https://www.odoo.com' \
        PGADMIN_URL='https://www.pgadmin.org'
    ```

    La commande `ENV` définit les variables d'environnement `ODOO_URL` et `PGADMIN_URL`. Ces variables peuvent être utilisées par l'application à l'intérieur du conteneur.

7. **Lancer l’application `app.py` dans le `ENTRYPOINT` grâce à la commande `python`**

    ```dockerfile
    ENTRYPOINT ["python", "app.py"]
    ```

    Cette ligne définit le point d'entrée du conteneur. Lors du démarrage du conteneur, cette commande exécutera le script `app.py` en utilisant l'interpréteur Python.



### Exécution du conteneur Docker

Construire l'image
```sh
docker build -t ic-webapp .
```


Pour démarrer un conteneur à partir de l'image construite et lui donner le nom `ic-webapp`, utilisez la commande suivante :

```sh
docker run -d -p 8080:8080 -e ODOO_URL="https://www.odoo.com" -e PGADMIN_URL="http://www.pgadmin.org" --name test-ic-webapp ic-webapp
```

Explication de la commande :
- `docker run`: commande pour créer et démarrer un nouveau conteneur.
- `-d`: exécute le conteneur en arrière-plan (détaché).
- `-p 8080:8080`: mappe le port 8080 du conteneur au port 8080 de l'hôte.
- `-e ODOO_URL="http://www.odoo.com"`: définit la variable d'environnement `ODOO_URL`.
- `-e PGADMIN_URL="http:/https://www.pgadmin.org"`: définit la variable d'environnement `PGADMIN_URL`.
- `--name test-ic-webapp`: donne le nom `test12` au conteneur.
- `ic-webapp`: nom de l'image Docker que vous avez construite.

### Tag et Push de l'image vers le registre Docker

Pour taguer l'image et la pousser vers un registre Docker, utilisez les commandes suivantes :

1. **Taguer l'image :**

    ```sh
    docker tag ic-webapp registry.iforce5demo.com/ic-webapp:1.0
    ```

    Cette commande tague l'image locale `ic-webapp` avec le nom `registry.iforce5demo.com/ic-webapp` et le tag `1.0`.

2. **Pousser l'image vers le registre :**

    ```sh
    docker push registry.iforce5demo.com/ic-webapp:1.0
    ```

    Cette commande pousse l'image taguée vers le registre Docker `registry.iforce5demo.com`.
