# CodeQuest

CodeQuest is a Java 17 Jakarta web application. It runs with embedded Tomcat and uses MySQL.

## Run locally

1. Install Java 17+, Maven, and MySQL.
2. Create the database tables from `database/schema.sql` (for example, `mysql -u root -p < database/schema.sql`).
3. Start the app with `./run.sh`.
4. Open <http://localhost:8080/>.

The database connection defaults to `jdbc:mysql://localhost:3306/codequest_db`, user `root`, password `root` to match the original Eclipse project. Override these with `CODEQUEST_DB_URL`, `CODEQUEST_DB_USER`, and `CODEQUEST_DB_PASSWORD`. Set `PORT` to change the HTTP port.

The schema creates the tables used by the app. It does not create an admin account; add one to the `admins` table before using admin pages.
