package datacite.oai.provider;

/*******************************************************************************
* Copyright (c) 2011 DataCite
*
* All rights reserved. This program and the accompanying 
* materials are made available under the terms of the 
* Apache License, Version 2.0 which accompanies 
* this distribution, and is available at 
* http://www.apache.org/licenses/LICENSE-2.0
*
*******************************************************************************/

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import org.oclc.oai.server.OAIHandler;

import datacite.oai.provider.service.MDSSearchService;
import datacite.oai.provider.service.ServiceCollection;

/**
 * An abstract ApplicationControllerServlet meant to be extended by a controller servlet 
 * for each separate repository that OAI-PMH services will be provided for.
 * @author PaluchM
 *
 */
public abstract class ApplicationControllerServlet extends HttpServlet {

    //-----------------------------------------------------------------------------------
    // VARIABLE DECLARATIONS
    //-----------------------------------------------------------------------------------
    private static final long serialVersionUID = 1L;
    public static final String appShortName = "OAI Provider";
                        
    //The handler from the OAICat framework.
    private OAIHandler oaiHandler; 

    //************************************************************
    // Abstract methods to override
    //************************************************************
    /** Must return the repository ID for which this OAI provider will run */
    protected abstract String getRepositoryID();
    /** Must return a string name for this application */
    protected abstract String getApplicationName();
    /** Must return a Logger */
    protected abstract Logger getLogger();
    
    //-----------------------------------------------------------------------------------
    // CONSTRUCTORS and other TRIGGERS
    //-----------------------------------------------------------------------------------

    /* (non-Javadoc)
     * @see javax.servlet.GenericServlet#init(javax.servlet.ServletConfig)
     */
    public void init(ServletConfig config) throws ServletException
    {
        getLogger().info("\n\n*** " + getApplicationName() + " is starting up ***\n");
        
        try{
            super.init(config);
            this.oaiHandler = new OAIHandler(ApplicationContext.getInstance().getRepositoryProperties(getRepositoryID()),config.getServletContext());
            getLogger().info("\n\n*** " + getApplicationName() + " is ready ***\n");
        }
        catch(Exception e){
            getLogger().error("Exception occured during initialization: "+e.toString(),e);
            throw new ServletException(e);
        }
    }

    
    /* (non-Javadoc)
     * @see javax.servlet.GenericServlet#destroy()
     */
    public void destroy()
    {
        getLogger().info(getApplicationName() + " is shutting down.");
        super.destroy();
    }

    //-----------------------------------------------------------------------------------
    // PUBLIC METHODS
    //-----------------------------------------------------------------------------------

    /* (non-Javadoc)
     * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
             
        //Intercept a status request to the application. Find status of service(s).
    	String servletpath = request.getServletPath();
		if (getLogger().isDebugEnabled()){
			getLogger().debug("Servlet Path: "+servletpath);
		}
		
		if (servletpath != null && servletpath.equalsIgnoreCase("/status")){    	
			int statusCode = -1;
			String msg = "";
			
			try{
				MDSSearchService service = ServiceCollection.getInstance().getMDSSearchService();
    			
				if (service.getStatus()){
					statusCode = HttpServletResponse.SC_OK;
					msg = "OK";
				}
				else{
					statusCode = HttpServletResponse.SC_INTERNAL_SERVER_ERROR;
					msg = "MDS search service unavailable.";
				}				
    		}    		    		
    		catch (Exception e){
    			getLogger().error(e.getMessage(),e);
    			statusCode = HttpServletResponse.SC_INTERNAL_SERVER_ERROR;
				msg = e.getMessage();
    		}
    		finally{
				//Send response
    			response.setStatus(statusCode);
				response.setContentType("text/html");
				response.setCharacterEncoding("UTF-8");
				response.getOutputStream().print(msg);
				response.getOutputStream().close();    			
    		}
    	}
		else{
	        /* Forward directly to OAIHandler class. */
    		try
    		{       
    			request.setCharacterEncoding("UTF-8");
    			response.setCharacterEncoding("UTF-8");
            
    			//pass onto OAI Handler
    			oaiHandler.doGet(request, response);
    		}
    		catch (Exception e){
    			getLogger().error("Exception Occured.", e);
    			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    			response.setContentType("text/html; charset=UTF-8");
    			response.getOutputStream().print("<html><head><title>Error - DataCite</title></head><body>An application error has occurred.  Additionally, the error page could not be loaded.<br /></body></html>");
    			response.getOutputStream().close();
    		}
    	}

    }

    /* (non-Javadoc)
     * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        doGet(request,response);
    }


}