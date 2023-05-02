import java.util.ArrayList;

/**
 * Class to represent a library system.
 *
 * @author Istvan Takacs
 * @version 12/12/2022
 */
public class Library
{
    // Description of library
    private String description;
    // ArrayList of all resources in the library
    private ArrayList<Resource> catalogue;

    /**
     * Constructor for objects of class Library
     */
    public Library()
    {
        description = "The library stores a variety of resources such as online journal articles and physical books and is open to both members and non-members.";
        catalogue = new ArrayList<Resource>();
    }
    
    /**
     * Getter method for description
     * @return description
     */
    public String getDescription()
    {
     return description;
    }
    
    /**
     * Getter method for library catalogue
     * @return catalogue
     */
    public ArrayList<Resource> getCatalogue()
    {
        return catalogue;
    }
    
    /**
     * Setter method for description
     * @param newDescription
     * @throws IllegalArgumentException Input value can not be null
     */
    public void setDescription(String newDescription)
        throws IllegalArgumentException
    {
        if (newDescription == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            description = newDescription;
        }
    }
    
    /**
     * Setter method for adding a resource to the catalogue
     * @param resource
     * @throws IllegalArgumentException Input value can not be null
     */    
    public void addResource(Resource resource)
        throws IllegalArgumentException
    {
        if (resource == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            if (catalogue.contains(resource)) {
            // If the object is already in the ArrayList prints error message
            System.out.println("The resource has already been added!");
        } else {
            // If the object is not in the array, adds it to the ArrayList
            catalogue.add(resource);
        }
        }
    }
    
    /**
     * Method to print all details of the data fields of the library
     */
    public void printAllDetails()
    {
        System.out.println("Library description: " + description);
        for (Resource resource : catalogue) {
            resource.printAllDetails();
        }
    }
    
    /**
     * Method to check whether a resource is in the library catalogue
     * @param resource Key for the search in the catalogue
     * @return boolean of whether the catalogue contains the element or not
     * @throws IllegalArgumentException Input value can not be null
     */
    public boolean checkIfContains(Resource resource)
        throws IllegalArgumentException
    {
        if (resource == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            return catalogue.contains(resource);    
        }
    }  
    
    /**
     * Method to edit the title of a resource
     * @param resource The resource whose title is changed
     * @param newTitle The newTitle replacing the old one
     * @throws IllegalArgumentException Input value can not be null
     */
    public void editTitle(Resource resource, String newTitle)
        throws IllegalArgumentException
    {
        if (resource == null || newTitle == null) {
            // Neither of the input values are allowed to be null
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            if (checkIfContains(resource)) {
                resource.setTitle(newTitle);
            } else {
                System.out.println("Resource is not in the catalogue!");
            }
        }
    }
    
    /**
     * Method to search for a title of a resource within the catalogue then print out the number and details of the found resources
     * @param title Title of the resource
     * @throws IllegalArgumentException Input value can not be null
     */
    public void searchTitle(String title)
        throws IllegalArgumentException
    {
        if (title == null ) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            int i = 0; // initiate counter 
            for (Resource resource : catalogue) {
                if (resource.getTitle().equals(title)) { //if the given parameter equals the resource title print out the details
                    resource.printAllDetails();
                    i++; // increment counter
                }
            }
            System.out.println(i); //print out counter
        }
    }
    
    /**
     * Method to search for the name of an author within the catalogue then print out the number and details of the found resources
     * @param author
     * @throws IllegalArgumentException Input value can not be null
     */
    public void searchAuthorName(String author)
        throws IllegalArgumentException
    {
        if (author == null ) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            int i = 0; // initiate counter 
            for (Resource resource : catalogue) {
                if (resource.getAuthorName().equals(author)) { //if the given parameter equals the resource title print out the details
                    resource.printAllDetails();
                    i++; //increment counter
                }
            }
            System.out.println(i); //print out counter
        }
    }
    
    /**
     * Method to remove a resource from the catalogue given a parameter resource
     * @param resource The resource we want to remove
     * @throws IllegalArgumentException Input value can not be null
     */
    public void removeResourceByObject(Resource resource)
        throws IllegalArgumentException
    {
        if (resource == null ) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            if (!(checkIfContains(resource))) {
                // If not in the catalogue then print out error message
                System.out.println("Resource is not in the catalogue!");
            } else {
                // Otherwise remove it from the catalogue
                catalogue.remove(resource);
            }
        }
    }
    
    /**
     * Method to remove resource from the catalogue given a parameter index position
     * @param index The index position we want to remove
     * @throws IndexOutOfBoundsException Input index needs to be a valid position in the ArrayList
     */
    public void removeResourceByIndex(int index)
        throws IndexOutOfBoundsException
    {
        if (index >= catalogue.size() || index < 0) {
            throw new IndexOutOfBoundsException("Index is not a valid position in the ArrayList!");
        } else {
            catalogue.remove(index);
        }
    }
    
    /**
     * Method to print out all books that are not on loan
     */
    public void printAvailableBooks()
    {
        for (Resource resource : catalogue) {
            if (resource instanceof Book) { // Only books 
                if (resource.isAvailable()) { // Only available books
                    resource.printAllDetails();
                }
            } else {
                // In case of an electronic resource in the catalogue this will show
                System.out.println("The electronic resource :" + resource.getTitle() + " is currently available.");
            }
        }
    }
    
    /**
     * Method to get the number of objects within the catalogue
     * @return catalogue size
     */
    public int numberOfCatalogueObjects()
    {
        return catalogue.size();
    }
    
    /**
     * Method to simulate lending a book
     * @param book The book to be lent
     * @param member The library member borrowing the book
     * @throws IllegalArgumentException Input value can not be null
     */
    public void lendBook(Book book, Member member)
        throws IllegalArgumentException
    {
        if (book == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            // Lending is enabled by default and is disabled if any of the following conditions are met
            boolean lending = true;
            if (!(checkIfContains(book))) {
                // If the book is not in the catalogue
                System.out.println("The book is not in the catalogue and therefore can not be lent!");
                lending = false;
            } 
            if (!(book.isAvailable())) {
                // If the book is currently on loan
                System.out.println("The book is currently borrowed by another member and therefore can not be lent!");
                lending = false;
            }
            if (member.numberOfBorrowedBooks() >= 5) {
                //If the number of books borrowed by the member is greater than or equal to 5
                System.out.println(member.getFirstName() + " " + member.getLastName() + " can not borrow more than 5 books!");
                lending = false;
            }
            if (lending) {
                // Otherwise lend
                book.setMember(member); // Book object will store the member in its member data field
                member.addBorrowedBooks(book); // Member will add book to their borrowed books ArrayList
            }
        }  
    }
    
    /**
     * Method designed to simulate a book return
     * @param book The book to be returned
     * @param recordDamage Whether a damage to the book should be recorded
     * @param damage The description of the damage
     * @throws IllegalArgumentException Input value can not be null
     */
    public void acceptBookReturn(Book book, boolean recordDamage, String damage)
        throws IllegalArgumentException
    {
        if (book == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            if (!(checkIfContains(book))) {
                // If the book is not in the catalogue
                System.out.println("The book is not in the catalogue and therefore can not be returned!");
            } else {
                // Update the book object's member data field to null in order to indicate its availability again
                book.setMember(null);
                if (recordDamage) {
                    book.addDamage(damage);
                }
            }
        }
    }
    
    /**
     * Method designed to simulate sending a message from the library to all members currently holding books
     * @param message The message intended to be sent
     * @throws IllegalArgumentException Input value can not be null
     */
    public void sendMessage(String message)
        throws IllegalArgumentException
    {
        if (message == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            for (Resource resource : catalogue) {
                // Loops through the catalogue and accesses all rescources that are currently borrowed
                Member member = resource.getMember(); // Variable declared as members who have a resource object stored in their data field
                if (member.numberOfBorrowedBooks() != 0) { // Only contains books because of the definition of the data fields in Member class
                    member.addMessages(message); // Sends message
                }
            }  
            }
    }
    
    /**
     * Method to print all books in the library catalogue
     */
    public void printBooks()
    {
        for (Resource resource : catalogue) {
            // Loops through all resources and selects those that are books
            if (resource instanceof Book) {
                resource.printAllDetails();
            }
        }
    }
    
    /**
     * Method to print all electronic resources in the library catalogue
     */
    public void printElectronicResources()
    {
        for (Resource resource : catalogue) {
            // Loops through all resources and selects those that are electronc resources
            if (resource instanceof ElectronicResource) {
                resource.printAllDetails();
            }
        }
    }
}


        

    


