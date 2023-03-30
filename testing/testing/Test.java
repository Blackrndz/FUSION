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
 
public class Test
{   
	public static void main(String[] args) throws Throwable
	{
		int index = 0;
		final String outputDir = args[index++];
		final String outputFilename = args[index++];
        final int svnRevision = Integer.parseInt(args[index++]);
		final String wsdlUrl = args[index++];
		final String configuratorUserName = args[index++]; 
		final String configuratorUserPassword = args[index++];
		final String configuratorGroup = args[index++];
		final String testOutputDir = args[index++];
		final String testOutputFileName = args[index++];
        final int concurrentValidationJobCount = Integer.parseInt(args[index++]);
		final String jdbcString = args[index++];

		File testOutputFile = new File(testOutputDir, testOutputFileName);

		URL url = new URL(wsdlUrl);
		QName qname = new QName("http://ws.configurator.rapidesuite.com/", "RESWS");
		Service service = Service.create(url, qname);
		final RESWS r = service.getPort(RESWS.class);
		final List<Throwable> caughtThrowables = new ArrayList<Throwable>();

        String projectNameIfPresent = null;
        final StringBuffer accumulatedOutput = new StringBuffer();
        try
        {
            //final String project = "12.1.3-trunk-rev42547.builtOn-2014.07.30-17.13.48.233-SGT-pid000001";
            final long time = System.currentTimeMillis();
            ExecutorService threadPool;
            final NumberFormat nf = NumberFormat.getNumberInstance();
            final AtomicInteger profileCounter = new AtomicInteger(0);
            ////////////////////////////////////////////////////////////////////////
            //Build a new project
            ////////////////////////////////////////////////////////////////////////

            synchronized(accumulatedOutput)
            {
                accumulatedOutput.append("<br/><br/><b>PROJECT BUILD</b><hr/><br/>");
            }
            byte[] fileData = FileUtils.readFileToByteArray(new File(outputDir, outputFilename));
            int jobId = r.submitJobBuildProject(configuratorUserName, configuratorUserPassword, configuratorGroup, false, outputFilename, fileData);
            Job buildJob = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId);
            final String project = buildJob.getProjectName();
            projectNameIfPresent = project;
            System.err.println("Build Project jobStatus = " + buildJob.getStatus());
            JobOutput jobOutput = r.getJobOutput(configuratorUserName, configuratorUserPassword, jobId);
            projectNameIfPresent = project;
            accumulatedOutput.append(jobOutput.getHumanReadableOutput());
            checkForErrorsAndFailIfPresent(accumulatedOutput.toString(), testOutputFile, caughtThrowables,true);
            System.err.println("Project Name: " + project);

            
            ////////////////////////////////////////////////////////////////////////
            //Generate (but not validate) all non-Foundation, non-BUCC profiles
            ////////////////////////////////////////////////////////////////////////
            synchronized(accumulatedOutput)
            {
                accumulatedOutput.append("<br/><hr/><b>Non-Foundation, Non-BUCC Profile Verification</b><hr/><br/>");
            }
            String buccTablename = r.getRscParameterValue(configuratorUserName, configuratorUserPassword, project, "TABLE_BUCC");
            List<String> distinctLabelsUsedByBuccData = r.getDistinctLabelsUsedByData(configuratorUserName, configuratorUserPassword, project, buccTablename, null);
            List<String> nonFoundationProfileNames = r.getProfileNames(configuratorUserName, configuratorUserPassword, project, false, false);
            List<String> nonFoundationNonBUCCProfileNames = new ArrayList<String>();
            List<String> nonFoundationBUCCProfileNames = new ArrayList<String>();
            for ( final String profileName : nonFoundationProfileNames )
            {
                String profileLabels = r.getProfileLabels(configuratorUserName, configuratorUserPassword, project, profileName);
                boolean isBUCC = false;
                for ( String label : profileLabels.split(",") )
                {
                    //profile contains label in BUCC -> profile requires BUCC -> don't try simple generation
                    if ( distinctLabelsUsedByBuccData.contains(label) )
                    {
                        isBUCC = true;
                        break;
                    }
                }
                if ( !isBUCC )
                {
                    nonFoundationNonBUCCProfileNames.add(profileName);
                }
                else
                {
                    nonFoundationBUCCProfileNames.add(profileName);
                }
            }        
            System.err.println("nonFoundationNonBUCCProfileNames = " + nonFoundationNonBUCCProfileNames);
            System.err.println("nonFoundationBUCCProfileNames = " + nonFoundationBUCCProfileNames);

            final ProfileValidationSelectionSet profileValidationSelectionSet = new ProfileValidationSelectionSet();
            profileValidationSelectionSet.setPcInternalValidation(true); 
            profileValidationSelectionSet.setMandatoryInternalValidation(true); 
            profileValidationSelectionSet.setLengthInternalValidation(true); 
            profileValidationSelectionSet.setDuplicateInternalValidation(true); 
            profileValidationSelectionSet.setLeadingInternalValidation(true); 
            profileValidationSelectionSet.setLookupInternalValidation(true); 
            profileValidationSelectionSet.setTrailingInternalValidation(true); 
            profileValidationSelectionSet.setDoubleQInternalValidation(true); 
            profileValidationSelectionSet.setSubstitutionInternalValidation(true); 
            profileValidationSelectionSet.setNavigationMapInternalValidation(true); 
            profileValidationSelectionSet.setLovInternalValidation(false); 
                        
            threadPool = Executors.newFixedThreadPool(concurrentValidationJobCount);
            profileCounter.set(0);
            for ( final String profileName : nonFoundationNonBUCCProfileNames )
            {
                //if ( !profileName.equals("RSC - Supplier - API") ) { continue; }            
                threadPool.execute(new Runnable(){
                    @Override
                    public void run()
                    {
                        try
                        {
                            int jobId;
                            JobSTATUS jobStatus;
                            GenerateSTATUS generationStatus;
                            List<StringArray> errorMap;
                            boolean generationPerformed;
                            
                            jobId = r.submitJobValidateProfile(configuratorUserName, configuratorUserPassword,project,profileName,profileValidationSelectionSet);
                            jobStatus = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId).status;
                            generationStatus = r.getGenerationStatus(configuratorUserName, configuratorUserPassword, jobId);
                            errorMap = r.getInjectorNameToErrorMessageMapForNonSuccessfulInjectors(configuratorUserName, configuratorUserPassword, jobId, false);

                            generationPerformed = false;
                            if ( generationStatus.equals(GenerateSTATUS.COMPLETED) && errorMap.size() == 0 )
                            {
                                generationPerformed = true;
                                jobId = r.submitJobGenerateProfile(configuratorUserName, configuratorUserPassword,project,profileName,false,false,true,null);
                                jobStatus = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId).status;
                                generationStatus = r.getGenerationStatus(configuratorUserName, configuratorUserPassword, jobId);
                                errorMap = r.getInjectorNameToErrorMessageMapForNonSuccessfulInjectors(configuratorUserName, configuratorUserPassword, jobId, true);
                                
                                /*
                                if ( jobStatus.equals(JobSTATUS.COMPLETED) )
                                {
                                    byte[] bwpData = r.downloadBwp(configuratorUserName, configuratorUserPassword,jobId);
                                    FileUtils.writeByteArrayToFile(new File(outputDir, "PROFILE_r" + svnRevision + "_QA_" + profileName + ".bwp"), bwpData);
                                }
                                */
                            }
                            synchronized(accumulatedOutput)
                            {
                                if ( errorMap.size() > 0 )
                                {
                                    accumulatedOutput.append("<font color=\"red\">");
                                }

                                accumulatedOutput.append("\n<br/><br/>" + nf.format(profileCounter.incrementAndGet()) + 
                                ". Profile: <b>" + profileName + "</b>, Job Status:  <b>" + jobStatus + "</b>, " + (generationPerformed? "Generation" : "Validation") + 
                                " Status: <b>" + generationStatus + "</b>");
                                if ( errorMap.size() > 0 )
                                {
                                    for ( StringArray pair : errorMap )
                                    {
                                        accumulatedOutput.append("<br/>&nbsp;&nbsp;&nbsp; <b>" + pair.getItem().get(0) + "</b> : " + pair.getItem().get(1));
                                    }
                                    accumulatedOutput.append("</font>");
                                }
                            }
                        }
                        catch(Throwable t)
                        {
                            caughtThrowables.add(t);
                            t.printStackTrace();
                        }
                    }
                });
            }
            threadPool.shutdown();
            threadPool.awaitTermination(Long.MAX_VALUE, TimeUnit.DAYS);
            
            threadPool = Executors.newFixedThreadPool(concurrentValidationJobCount);
            profileCounter.set(0);
            for ( final String profileName : nonFoundationBUCCProfileNames )
            {
                threadPool.execute(new Runnable(){
                    @Override
                    public void run()
                    {
                        try
                        {
                            int jobId;
                            JobSTATUS jobStatus;
                            String newProfileName = "QA__" + profileName + ".BUCC";
                            newProfileName = newProfileName.replace(" ", "_").toUpperCase() + "." + time;
                            String newProfileLabel = newProfileName;
                            System.err.println("Profile: " + profileName + ", newProfile: " + newProfileName);
                            
                            jobId = r.submitJobMassCopyProfile(configuratorUserName, configuratorUserPassword,project,profileName, newProfileName, newProfileLabel);
                            jobStatus = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId).status;
                            if ( !jobStatus.equals(JobSTATUS.COMPLETED) )
                            {
                                JobOutput jobOutput = r.getJobOutput(configuratorUserName, configuratorUserPassword, jobId);
                                synchronized(accumulatedOutput)
                                {
                                    accumulatedOutput.append(jobOutput.getHumanReadableOutput());
                                }
                                return;
                            }
                            
                            jobId = r.submitJobBuccUploadUsingExistingData(configuratorUserName, configuratorUserPassword,project,newProfileLabel);
                            jobStatus = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId).status;
                            if ( !jobStatus.equals(JobSTATUS.COMPLETED) )
                            {
                                JobOutput jobOutput = r.getJobOutput(configuratorUserName, configuratorUserPassword, jobId);
                                synchronized(accumulatedOutput)
                                {
                                    accumulatedOutput.append(jobOutput.getHumanReadableOutput());
                                }
                                return;
                            }
                        
                            jobId = r.submitJobValidateProfile(configuratorUserName, configuratorUserPassword,project,newProfileName,profileValidationSelectionSet);
                            jobStatus = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId).status;
                            GenerateSTATUS generationStatus = r.getGenerationStatus(configuratorUserName, configuratorUserPassword, jobId);
                            List<StringArray> errorMap = r.getInjectorNameToErrorMessageMapForNonSuccessfulInjectors(configuratorUserName, configuratorUserPassword, jobId, false);

                            boolean generationPerformed = false;
                            if ( generationStatus.equals(GenerateSTATUS.COMPLETED) && errorMap.size() == 0 )
                            {
                                generationPerformed = true;
                                jobId = r.submitJobGenerateProfile(configuratorUserName, configuratorUserPassword,project,newProfileName,false,false,true,null);
                                jobStatus = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId).status;
                                generationStatus = r.getGenerationStatus(configuratorUserName, configuratorUserPassword, jobId);
                                errorMap = r.getInjectorNameToErrorMessageMapForNonSuccessfulInjectors(configuratorUserName, configuratorUserPassword, jobId, true);
                            }
                            
                            /*
                            if ( jobStatus.equals(JobSTATUS.COMPLETED) )
                            {
                                byte[] bwpData = r.downloadBwp(configuratorUserName, configuratorUserPassword,jobId);
                                FileUtils.writeByteArrayToFile(new File(outputDir, "PROFILE_r" + svnRevision + "_" + profileName + ".bwp"), bwpData);
                            }
                            */
                            synchronized(accumulatedOutput)
                            {
                                if ( errorMap.size() > 0 )
                                {
                                    accumulatedOutput.append("<font color=\"red\">");
                                }

                                accumulatedOutput.append("\n<br/><br/>" + nf.format(profileCounter.incrementAndGet()) + 
                                ". Profile: <b>" + profileName + "</b>, Job Status:  <b>" + jobStatus + "</b>, " + (generationPerformed? "Generation" : "Validation") + 
                                " Status: <b>" + generationStatus + "</b>");
                                if ( errorMap.size() > 0 )
                                {
                                    for ( StringArray pair : errorMap )
                                    {
                                        accumulatedOutput.append("<br/>&nbsp;&nbsp;&nbsp; <b>" + pair.getItem().get(0) + "</b> : " + pair.getItem().get(1));
                                    }
                                    accumulatedOutput.append("</font>");
                                }
                            }
                        }
                        catch(Throwable t)
                        {
                            synchronized(accumulatedOutput)
                            {
                                accumulatedOutput.append("\n<br/><br/>" + nf.format(profileCounter.incrementAndGet()) + 
                                ". Profile: <b>" + profileName + "</b> : FAILED WITH ERROR: " + getAllThrowableMessagesHTML(t));
                            }
                            t.printStackTrace();
                        }
                    }
                });
            }
            threadPool.shutdown();
            threadPool.awaitTermination(Long.MAX_VALUE, TimeUnit.DAYS);

            ////////////////////////////////////////////////////////////////////////
            //Execute all Foundation profile combinations
            ////////////////////////////////////////////////////////////////////////
            synchronized(accumulatedOutput)
            {
                accumulatedOutput.append("<br/><br/><br/><hr/><b>Foundation Combination Validation</b><hr/><br/>");
            }
            
            List<String> foundationInjectionTypes = r.getFoundationInjectionTypes(configuratorUserName, configuratorUserPassword,project);
            threadPool = Executors.newFixedThreadPool(concurrentValidationJobCount);
			profileCounter.set(0);
            outer: for ( final String foundationInjectionType : foundationInjectionTypes )
            {
                List<String> foundationInjectionModules = r.getFoundationInjectionModules(configuratorUserName, configuratorUserPassword,project, foundationInjectionType);
                for ( final String foundationInjectionModule : foundationInjectionModules )
                {
                    List<String> foundationInjectionNames = r.getFoundationInjectionNames(configuratorUserName, configuratorUserPassword,project, foundationInjectionType, foundationInjectionModule);
                    for ( final String foundationInjectionName : foundationInjectionNames )
                    {
                        String profileNameTemp = "FOUNDATION_QA__" + foundationInjectionType + "__" + foundationInjectionModule + "__" + foundationInjectionName;
                        final String profileName = profileNameTemp.replace(" ", "_").toUpperCase() + "." + time;
                        
                        //if ( !profileName.contains("__BRAZILIAN_PORTUGUESE") ) continue; 
                    
                        threadPool.execute(new Runnable(){
                            @Override
                            public void run()
                            {
                                try
                                {
                                    int jobId = r.submitJobFoundation(configuratorUserName, configuratorUserPassword,project,
                                    profileName, profileName, 7, 
                                    foundationInjectionType, foundationInjectionModule, foundationInjectionName,
                                    null,null,true,null,null,null,null,null,null,null,null,true, "CPY1 AC Cal", 2001, 2020, "October",null);
                                    Job job = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId);
                                    JobOutput jobOutput = r.getJobOutput(configuratorUserName, configuratorUserPassword, jobId);
                                    synchronized(accumulatedOutput)
                                    {
                                        accumulatedOutput.append("\n<br/><br/>" + nf.format(profileCounter.incrementAndGet()) + 
                                        ". Foundation Profile: <b>" + profileName + "</b>, Status: <b>" + job.getStatus() + "</b> :: <br/>" + jobOutput.getHumanReadableOutput());
                                        accumulatedOutput.append("\n<br/><hr/>");
                                    }
                                    if ( job.status.equals(JobSTATUS.COMPLETED) )
                                    {
                                        byte[] bwpData = r.downloadBwp(configuratorUserName, configuratorUserPassword,job.getJobId());
                                        FileUtils.writeByteArrayToFile(new File(outputDir, project + "." + profileName + ".bwp"), bwpData);
                                    }
                                }
                                catch(Throwable t)
                                {
                                    caughtThrowables.add(t);
                                    t.printStackTrace();
                                }
                            }
                        });
                    }        
                }        
            }
            
            threadPool.shutdown();
            threadPool.awaitTermination(Long.MAX_VALUE, TimeUnit.DAYS);
            
			checkForErrorsAndFailIfPresent(accumulatedOutput.toString(), testOutputFile, caughtThrowables,true);
			
			////////////////////////////////////////////////////////////////////////
            // Validate Inventory/ Reverse SQL mismatches
            ////////////////////////////////////////////////////////////////////////
			/*
			jobId=r.submitJobValidateInventoryReverseSQLMismatch(configuratorUserName, configuratorUserPassword,jdbcString,project);
			System.out.println("validation inventory/ reverse SQL mismatches - jobId: "+jobId);
		
			Job job = waitForJobCompletion(r, configuratorUserName, configuratorUserPassword, jobId);
			//System.out.println("jobStatus: "+job.status);
		    jobOutput = r.getJobOutput(configuratorUserName, configuratorUserPassword, jobId);
            synchronized(accumulatedOutput)
            {
                accumulatedOutput.append(jobOutput.getHumanReadableOutput());
				//System.out.println("output: "+jobOutput.getHumanReadableOutput());
			}
       		
			
            checkForErrorsAndFailIfPresent(accumulatedOutput.toString(), testOutputFile, caughtThrowables,false);
			*/
         }
         finally
         {
            try
            {
                r.submitJobDeleteProject(configuratorUserName, configuratorUserPassword, projectNameIfPresent);
            }
            catch(Throwable t)
            {
                t.printStackTrace();
            }
         }
    }
    
    public static String getAllThrowableMessagesHTML(Throwable t)
    {
        return "<ul style=\"margin: 15; padding: 0;\"><li>" + getAllThrowableMessages(t, "<li>") + "</ul>";
    }
    public static String getAllThrowableMessages(Throwable t)
    {
        return getAllThrowableMessages(t, " :: ");
    }
    public static String getAllThrowableMessages(Throwable t, String interExceptionSeparator)
    {
    	if ( t == null ) return "";
    	String next = getAllThrowableMessages(t.getCause(), interExceptionSeparator);
    	String toReturn = t.getClass().getName() + "::" + t.getMessage();
    	if ( next != null && next.trim().length() > 0 )
    	{
    	    toReturn += interExceptionSeparator + next;
    	}
    	return toReturn;
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
    
    private static void checkForErrorsAndFailIfPresent(String jobOutput, File testOutputFile, List<Throwable> caughtThrowables,boolean isCheckExceptionString) throws Throwable
    {
        FileUtils.writeStringToFile(testOutputFile, jobOutput);
        System.err.println("TEST.OUTPUT.FILE=" + testOutputFile.getAbsolutePath().replaceAll("\\\\","/"));
        String lowercaseJobOutput = jobOutput.toLowerCase();
		
		boolean hasException=lowercaseJobOutput.indexOf("exception") != -1;
        if ( lowercaseJobOutput.indexOf("error") != -1 || lowercaseJobOutput.indexOf("warning")  != -1 || (hasException && isCheckExceptionString)  )
        {
            throw new Error("VERIFICATION CONTAINS ERRORS/WARNINGS<br/>");
        }    
        else if ( caughtThrowables != null && caughtThrowables.size() > 0 )
        {
            StringBuffer buff = new StringBuffer("<br/><br/>EXCEPTIONS CAUGHT:<br/><br/>");
            for ( Throwable t : caughtThrowables )
            {
                buff.append(getAllThrowableMessagesHTML(t));
            }
            FileUtils.writeStringToFile(testOutputFile, jobOutput + buff.toString());
        
            throw new Error("Exceptions caught during processing.  See output file.");
        }
    }
        
    
}