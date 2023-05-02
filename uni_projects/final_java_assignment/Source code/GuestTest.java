
import java.util.ArrayList;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.function.Executable;

/**
 * The test class GuestTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class GuestTest
{
    /**
     * Default constructor for test class GuestTest
     */
    public GuestTest()
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
        Guest guest1 = new Guest();
        assertEquals("", guest1.getFirstName());
    }

    @Test
    public void testGetLastName()
    {
        Guest guest1 = new Guest();
        assertEquals("", guest1.getLastName());
    }

    @Test
    public void testGetLibraryAccess()
    {
        Guest guest1 = new Guest();
        assertEquals(0, guest1.getLibraryAccess());
    }

    @Test
    public void testGetBorrowedResources()
    {
        Guest guest1 = new Guest();
        java.util.ArrayList<ElectronicResource> arrayLis1 = new java.util.ArrayList<ElectronicResource>();
        assertEquals(guest1.getBorrowedResources(), arrayLis1);
    }

    @Test
    public void testSetFirstName()
    {
        Guest guest1 = new Guest();
        guest1.setFirstName("Paul");
        assertEquals("Paul", guest1.getFirstName());
    }
    
    @Test
    public void testSetLastName()
    {
        Guest guest1 = new Guest();
        guest1.setLastName("Johnson");
        assertEquals("Johnson", guest1.getLastName());
    }
    
    @Test
    public void testSetLibraryAccess()
    {
        Guest guest1 = new Guest();
        guest1.setLibraryAccess(3);
        assertEquals(3, guest1.getLibraryAccess());
    }
    
    
    @Test
    public void testSetFirstNameThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Guest guest1 = new Guest();
            guest1.setFirstName(null);
        }});
    }
    
    @Test
    public void testSetLastNameThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Guest guest1 = new Guest();
            guest1.setLastName(null);
        }});
    }
    
    @Test
    public void testSetLibraryAccessThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Guest guest1 = new Guest();
            guest1.setLibraryAccess(4);
        }});
    }
    
    @Test
    public void testAddBorrowedResourcesThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Guest guest1 = new Guest();
            guest1.addBorrowedResources(null);
        }});
    }

    @Test
    public void testAddBorrowedResources()
    {
        Guest guest1 = new Guest();
        Member member1 = new Member();
        ElectronicResource electron1 = new ElectronicResource("", "", "", 1999, member1);
        guest1.addBorrowedResources(electron1);
        java.util.ArrayList<ElectronicResource> arrayLis1 = new java.util.ArrayList<ElectronicResource>();
        arrayLis1.add(electron1);
        assertEquals(arrayLis1, guest1.getBorrowedResources());
    }
}






