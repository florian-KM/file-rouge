
# Utiliser l'image de base python:3.6-alpine
FROM python:3.6-alpine

# Définir le répertoire /opt comme répertoire de travail
WORKDIR /opt

# Copier les dossiers et fichiers dans le repertoire de travail
ADD . /opt

# Installer le module Flask à l’aide de pip install
RUN pip install Flask

# Exposer le port 8080
EXPOSE 8080

# Créer les variables d’environnement ODOO_URL et PGADMIN_URL
ENV ODOO_URL = 'https://www.odoo.com/' \
    PGADMIN_URL = 'https://www.pgadmin.org/'

# Copier le script app.py dans le répertoire de travail
#COPY app.py /opt

# Lancer l’application app.py dans le ENTRYPOINT grâce à la commande python
ENTRYPOINT ["python", "app.py"]