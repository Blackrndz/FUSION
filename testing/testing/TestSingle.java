package testing;

import java.io.*; 
import java.util.*; 
import java.net.*;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import org.apache.commons.io.*;
import java.util.concurrent.*;
import java.text.NumberFormat;
import java.util.concurrent.atomic.AtomicInteger;
 
public class TestSingle
{   
	public static void main(String[] args) throws Throwable
	{
		int index = 0;
		final String wsdlUrl = args[index++];
		final String configuratorUserName = args[index++]; 
		final String configuratorUserPassword = args[index++];
		final String jdbcString = args[index++];
		
		URL url = new URL(wsdlUrl);
		QName qname = new QName("http://ws.configurator.rapidesuite.com/", "RESWS");
		Service service = Service.create(url, qname);
		final RESWS r = service.getPort(RESWS.class);
		//List<String> projects = r.getProjectNames(configuratorUserName, configuratorUserPassword);
		//System.out.println("projects size: "+projects.size());
		
		int jobId=r.submitJobValidateInventoryReverseSQLMismatch(configuratorUserName, configuratorUserPassword,jdbcString,"12.2.4-trunk_Jenkins-rev45583.builtOn-2015.01.12-11.04.05.143-ICT-pid000003");
		System.out.println("jobId: "+jobId);
		
		Job job = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId);
        System.out.println("jobStatus: "+job.status);
		 final StringBuffer accumulatedOutput = new StringBuffer();
		//if ( !job.status.equals(JobSTATUS.COMPLETED) )
       // {
            JobOutput jobOutput = r.getJobOutput(configuratorUserName, configuratorUserPassword, jobId);
            synchronized(accumulatedOutput)
            {
                accumulatedOutput.append(jobOutput.getHumanReadableOutput());
				System.out.println("output: "+jobOutput.getHumanReadableOutput());
			}
       //     return;
       // }
    }
	
	 private static boolean jobIsCompletedOrFailed(Job job)
    {
        return job.status.equals(JobSTATUS.CANCELED) || job.status.equals(JobSTATUS.COMPLETED) || job.status.equals(JobSTATUS.DELETED) || job.status.equals(JobSTATUS.FAILED);
    }
	private static Job waitForJobCompletion(RESWS r, String configuratorUserName, String configuratorUserPassword, int jobId) throws Throwable
    {
        Job job = r.getJobDetails(configuratorUserName,configuratorUserPassword, jobId);
        while ( !jobIsCompletedOrFailed(job) )
        {
            try
            {
                Thread.sleep(1000);
            }
            catch(java.lang.Exception e)
            {
                throw new java.lang.Error(e);
            }
            job = r.getJobDetails(configuratorUserName,configuratorUserPassword, jobId);
        }
        return job;
    }
        
}