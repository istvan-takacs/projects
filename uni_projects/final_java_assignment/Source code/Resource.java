
/**
 * Write a description of class Resource here.
 *
 * @author Istvan Takacs
 * @version 12/12/2022
 */
public class Resource
{

    public String ISBN;
    public String authorName;
    public String title;
    public int releaseYear;
    public Member member;
    
    /**
     * Constructor for objects of class Resource
     * @param ISBN The code identifying a resource
     * @param authorName Name of the author
     * @param title Title of the resource
     * @param releaseYear Year in which the resource was first released
     * @param member Library member capable of accessing the resource
     */
    public Resource(String ISBN, String authorName, String title, int releaseYear, Member member)
    {
        // initialise instance variables
        this.ISBN = ISBN;
        this.authorName = authorName;
        this.title = title;
        this.releaseYear = releaseYear;
        this.member = member;
    }
    
    /**
     * Getter method for the ISBN data field
     * @return ISBN
     */
    public String getISBN()
    {
        return ISBN;
    }
    
    /**
     * Getter method for the name of the author
     * @return Author's name
     */
    public String getAuthorName()
    {
        return authorName;
    }
    
    /**
     * Getter method for the title
     * @return Title
     */
    public String getTitle()
    {
        return title;
    }
    
    /**
     * Getter method for the release year
     * @return Release year
     */
    public int getReleaseYear()
    {
        return releaseYear;
    }
    
    /**
     * Getter method for the Library member
     * @return Library member
     */
    public Member getMember()
    {
        return member;
    }
    
    /**
     * Setter method for the ISBN
     * @param newISBN Input value of new ISBN
     * @throws IllegalArgumentException ISBN can not be null
     */
    public void setISBN(String newISBN)
        throws IllegalArgumentException
    {
        if (newISBN == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            ISBN = newISBN;
        }
    }
    
    /**
     * Setter method for the Author's name
     * @param newAuthorName Input value of new author's name
     * @throws IllegalArgumentException Author's name can not be null
     */
    public void setAuthorName(String newAuthorName)
        throws IllegalArgumentException
    {
        if (newAuthorName == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            authorName = newAuthorName;
        }
    }
    
    /**
     * Setter method for the title
     * @param newTitle Input value of new title
     * @throws IllegalArgumentException Title can not be null
     */
    public void setTitle(String newTitle)
        throws IllegalArgumentException
    {
        if (newTitle == null) {
            throw new IllegalArgumentException("Input value can not be null!");
        } else {
            title = newTitle;
        }
    }
    
    /**
     * Setter method for the release year
     * @param newReleaseYear Input value of new release year
     */
    public void setReleaseYear(int newReleaseYear)
    {
        releaseYear = newReleaseYear;
    }
    
    /**
     * Setter method for the member
     * @param newMember Input value of new release year
     */
    public void setMember(Member newMember) 
    // Allowing newMember == null as in case of the book lending/return we might want to set it to that
    {
        member = newMember;
    }
    
    /**
     * Method to check whether book is available or on loan
     * @return boolean True if available false otherwise
     */
    public boolean isAvailable()
    {
        if (member == null){
            return true;
        } else {
            return false;
        }
    }
    
    /**
     * Method to print out all the details of a resource
     */
    public void printAllDetails()
    {
        System.out.println("ISBN: " + ISBN);
        System.out.println("Title: " + title);
        System.out.println("Author's name: " + authorName);
        System.out.println("Release year: " + releaseYear);
        if (!(isAvailable())) {
            // If it is on loan prints out the name of the member
            System.out.println("User: " + member.getFirstName() + " " + member.getLastName());
        } else {
            System.out.println("Currently not on loan!");
        }
    }
}
