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

import org.oclc.oai.server.crosswalk.Crosswalk;
import org.oclc.oai.server.verb.CannotDisseminateFormatException;
import org.oclc.oai.server.verb.OAIInternalServerError;
import org.apache.log4j.Logger;
import datacite.oai.provider.service.ServiceException;

import datacite.oai.provider.catalog.datacite.DatasetRecordBean;
import datacite.oai.provider.service.TransformerService;
import datacite.oai.provider.service.ServiceCollection;

public class IGSNDirect extends Crosswalk {

    private static final Logger logger = Logger.getLogger(IGSNDirect.class);

    public IGSNDirect(Properties properties) throws OAIInternalServerError {
        super("http://igsn.org/schema/nonexistant http://schema.igsn.org/meta/nonexistant/nonexistant.xsd");
    }

    public IGSNDirect(String schema, Properties properties) throws OAIInternalServerError {
        super("http://igsn.org/schema/nonexistant http://schema.igsn.org/meta/nonexistant/nonexistant.xsd");
    }

    @Override
    public boolean isAvailableFor(Object nativeItem) {
        return nativeItem instanceof DatasetRecordBean;
    }

    @Override
    public String createMetadata(Object nativeItem) throws CannotDisseminateFormatException {
        try {
            DatasetRecordBean dataset = (DatasetRecordBean) nativeItem;

            ServiceCollection services = ServiceCollection.getInstance();
            TransformerService transformerService = services.getTransformerService();

            String result = transformerService.doTransformIdentity(dataset.getMetadata());

            return result;
        } catch (ServiceException e) {
            logger.error("Error transforming dataset", e);
            throw (CannotDisseminateFormatException) new CannotDisseminateFormatException("iso19139").initCause(e);
        }
    }
}
