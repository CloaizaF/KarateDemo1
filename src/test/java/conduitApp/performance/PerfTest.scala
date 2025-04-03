package performance;

import com.intuit.karate.gatling.javaapi.KarateProtocolBuilder;

import io.gatling.javaapi.core.ScenarioBuilder;
import io.gatling.javaapi.core.Simulation;

import static io.gatling.javaapi.core.CoreDsl.*;
import static com.intuit.karate.gatling.javaapi.KarateDsl.*;

public class PerfTest extends Simulation {

  public PerfTest() {
      
    KarateProtocolBuilder protocol = karateProtocol();

    //protocol.nameResolver = (req, ctx) -> req.getHeader("karate-name");
    //protocol.runner.karateEnv("perf");

    ScenarioBuilder createArticle = scenario("Create and Delete").exec(karateFeature("classpath:conduitApp/performance/data/createArticle.feature"));

    setUp(
      createArticle.injectOpen(
        atOnceUsers(1)
        ).protocols(protocol)
    );
  }
}