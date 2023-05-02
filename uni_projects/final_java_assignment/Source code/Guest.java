import java.util.ArrayList;

/**
 * Class to represent a person with limited access to the library
 *
 * @author Istvan Takacs
 * @version 12/12/2022
 */
public class Guest
{
    // First name of guest
    private String firstName;
    // Last name of guest
    private String lastName;
    // Number of days of library access
    private int libraryAccess;
    // An ArrayList of borrowed electronic resources
    private ArrayList<ElectronicResource> borrowedResources;

    /**
     * Constructor for objects of class Guest
     * 
     */
    public Guest()
    {
       firstName = "";
       lastName = "";
       libraryAccess = 0;
       borrowedResources = new ArrayList<ElectronicResource>();
    }

    /**
     * Getter method of first name
     * @return First name
     */
    public String getFirstName()
    {
        return firstName;
    }
    
    /**
     * Getter method of last name
     * @return Last name
     */
    public String getLastName()
    {
        return lastName;
    }
    
    /**
     * Getter method of library access
     * @return Library access in number of days 
     */
    public int getLibraryAccess()
    {
        return libraryAccess;
    }
    
    /**
     * Getter method for the list of borrowed electronic resources
     * @return ArrayList of electronic resources
     */
    public ArrayList<ElectronicResource> getBorrowedResources()
    {
        return borrowedResources;
    }
    
    /**
     * Setter method for first name
     * @param newFirstName Changed first name
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
     * @param newLastName Changed last name
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
     * Setter method for library access
     * @param newLibraryAccess library access in days
     * @throws IllegalArgumentException Library access for guests/visitors can not be longer than 3 days!
     */
    public void setLibraryAccess(int newLibraryAccess)
        throws IllegalArgumentException
    {
        if (newLibraryAccess > 3) {
           throw new IllegalArgumentException("Library access for guests/visitors can not be longer than 3 days!");
       } else {
           libraryAccess = newLibraryAccess;
       }
    }
    
    /**
     * Setter method for borrowed resources
     * @param resource Input electronic resource
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
        }  else {
            // If the object is not in the array, adds it to the ArrayList
            borrowedResources.add(resource);
            }
        }
    }
}
