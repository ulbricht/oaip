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

import datacite.oai.provider.service.TransformerService;
import datacite.oai.provider.service.ServiceCollection;
import datacite.oai.provider.service.ServiceException;

import datacite.oai.provider.catalog.datacite.DatasetRecordBean;

public class Iso19139 extends Crosswalk {

    private static final Logger logger = Logger.getLogger(Iso19139.class);

    public Iso19139(Properties properties) throws OAIInternalServerError {
        super("http://schema.igsn.org/description/1.0 http://schema.igsn.org/description/1.0/resource.xsd");
    }

    public Iso19139(String schema, Properties properties) throws OAIInternalServerError {
        super("http://schema.igsn.org/description/1.0 http://schema.igsn.org/description/1.0/resource.xsd");
    }
        
    @Override
    public boolean isAvailableFor(Object nativeItem) {
        return nativeItem instanceof DatasetRecordBean;
    }

    @Override
    public String createMetadata(Object nativeItem) throws CannotDisseminateFormatException {
        DatasetRecordBean dataset = (DatasetRecordBean)nativeItem;
        
		 
		  String result;

		  try{
			if (dataset.getIso()!=null){
				result= dataset.getIso();
			}else{
            ServiceCollection services = ServiceCollection.getInstance();
            TransformerService transformerService = services.getTransformerService();           
            result = transformerService.doTransform_DIFtoISO(dataset.getDif());
			}

        }catch(ServiceException e) {
            logger.error("Error transforming dataset", e);
            throw new CannotDisseminateFormatException(e.toString());
        }


        return result;
    }
}
