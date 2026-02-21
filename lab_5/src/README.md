you need to ensure that you have exactly this directory structure

Before running the program make sure that mysqld process in running in background silently and you are able to access it via CLI or GUI in workbench or whatever, just make sure you are able to get it running successfully.

in mysql CLI make sure to run all the commands listed in the .sql file mentioned in the file of this folder, this will initialize the database for you so you can instantiate communication with that connector thingy with Java.

you would need to change details of personal-access to database since our connection strings, user-id and passwd would differ

once changes are made, please run this command in CLI at the current directory where src/ is:

```bash
javac -cp lib/mysql-connector.jar -d src src/App.java
```

this compiles the source code into bytecode and then to finally get the main program running:

```bash
java -cp src:lib/mysql-connector.jar App
```

thes are complicated commands? yes but it instructs JVM to run your application with .jar file, there are simpler ways but this works so let it be.
