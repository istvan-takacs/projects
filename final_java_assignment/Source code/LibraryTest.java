

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.function.Executable;

/**
 * The test class LibraryTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class LibraryTest
{
    /**
     * Default constructor for test class LibraryTest
     */
    public LibraryTest()
    {
    }

    /**
     * Sets up the test fixture.
     *
     * Called before every test case method.
     */
    @BeforeEach
    public void setUp()
    {
    }

    /**
     * Tears down the test fixture.
     *
     * Called after every test case method.
     */
    @AfterEach
    public void tearDown()
    {
    }

    @Test
    public void testGetDescription()
    {
        Library library1 = new Library();
        assertEquals("The library stores a variety of resources such as online journal articles and physical books and is open to both members and non-members.", library1.getDescription());
    }

    @Test
    public void testGetCatalogue()
    {
        Library library1 = new Library();
        java.util.ArrayList<Resource> arrayLis1 = new java.util.ArrayList<Resource>();
        assertEquals(arrayLis1, library1.getCatalogue());
    }

    @Test
    public void testSetDescription()
    {
        Library library1 = new Library();
        library1.setDescription("");
        assertEquals("", library1.getDescription());
    }
    
    @Test
    public void testSetDescriptionThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            library1.setDescription(null);
        }});
    }

    @Test
    public void testAddResource()
    {
        Library library1 = new Library();
        Book book1 = new Book("", "", "", 2000, null, null);
        library1.addResource(book1);
        java.util.ArrayList<Resource> arrayLis1 = new java.util.ArrayList<Resource>();
        arrayLis1.add(book1);
        assertEquals(arrayLis1, library1.getCatalogue());
    }
    
    @Test
    public void testAddResourceThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            Book book1 = new Book("", "", "", 2000, null, null);
            library1.addResource(null);
        }});
    }

    @Test
    public void testCheckIfContains()
    {
        Library library1 = new Library();
        Book book1 = new Book("", "", "", 1999, null, null);
        ElectronicResource electron1 = new ElectronicResource("", "", "", 2000, null);
        library1.addResource(electron1);
        assertEquals(false, library1.checkIfContains(book1));
        assertEquals(true, library1.checkIfContains(electron1));
    }
    
    @Test
    public void testCheckIfContainsThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            library1.checkIfContains(null);
        }});
    }

    @Test
    public void testEditTitle()
    {
        Library library1 = new Library();
        Book book1 = new Book("", "", "", 1999, null, null);
        ElectronicResource electron1 = new ElectronicResource("", "", "", 1999, null);
        library1.addResource(electron1);
        library1.editTitle(electron1, "new title");
        assertEquals("new title", electron1.getTitle());
    }
    
    @Test
    public void testEditTitleThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            Book book1 = new Book("", "", "", 1999, null, null);
            library1.editTitle(book1,null);
        }});
    }
    
    @Test
    public void testSearchTitleThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            library1.searchTitle(null);
        }});
    }
    
    @Test
    public void testSearchAuthorNameThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            library1.searchAuthorName(null);
        }});
    }
    
    

    @Test
    public void testRemoveResourceByObject()
    {
        Library library1 = new Library();
        ElectronicResource electron1 = new ElectronicResource("", "", "", 1999, null);
        library1.addResource(electron1);
        library1.removeResourceByObject(electron1);
        java.util.ArrayList<Resource> arrayLis1 = new java.util.ArrayList<Resource>();
        arrayLis1.add(electron1);
        arrayLis1.remove(electron1);
        assertEquals(arrayLis1, library1.getCatalogue());
    }
    
    @Test
    public void testRemoveResourceByObjectThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            library1.removeResourceByObject(null);
        }});
    }

    @Test
    public void testRemoveResourceByIndex()
    {
        Library library1 = new Library();
        Book book1 = new Book("", "", "", 2001, null, null);
        library1.addResource(book1);
        ElectronicResource electron1 = new ElectronicResource("", "", "", 1999, null);
        library1.addResource(electron1);
        library1.removeResourceByIndex(1);
        java.util.ArrayList<Resource> arrayLis1 = new java.util.ArrayList<Resource>();
        arrayLis1.add(book1);
        assertEquals(arrayLis1, library1.getCatalogue());
    }
    
    @Test
    public void testRemoveResourceByIndexThrowsError() 
    {
        assertThrows(IndexOutOfBoundsException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            Book book1 = new Book("", "", "", 2001, null, null);
            library1.addResource(book1);
            library1.removeResourceByIndex(1);
        }});
    }

    @Test
    public void testNumberOfCatalogueObjects()
    {
        Library library1 = new Library();
        ElectronicResource electron1 = new ElectronicResource("", "", "", 1999, null);
        Book book1 = new Book("", "", "", 1908, null, null);
        library1.addResource(electron1);
        library1.addResource(book1);
        assertEquals(2, library1.numberOfCatalogueObjects());
    }

    @Test
    public void testLendBook()
    {
        Library library1 = new Library();
        Member member1 = new Member();
        Book book1 = new Book("", "", "", 1999, null, null);
        library1.addResource(book1);
        library1.lendBook(book1, member1);
        assertEquals(member1, book1.getMember());
        java.util.ArrayList<Resource> arrayLis1 = new java.util.ArrayList<Resource>();
        arrayLis1.add(book1);
        assertEquals(arrayLis1, member1.getBorrowedBooks());
    }
    
    @Test
    public void testLendBookThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            Member member1 = new Member();
            library1.lendBook(null, member1);
        }});
    }

    @Test
    public void testAccceptBookReturn()
    {
        Library library1 = new Library();
        java.util.ArrayList<String> arrayLis1 = new java.util.ArrayList<String>();
        Book book1 = new Book("", "", "", 2001, null, arrayLis1);
        Member member1 = new Member();
        library1.addResource(book1);
        library1.lendBook(book1, member1);
        library1.acceptBookReturn(book1, true, "Missing pages: 41-76");
        assertEquals(null, book1.getMember());
        arrayLis1.add("Missing pages: 41-76");
        assertEquals(arrayLis1, book1.getListOfDamages());
    }
    
    @Test
    public void testAcceptBookReturnThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            library1.acceptBookReturn(null, true, "Missing pages: 41-76");
        }});
    }

    @Test
    public void testSendMessage()
    {
        Library library1 = new Library();
        Book book2 = new Book("", "", "", 1990, null, null);
        Member member2 = new Member();
        java.util.ArrayList<String> arrayLis2 = new java.util.ArrayList<String>();
        library1.addResource(book2);
        assertEquals(arrayLis2, member2.getMessages());
        library1.lendBook(book2, member2);
        library1.sendMessage("Hello!");
        arrayLis2.add("Hello!");
        assertEquals(arrayLis2, member2.getMessages());
    }
    
    @Test
    public void testSendMessageThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Library library1 = new Library();
            library1.sendMessage(null);
        }});
    }
}













