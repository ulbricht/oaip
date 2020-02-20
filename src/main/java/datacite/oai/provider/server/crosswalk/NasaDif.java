package datacite.oai.provider.server.crosswalk;

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

import java.util.Properties;

import org.apache.log4j.Logger;
import org.oclc.oai.server.crosswalk.Crosswalk;
import org.oclc.oai.server.verb.CannotDisseminateFormatException;
import org.oclc.oai.server.verb.OAIInternalServerError;

import datacite.oai.provider.catalog.datacite.DatasetRecordBean;
import datacite.oai.provider.service.ServiceCollection;
import datacite.oai.provider.service.ServiceException;
import datacite.oai.provider.service.TransformerService;
import datacite.oai.provider.util.XMLUtil;

public class NasaDif extends Crosswalk {
	
    private static final Logger logger = Logger.getLogger(NasaDif.class);

    public NasaDif(Properties properties) throws OAIInternalServerError {
        super("http://pmd.gfz-potsdam.de/igsn/schemas/description/1.1 http://pmd.gfz-potsdam.de/igsn/schemas/description/1.1/resource.xsd");
    }

    public NasaDif(String schema, Properties properties) throws OAIInternalServerError {
        super("http://pmd.gfz-potsdam.de/igsn/schemas/description/1.1 http://pmd.gfz-potsdam.de/igsn/schemas/description/1.1/resource.xsd");
    }
        
    @Override
    public boolean isAvailableFor(Object nativeItem) {
        return nativeItem instanceof DatasetRecordBean;
    }

    @Override
    public String createMetadata(Object nativeItem) throws CannotDisseminateFormatException {
	try{
		DatasetRecordBean dataset = (DatasetRecordBean)nativeItem;

		ServiceCollection services = ServiceCollection.getInstance();
		TransformerService service = services.getTransformerService();
		
		String result = service.doTransformIdentity(dataset.getDif());
		result = XMLUtil.cleanXML(result);	    
		    
		return result;
	    
        }catch(ServiceException e) {
            logger.error("Error transforming dataset", e);
            throw (CannotDisseminateFormatException)new CannotDisseminateFormatException("dif").initCause(e);		
        }	    
	    
    }
}
