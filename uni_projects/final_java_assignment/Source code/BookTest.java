

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.function.Executable;

/**
 * The test class BookTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class BookTest
{
    /**
     * Default constructor for test class BookTest
     */
    public BookTest()
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
    public void testGetListOfDamages()
    {
        java.util.ArrayList<String> arrayLis1 = new java.util.ArrayList<String>();
        Book book1 = new Book("", "", "", 2000, null, arrayLis1);
        assertEquals(arrayLis1, book1.getListOfDamages());
    }

    @Test
    public void testAddDamage()
    {
        java.util.ArrayList<String> arrayLis1 = new java.util.ArrayList<String>();
        Book book1 = new Book("", "", "", 2000, null, arrayLis1);
        book1.addDamage("Water damage on page 34");
        arrayLis1.add("Water damage on page 34");
        assertEquals(arrayLis1, book1.getListOfDamages());
    }
}


