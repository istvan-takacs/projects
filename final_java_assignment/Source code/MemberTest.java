

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.function.Executable;

/**
 * The test class MemberTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class MemberTest
{
    /**
     * Default constructor for test class MemberTest
     */
    public MemberTest()
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
    public void testGetFirstName()
    {
        Member member1 = new Member();
        assertEquals("", member1.getFirstName());
    }
    
    @Test
    public void testGetLastName()
    {
        Member member1 = new Member();
        assertEquals("", member1.getLastName());
    }
    
    @Test
    public void testGetId()
    {
        Member member1 = new Member();
        assertEquals(0, member1.getId());
    }
    
    @Test
    public void testGetBorrowedBooks()
    {
        Member member1 = new Member();
        java.util.ArrayList<Book> arrayLis1 = new java.util.ArrayList<Book>();
        assertEquals(arrayLis1, member1.getBorrowedBooks());
    }
    
    @Test
    public void testGetBorrowedResources()
    {
        Member member1 = new Member();
        java.util.ArrayList<ElectronicResource> arrayLis1 = new java.util.ArrayList<ElectronicResource>();
        assertEquals(arrayLis1, member1.getBorrowedResources());
    }
    
    @Test
    public void testGetMessages()
    {
        Member member1 = new Member();
        java.util.ArrayList<String> arrayLis1 = new java.util.ArrayList<String>();
        assertEquals(arrayLis1, member1.getMessages());
    }
    
    @Test
    public void testSetFirstName()
    {
        Member member1 = new Member();
        member1.setFirstName("Paul");
        assertEquals("Paul", member1.getFirstName());
    }
    
    @Test
    public void testSetFirstNameThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Member member1 = new Member();
            member1.setFirstName(null);
        }});
    }
    
    public void testSetLastName()
    {
        Member member1 = new Member();
        member1.setLastName("Johnson");
        assertEquals("Johnson", member1.getLastName());
    }
    
    @Test
    public void testSetLastNameThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Member member1 = new Member();
            member1.setLastName(null);
        }});
    }
    
    public void testSetId()
    {
        Member member1 = new Member();
        member1.setId(3);
        assertEquals(3, member1.getId());
    }

    @Test
    public void testAddBorrowedBooks()
    {
        Member member1 = new Member();
        java.util.ArrayList<String> arrayLis1 = new java.util.ArrayList<String>();
        Book book1 = new Book("", "", "", 2000, member1, arrayLis1);
        member1.addBorrowedBooks(book1);
        java.util.ArrayList<Book> arrayLis2 = new java.util.ArrayList<Book>();
        arrayLis2.add(book1);
        assertEquals(arrayLis2, member1.getBorrowedBooks());
    }
    
    @Test
    public void testAddBorrowedBooksThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Member member1 = new Member();
            member1.addBorrowedBooks(null);
        }});
    }
    
    @Test
    public void testAddBorrowedResources()
    {
        Member member1 = new Member();
        ElectronicResource electron1 = new ElectronicResource("", "", "", 2000, member1);
        member1.addBorrowedResources(electron1);
        java.util.ArrayList<ElectronicResource> arrayLis2 = new java.util.ArrayList<ElectronicResource>();
        arrayLis2.add(electron1);
        assertEquals(arrayLis2, member1.getBorrowedResources());
    }
    
    @Test
    public void testAddBorrowedResourcesThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Member member1 = new Member();
            member1.addBorrowedResources(null);
        }});
    }

    @Test
    public void testAddMessages()
    {
        Member member1 = new Member();
        member1.addMessages("Important message");
        java.util.ArrayList<String> arrayLis1 = new java.util.ArrayList<String>();
        arrayLis1.add("Important message");
        assertEquals(arrayLis1, member1.getMessages());
    }
    
    @Test
    public void testAddMessagesThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Member member1 = new Member();
            member1.addMessages(null);
        }});
    }

    @Test
    public void testNumberOfBorrowedBooks()
    {
        Member member1 = new Member();
        java.util.ArrayList<String> arrayLis1 = new java.util.ArrayList<String>();
        Book book1 = new Book("", "", "", 1999, member1, arrayLis1);
        member1.addBorrowedBooks(book1);
        assertEquals(1, member1.numberOfBorrowedBooks());
        Book book2 = new Book("", "", "", 1992, member1, arrayLis1);
        member1.addBorrowedBooks(book2);
        assertEquals(2, member1.numberOfBorrowedBooks());
    }
}




