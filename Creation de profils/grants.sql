CREATE USER IF NOT EXISTS 'Visiteur'@'localhost' IDENTIFIED BY 'Visiteur123';
CREATE USER IF NOT EXISTS 'Clients'@'localhost' IDENTIFIED BY 'Clients123';
CREATE USER IF NOT EXISTS 'Gestion'@'localhost' IDENTIFIED BY 'Gestion123';
CREATE USER IF NOT EXISTS 'Administrateur'@'localhost' IDENTIFIED BY 'Administrateur123';

GRANT SELECT
ON fil_rouge.Catalogue
TO 'Visiteur'@'localhost'
IDENTIFIED BY 'Visiteur123';

GRANT SELECT
ON fil_rouge.*
TO 'Clients'@'localhost'
IDENTIFIED BY 'Clients123';

GRANT INSERT, UPDATE
ON fil_rouge.Orders
TO 'Clients'@'localhost'
IDENTIFIED BY 'Clients123';

GRANT INSERT, UPDATE
ON fil_rouge.Customers
TO 'Clients'@'localhost'
IDENTIFIED BY 'Clients123';

GRANT SELECT
ON fil_rouge.*
TO 'Gestion'@'localhost'
IDENTIFIED BY 'Gestion123';

GRANT INSERT
ON fil_rouge.*
TO 'Gestion'@'localhost'
IDENTIFIED BY 'Gestion123';

GRANT SELECT
ON fil_rouge.*
TO 'Administrateur'@'localhost'
IDENTIFIED BY 'Administrateur123';

GRANT INSERT, CREATE, DELETE
ON fil_rouge.*
TO 'Administrateur'@'localhost'
IDENTIFIED BY 'Administrateur123';