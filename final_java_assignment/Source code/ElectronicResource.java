
/**
 * A class that represents an electronic resource inheriting from Resource class
 *
 * @author Istvan Takacs
 * @version 12/12/2022
 */
public class ElectronicResource extends Resource
{
    //Indicates whether the resource can be downloaded or not
    private boolean downloadable;

    /**
     * Constructor for objects of class ElectronicResource
     * @param ISBN The code identifying an electronic resource
     * @param authorName Name of the author
     * @param title Title of the electronic resource
     * @param releaseYear Year in which the electronic resource was first released
     * @param member Library member capable of accessing the electronic resource
     */
    public ElectronicResource(String ISBN, String authorName, String title, int releaseYear, Member member)
    {
        super(ISBN, authorName, title, releaseYear, member);
        downloadable = true;
    }

    /**
     * Getter method for the downloadable data field
     * @return A boolean signalling whether the electronic resource can be dowloaded or not
     */
    public boolean getDownloadable()
    {
        return downloadable;
    }
    
    /**
     * Setter method for the downloadable data field
     * @param bool A new boolean value for the data field
     */
    public void setDownloadable(boolean bool)
    {
        downloadable = bool;
    }
    
    /**
     * Method to print all details of all the data fields whether inherited or not
     */
    public void printAllDetails()
    {
        super.printAllDetails();
        System.out.println("Downloadability: " + downloadable);
    }
}

