package brlyman;

import org.junit.runner.notification.Failure;
import org.junit.runner.notification.RunListener;

import java.util.*;

import org.junit.runner.Description;
import org.junit.runner.Result;

import brlyman.results.*;
import brlyman.results.processes.*;

public class TurboListener extends RunListener
{
    public TurboListener(final Logger log)
    {
        this.log = log;
        this.root = new Context("test run");
    }

    public void
    testRunStarted(final Description description) throws Exception
    {
    }

    public void
    testRunFinished(final Result result) throws Exception
    {
        root.apply(new PrintContexts(log));
        if (result.getFailureCount() > 0)
        {
            log.error("Test run failed");
        }
        else
        {
            log.info("Test run succeeded");
        }
    }

    public void
    testStarted(final Description description) throws Exception
    {
    }

    public void
    testFinished(final Description description) throws Exception
    {
        root.addTestResult(
            Arrays.asList(
                description.getClassName().split("\\$")),
            new Pass(
                description.getMethodName()));
    }

    public void
    testFailure(final Failure failure) throws Exception
    {
        root.addTestResult(
            Arrays.asList(
                failure.getDescription().getClassName().split("\\$")),
            new Fail(
                failure.getDescription().getMethodName(),
                failure.getMessage()));
    }

    public void
    testAssumptionFailure(final Failure failure)
    {
        log.error(failure.getMessage());
    }

    public void
    testIgnored(final Description description) throws Exception
    {
        log.warn(description.getMethodName() + " ignored");
    }

    private final Context root;
    private final Logger log;
}
