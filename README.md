
## Porcess :

- terraform init
- terraform plan
- terraform apply :
    Entrer le nom de la bdd désirée.
    Entrer le mot de passe de la BDD
- Se rendre sur le DNS de Load Balancer
- Initialiser WP.

## A corriger

- Le chemin de la clé public et privé ne doit pas se trouver dans le fichier projet.
- Complexité pour savoir ou mettre quoi ! (bastion est une instance EC2 mais a son propre module, Gestion des ALB et EC2 dans module séparé ajoute de la complexité mais est plus prpres ?)
- les isntances entre ec2 et alb sont pas facile a comprendre, il faudrait peut etre penser a l'avenir à les mettres dans le meme module ou dispatcher leur contenu différement.
