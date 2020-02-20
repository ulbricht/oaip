package datacite.oai.provider.service;

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

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import datacite.oai.provider.ApplicationContext;
import datacite.oai.provider.Constants;

/**
 * A service implementation that performs local XSL transformations.
 */
public class TransformerService extends Service {

    private static Logger logger = Logger.getLogger(TransformerService.class);
    private HashMap<String, Templates> templatesMap;
    private Templates identityTransform;

    /**
     * Public constructor
     * 
     * @param context
     * @throws ServiceException
     */
    public TransformerService(ServletContext context) throws ServiceException {

        super(context);

        try {
            logger.warn("TransformerService loading...");
            ApplicationContext applicationContext = ApplicationContext.getInstance();
            templatesMap = new HashMap<String, Templates>();

            logger.warn("Loading Identity transform");
            String resourcePath = applicationContext.getProperty(Constants.Property.STYLESHEET_IDENTITY);
            DOMSource domSource = buildDOMSource(context.getResourceAsStream(resourcePath));
            identityTransform = TransformerFactory.newInstance().newTemplates(domSource);

            logger.warn("Loading IGSN_to_oaidc transform");
            resourcePath = applicationContext.getProperty(Constants.Property.STYLESHEET_DATACITEtoOAIDC);
            domSource = buildDOMSource(context.getResourceAsStream(resourcePath));

            Templates theDataCitetoOAIDCTemplate = TransformerFactory.newInstance().newTemplates(domSource);
            templatesMap.put(Constants.SchemaVersion.DATACITE_TO_OAIDC, theDataCitetoOAIDCTemplate);

            logger.warn("Loading DIF_to_ISO transform");
            resourcePath = applicationContext.getProperty(Constants.Property.STYLESHEET_DIFtoISO);
            domSource = buildDOMSource(context.getResourceAsStream(resourcePath));
            Templates theDIFtoISOTemplates = TransformerFactory.newInstance().newTemplates(domSource);
            templatesMap.put(Constants.SchemaVersion.VERSION_DIF_TO_ISO, theDIFtoISOTemplates);

            logger.warn("TransformerService loaded.");

        } catch (TransformerConfigurationException te) {
            throw new ServiceException(te.getMessageAndLocation(), te);
        } catch (Exception e) {
            logger.error("Could not load TransformerService", e);
            throw new ServiceException(e);
        }
    }

    @Override
    public void destroy() {
    }

    /**
     * Transform DataCite Metadata Scheme to OAI Dubmin Core.
     * 
     * @param schemaVersion The schema verion being transformed.
     * @param metadata      The metadata to transform
     * @return The resulting metadata as a String
     * @throws ServiceException
     */
    public String doTransformKernelToOaidc(String schemaVersion, byte[] metadata) throws ServiceException {
        try {

            schemaVersion = Constants.SchemaVersion.DATACITE_TO_OAIDC;

            logger.info("Transforming " + schemaVersion + " to OAIDC: " + new String(metadata));
            Templates transform = getTransform(schemaVersion);
            String transformed = doTransform(metadata, transform);
            logger.info("Transformed " + transformed);
            return transformed;
        } catch (Exception e) {
            logger.error("Unable to transform Kernel " + schemaVersion + " to OAIDC: " + metadata, e);
            throw new ServiceException("Unable to transform Kernel " + schemaVersion + " to OAIDC", e);
        }
    }

    /**
     * Perform and Identity transform on input metadata. The transform is configured
     * to output UTF-8.
     * 
     * @param metadata The metadata to transform
     * @return The resulting metadata as a String
     * @throws ServiceException
     */
    public String doTransformIdentity(byte[] metadata) throws ServiceException {
        try {
            return doTransform(metadata, identityTransform);
        } catch (Exception e) {
            logger.error("Unable to perform Identity transform: " + metadata, e);
            throw new ServiceException("Unable to perform Identity transform", e);
        }
    }

    public String doTransformDIFtoISO(byte[] metadata) throws ServiceException {
        String schemaVersion = Constants.SchemaVersion.VERSION_DIF_TO_ISO;
        try {
            Templates transform = getTransform(schemaVersion);
            return doTransform(metadata, transform);
        } catch (Exception e) {
            logger.error("Unable to transform " + schemaVersion + " to ISO: " + metadata, e);
            throw new ServiceException("Unable to transform " + schemaVersion + " to ISO", e);
        }
    }

    /**
     * Transform DataCite Metadata Scheme to OAI Dublin Core.
     * 
     * @param metadata the metadata to transform
     * @param template the template to use
     * @return
     * @throws Exception
     */
    private String doTransform(byte[] metadata, Templates template) throws Exception {
        // Configure input
        StreamSource streamSource = new StreamSource(new ByteArrayInputStream(metadata));

        // Configure output
        StringWriter stringWriter = new StringWriter();
        StreamResult streamResult = new StreamResult(stringWriter);

        // Do transform
        Transformer transformer = template.newTransformer();
        transformer.transform(streamSource, streamResult);

        // Return result
        stringWriter.close();
        return stringWriter.toString();
    }

    /**
     * Returns the correct transform for the given schema version. Will return a
     * default transform if requested version is not found.
     * 
     * @param schemaVersion The version of the schema to transform
     * @return The transform as a Templates object
     */
    private Templates getTransform(String schemaVersion) {
        Templates transform = templatesMap.get(schemaVersion);

        // get the default version (null key) if
        if (transform == null) {
            transform = templatesMap.get(null);
        }

        return transform;
    }

    /**
     * Builds a DOMSource object from the input steam
     * 
     * @param inputStream
     * @return The DOMSource object
     * @throws SAXException
     * @throws IOException
     * @throws ParserConfigurationException
     */
    private DOMSource buildDOMSource(InputStream inputStream)
            throws SAXException, IOException, ParserConfigurationException {
        DocumentBuilderFactory documentFactory = DocumentBuilderFactory.newInstance();
        documentFactory.setNamespaceAware(true);

        DocumentBuilder documentBuilder = documentFactory.newDocumentBuilder();
        Document document = documentBuilder.parse(inputStream);

        return new DOMSource(document);

    }

}
