import java.util.ArrayList;

/**
 * A class that represents a physical book inheriting from Resource class
 *
 * @author Istvan Takacs
 * @version 12/12/2022
 */
public class Book extends Resource
{
    // List of damages dealt to the book
    private ArrayList<String> listOfDamages;

    /**
     * Constructor for objects of class Book
     * @param ISBN The code identifying a book
     * @param authorName Name of the author
     * @param title Title of the book
     * @param releaseYear Year in which the book was first released
     * @param member Library member capable of borrowing the book
     */
    public Book(String ISBN, String authorName, String title, int releaseYear, Member member, ArrayList<String> listOfDamages)
    {
        super(ISBN, authorName, title, releaseYear, member);
        this.listOfDamages = listOfDamages;
    }

    /**
     * Getter method for the listOfDamages data field
     * @return An ArrayList of String representation of damages
     */
    public ArrayList<String> getListOfDamages()
    {
        return listOfDamages;
    }
    
    /**
     * Setter method for the listOfDamages data field
     * @param damage A String representation of damage dealt to the Book object
     */ 
    public void addDamage(String damage)
    {
        if (listOfDamages.contains(damage)) {
            // If the object is already in the ArrayList prints error message
            System.out.println("The damage has already been recorded!");
        } else {
            // If the object is not in the array, adds it to the ArrayList
            listOfDamages.add(damage);
        }
    }
    
    /**
     * Method to print out all the details of a Book
     */
    public void printAllDetails()
    {
        if (isAvailable()) {
            // If object is not currently on loan print out both the inherited and own data field values
            super.printAllDetails();
            System.out.println("List of damages: " + listOfDamages);
        } else {
            System.out.println("The book is currently on loan!");
        }
    }
}
