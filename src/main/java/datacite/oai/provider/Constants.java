package datacite.oai.provider;

/*******************************************************************************
 * Copyright (c) 2011 DataCite
 *
 * All rights reserved. This program and the accompanying materials are made
 * available under the terms of the Apache License, Version 2.0 which
 * accompanies this distribution, and is available at
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 *******************************************************************************/

public final class Constants {

    /**
     * Holds constants related to sets
     * 
     * @author PaluchM
     *
     */
    public static class Set {
        public static final String REF_QUALITY = "REFQUALITY";
        public static final String REF_QUALITY_SUFFIX = "." + REF_QUALITY;
        public static final String BASE64_PART_DELIMITER = "~";
    }

    /**
     * Holds date/time related constants.
     * 
     * @author PaluchM
     *
     */
    public static class DateTime {
        public static final String DATETIME_FORMAT = "yyyy-MM-dd'T'HH:mm:ss'Z'";
        public static final String DATETIME_FORMAT_MYSQL = "%Y-%m-%dT%TZ";
        public static final String DATETIME_FORMAT_SOLR = "yyyy-MM-dd'T'HH:mm:ss'Z'";

        public static final String MIN_FROM_TIME = "00:00:00";
        public static final String MIN_FROM_DATE = "0001-01-01";

        public static final String MAX_TO_TIME = "23:59:59";
        public static final String MAX_TO_DATE = "9999-12-31";
    }

    /**
     * Holds constants of key values in the Property(context) file.
     * 
     * @author PaluchM
     *
     */
    public static class Property {
        public static final String REPOSITORIES = "oai.repositories";

        public static final String ENVIRONMENT_LABEL = "environmentLabel";

        public static final String STYLESHEET_IDENTITY = "stylesheet.identity";

        public static final String STYLESHEET_DATACITEtoOAIDC = "stylesheet.datacite_to_oaidc";
        public static final String STYLESHEET_DIFtoISO = "stylesheet.DIFtoISO";
        public static final String MDS_MAX_LIST_SIZE = "DataciteOAICatalog.maxListSize";
        public static final String MDS_SETCACHE_EXPIRY_SECONDS = "mdssetcache.expiry.seconds";

        public static final String DB_PROPERTIES_FILE = "db.properties";
    }

    /**
     * Holds constants for repository IDs that this provider can serve.
     * 
     * @author PaluchM
     *
     */
    public static class RepositoryID {
        public static final String DATACITEMDS = "datacitemds";
    }

    /**
     * Holds constants for schema versions.
     * 
     * @author PaluchM
     *
     */
    public static class SchemaVersion {

        public static final String VERSION_DIF_TO_ISO = "DIFtoISO";
        public static final String DATACITE_TO_OAIDC = "DATACITETOOAIDC";

    }

    /** Holds constants for database connections **/
    public static class Database {
        // MDS Solr properties
        public static final String MDS_SOLR_URL = "mds.solr.url";
        public static final String MDS_SOLR_USERNAME = "mds.solr.username";
        public static final String MDS_SOLR_PASSWORD = "mds.solr.password";

    }
}
