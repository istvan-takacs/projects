import java.util.ArrayList;

/**
 * Class to represent person with full access to the library
 *
 * @author Istvan Takacs
 * @version 12/12/2022
 */
public class Member
{
    //First name
    private String firstName;
    //Last name
    private String lastName;
    //Library ID
    private int id;
    //List of borrowed books
    private ArrayList<Book> borrowedBooks;
    //List of borrowed electronic resources
    private ArrayList<ElectronicResource> borrowedResources;
    //List of messages
    private ArrayList<String> messages;

    /**
     * Constructor for objects of class Member
     */
    public Member()
    {
          firstName = "";
          lastName = "";
          id = 0;
          borrowedBooks = new ArrayList<Book>();
          borrowedResources = new ArrayList<ElectronicResource>();
          messages = new ArrayList<String>();
    }

    /**
     * Getter method for first name
     * @return first name
     */
    public String getFirstName()
    {
        return firstName;
    }
    
    /**
     * Getter method for last name
     * @return last name
     */
    public String getLastName()
    {
        return lastName;
    }
    
    /**
     * Getter method for library ID
     * @return Library ID
     */
    public int getId()
    {
        return id;
    }
    
    /**
     * Getter method for the array of books borrowed
     * @return ArrayList of borrowed books
     */
    public ArrayList<Book> getBorrowedBooks()
    {
        return borrowedBooks;
    }
    
    /**
     * Getter method for the array of electronic resources borrowed
     * @return ArrayList of borrowed electronic resources
     */
    public ArrayList<ElectronicResource> getBorrowedResources()
    {
        return borrowedResources;
    }
    
    /**
     * Getter method for the array of messages/notifications received
     * @return ArrayList of messages/notifications
     */
    public ArrayList<String> getMessages()
    {
        return messages;
    }
    
    /**
     * Setter method for first name
     * @return first name
     * @throws IllegalArgumentException Input value can not be null
     */
    public void setFirstName(String newFirstName)
        throws IllegalArgumentException
    {
        if (newFirstName == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            firstName = newFirstName;
        }
    }
    
    /**
     * Setter method for last name
     * @return last name
     * @throws IllegalArgumentException Input value can not be null
     */
    public void setLastName(String newLastName)
        throws IllegalArgumentException
    {
        if (newLastName == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            lastName = newLastName;
        }
    }
    
    /**
     * Setter method for library ID
     * @return library ID
     */
    public void setId(int newId)
    {
        id = newId;
    }
    
    /**
     * Setter method for borrowed books
     * @param resource Input book
     * @throws IllegalArgumentException Input value can not be null
     */
    public void addBorrowedBooks(Book book)
        throws IllegalArgumentException
    {
        if (book == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            if (borrowedBooks.contains(book)) {
            // If the object is already in the ArrayList prints error message
            System.out.println("The book has already been added!");
        } else {
            // If the object is not in the array, adds it to the ArrayList
            borrowedBooks.add(book);
        }
        }
    }
    
    /**
     * Setter method for borrowed electronic resources
     * @param resource Input electronic resources
     * @throws IllegalArgumentException Input value can not be null
     */
    public void addBorrowedResources(ElectronicResource resource)
        throws IllegalArgumentException
    {
        if (resource == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
           if (borrowedResources.contains(resource)) {
            // If the object is already in the ArrayList prints error message
            System.out.println("The resource has already been added!");
        } else {
            // If the object is not in the array, adds it to the ArrayList
            borrowedResources.add(resource);
        } 
        }
    }
    
    /**
     * Setter method for messages/notifications
     * @param resource Input message
     * @throws IllegalArgumentException Input value can not be null
     */
    public void addMessages(String message)
        throws IllegalArgumentException
    {
        if (message == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            if (messages.contains(message)) {
            // If the object is already in the ArrayList prints error message
            System.out.println("The message is already contained in the list!");
        } else {
            // If the object is not in the array, adds it to the ArrayList
            messages.add(message);
        }  
        }
    }
    
    /**
     * Method to print out all details of a member
     */
    public void printAllDetails()
    {
        System.out.println("First Name: " + firstName);
        System.out.println("Last Name: " + lastName);
        System.out.println("Id: " + id);
        System.out.println("The list of curently borrowed books: ");
        printBorrowedBooksDetails();
        System.out.println("The list of curently borrowed electronic resources are: ");
        for (ElectronicResource resource : borrowedResources) {
            resource.printAllDetails();
        }
        System.out.println("The messages/notifications received: ");
        printMessages();
    }
    
    /**
     * Method to print out all messages/notifications
     */
    public void printMessages()
    {
        for (String message : messages) {
            System.out.println("message");
        }
    }
    
    /**
     * Method to print out borrowed book details
     */
    public void printBorrowedBooksDetails()
    {
        for (Book book : borrowedBooks) {
            book.printAllDetails();
        }
    }
    
    /**
     * Method to print out number of borrowed books
     * @return number of boroowed books
     */
    public int numberOfBorrowedBooks()
    {
        return borrowedBooks.size();
    }
    
}
