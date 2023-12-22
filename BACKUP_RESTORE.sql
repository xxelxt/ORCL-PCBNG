------------------------
--- BACKUP & RESTORE ---
------------------------

--- Execute this in sqlplus as sysdba

sqlplus / as sysdba

ARCHIVE LOG LIST

SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;

ALTER DATABASE CLOSE;

--- Backup & Restore in RMAN

BACKUP DATABASE;
BACKUP DATABASE PLUS ARCHIVELOG;
LIST BACKUP;

RESTORE DATABASE VALIDATE;
RESTORE DATABASE;
RECOVER DATABASE;

DELETE BACKUP;