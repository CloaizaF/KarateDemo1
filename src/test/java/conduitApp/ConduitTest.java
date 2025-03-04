package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

//import com.intuit.karate.junit5.Karate;
//import com.intuit.karate.junit5.Karate.Test;

public class ConduitTest {

    /*@Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }*/

    /*@Karate.Test
    Karate testTags() {
        return Karate.run().tags("@debug").relativeTo(getClass());
    }*/

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp")
                .parallel(3);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
