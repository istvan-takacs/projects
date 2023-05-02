

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.function.Executable;

/**
 * The test class ResourceTest.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class ResourceTest
{
    /**
     * Default constructor for test class ResourceTest
     */
    public ResourceTest()
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
    public void testGetISBN()
    {
        Member member1 = new Member();
        Resource resource1 = new Resource("", "", "", 2000, member1);
        assertEquals("", resource1.getISBN());
    }
    
    @Test
    public void testGetAuthorName()
    {
        Member member1 = new Member();
        Resource resource1 = new Resource("", "", "", 2000, member1);
        assertEquals("", resource1.getAuthorName());
    }
    
    @Test
    public void testGetTitle()
    {
        Member member1 = new Member();
        Resource resource1 = new Resource("", "", "", 2000, member1);
        assertEquals("", resource1.getTitle());
    }
    
    @Test
    public void testGetReleaseYear()
    {
        Member member1 = new Member();
        Resource resource1 = new Resource("", "", "", 2000, member1);
        assertEquals(2000, resource1.getReleaseYear());
    }
    
    @Test
    public void testGetMember()
    {
        Member member1 = new Member();
        Resource resource1 = new Resource("", "", "", 2000, member1);
        assertEquals(member1, resource1.getMember());
    }

    @Test
    public void testSetISBN()
    {
        Member member1 = new Member();
        Resource resource1 = new Resource("", "", "", 1999, member1);
        resource1.setISBN("new ISBN");
        assertEquals("new ISBN", resource1.getISBN());
    }
    
    @Test
    public void testSetISBNThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Member member1 = new Member();
            Resource resource1 = new Resource("", "", "", 1999, member1);
            resource1.setISBN(null);
        }});
    }
    
    @Test
    public void testSetAuthorName()
    {
        Member member1 = new Member();
        Resource resource1 = new Resource("", "", "", 1999, member1);
        resource1.setAuthorName("new Author");
        assertEquals("new Author", resource1.getAuthorName());
    }
    
    @Test
    public void testSetAuthorNameThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Member member1 = new Member();
            Resource resource1 = new Resource("", "", "", 1999, member1);
            resource1.setAuthorName(null);
        }});
    }
    
    @Test
    public void testSetTitle()
    {
        Member member1 = new Member();
        Resource resource1 = new Resource("", "", "", 1999, member1);
        resource1.setTitle("new Title");
        assertEquals("new Title", resource1.getTitle());
    }
    
    @Test
    public void testSetTitleThrowsError() 
    {
        assertThrows(IllegalArgumentException.class, new Executable() {
            public void execute() throws Throwable {
            Member member1 = new Member();
            Resource resource1 = new Resource("", "", "", 1999, member1);
            resource1.setTitle(null);
        }});
    }
    
    @Test
    public void testSetReleaseYear()
    {
        Member member1 = new Member();
        Resource resource1 = new Resource("", "", "", 1999, member1);
        resource1.setReleaseYear(2000);
        assertEquals(2000, resource1.getReleaseYear());
    }
    
    @Test
    public void testSetMember()
    {
        Member member1 = new Member();
        Member member2 = new Member();
        Resource resource1 = new Resource("", "", "", 1999, member1);
        resource1.setMember(member2);
        assertEquals(member2, resource1.getMember());
    }
    
    
    @Test
    public void testIsAvailable()
    {
        Resource resource1 = new Resource("", "", "", 2000, null);
        assertEquals(true, resource1.isAvailable());
        Member member1 = new Member();
        resource1.setMember(member1);
        assertEquals(false, resource1.isAvailable());
    }
}



