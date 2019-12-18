package datacite.oai.provider.catalog.datacite;

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

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import datacite.oai.provider.Constants;

/**
 * Encapsulates a single DataCite record in the MDS.
 * @author PaluchM
 *
 */
public class DatasetRecordBean implements Serializable{

    private static final long serialVersionUID = 1L;

    private String id;

    private byte[] metadata;

    private Date updateDate;

    private String symbol;
    private boolean isActive;

    private String schemaVersion;

    /**
     * Public constructor.
     * @param id
     * @param metadata
     * @param updateDate
     * @param isActive
     * @param symbol
     */
    public DatasetRecordBean(String id,byte[] metadata,String schemaVersion, Date updateDate,boolean isActive,String symbol){
        this.id = id;
        this.updateDate = updateDate;
        this.isActive = isActive;
        this.symbol = symbol;
        this.schemaVersion = schemaVersion;

        setMetadata(metadata);
    }

    public String getId() {
        return this.id;
    }

    public void setMetadata(byte[] metadata){
    	this.metadata = metadata;
    }

    public byte[] getMetadata() {
        return this.metadata;
    }

    public Date getUpdateDate() {
        return this.updateDate;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }

    public String getSymbol() {
        return symbol;
    }

    /**
     * Sets the DataCite schema version that this record adheres to
     * @param schemaVersion
     */
    public void setSchemaVersion(String schemaVersion) {
        this.schemaVersion = schemaVersion;
    }

    /**
     * Returns the DataCite schema version that this record adheres to
     * @return
     */
    public String getSchemaVersion() {
        return schemaVersion;
    }

    /**
     * Sets the active/deleted flag for this record.
     * @param isActive
     */
    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    /**
     * Returns the active/deleted flag for this record.
     * @return
     */
    public boolean isActive() {
        return isActive;
    }

    /**
     * Creates a set listing for this record.
     * @return an array containing all of the 'sets' that this record is a part of.
     */
    public List<String> getSetList(){
        String symbol = getSymbol();
        LinkedList<String> sets = new LinkedList<String>();

        if (symbol != null && symbol.trim().length()>0){
            sets.add(symbol);
        }

        while (symbol.contains(".")){
            symbol = symbol.substring(0,symbol.lastIndexOf("."));
            sets.add(0,symbol);
        }

        return sets;
    }

}
