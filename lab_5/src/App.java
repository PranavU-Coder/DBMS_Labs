import java.sql.*;
import java.util.Scanner;

public class App {

    // You are supposed to replace this with your database that you create & user and password
    static final String URL      = "jdbc:mysql://localhost:3306/university";
    static final String USER     = "root";
    // normally I am very careful about sharing passwords in public codebases but fuck it, who cares
    static final String PASSWORD = "Root@1234";

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        try {
            Connection con  = DriverManager.getConnection(URL, USER, PASSWORD);
            Statement  stmt = con.createStatement();

            while (true) {
                System.out.println("\n===== UNIVERSITY MENU =====");
                System.out.println("1. Insert");
                System.out.println("2. Update Salary");
                System.out.println("3. Delete");
                System.out.println("4. Display");
                System.out.println("5. Exit");
                System.out.print("Enter choice: ");

                int choice = sc.nextInt();

                switch (choice) {

                    case 1:
                        System.out.print("ID: ");
                        int id = sc.nextInt();
                        sc.nextLine();

                        System.out.print("Name: ");
                        String name = sc.nextLine();

                        System.out.print("Dept: ");
                        String dept = sc.nextLine();

                        System.out.print("Salary: ");
                        int salary = sc.nextInt();

                        String insert = "INSERT INTO Instructor VALUES("
                                + id + ",'"
                                + name + "','"
                                + dept + "',"
                                + salary + ")";

                        stmt.executeUpdate(insert);
                        System.out.println("Inserted!");
                        break;

                    case 2:
                        System.out.print("ID: ");
                        int uid = sc.nextInt();

                        System.out.print("New Salary: ");
                        int newSalary = sc.nextInt();

                        stmt.executeUpdate(
                            "UPDATE Instructor SET salary=" + newSalary + " WHERE ID=" + uid
                        );
                        System.out.println("Updated!");
                        break;

                    case 3:
                        System.out.print("ID to delete: ");
                        int did = sc.nextInt();

                        stmt.executeUpdate(
                            "DELETE FROM Instructor WHERE ID=" + did
                        );
                        System.out.println("Deleted!");
                        break;

                    case 4:
                        ResultSet rs = stmt.executeQuery("SELECT * FROM Instructor");

                        System.out.println("\nID   Name             Dept             Salary");
                        System.out.println("------------------------------------------------");

                        while (rs.next()) {
                            System.out.printf("%-5d %-16s %-16s %d%n",
                                rs.getInt("ID"),
                                rs.getString("name"),
                                rs.getString("dept_name"),
                                rs.getInt("salary")
                            );
                        }
                        break;

                    case 5:
                        con.close();
                        System.out.println("Goodbye!");
                        System.exit(0);

                    default:
                        System.out.println("Invalid choice. Please enter 1-5.");
                }
            }

        } catch (Exception e) {
            System.out.println("No Database Connectivity");
            e.printStackTrace();
        }
    }
}
