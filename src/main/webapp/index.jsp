<html>
<head>
<title>IGSN OAI-PMH Data Provider Beta</title>
<link rel="stylesheet" type="text/css" href="main.css" />
</head>
<body>
<h1><img src="http://www.igsn.org/sites/www.igsn.org/files/arthemia_logo.png"> OAI-PMH Data Provider</img> <small>Beta</small></h1> 
<h2>What is this service?</h2>
<p>This service exposes metadata stored in the IGSN Registry using the Open Archives Initiative Protocol for Metadata Harvesting (<a href="http://www.openarchives.org/pmh/">OAI-PMH</a>).</p>
<h2>Who can use this service?</h2>
<p>This service is open to everyone and is meant to be accessed by OAI-PMH compliant harvesters or any application that issues OAI-PMH requests. The service base address is <strong><code>http://doidb.wdc-terra.org/igsnoaip/oai</code></strong> and the service identifier is available <a href="oai?verb=Identify">here</a>.</p>
<h2>What is OAI-PMH?</h2>
<p>In brief, <a href="http://www.openarchives.org/pmh/">OAI-PMH</a> provides a set of services that enables exposure and harvesting of repository metadata. The protocol is comprised of six verbs that specify the service being invoked, they are:</p>
<p><ul>
<li><strong>Identify</strong> - used to retrieve information about the repository.</li>
<li><strong>ListIdentifiers</strong> - used to retrieve record headers from the repository.</li>
<li><strong>ListRecords</strong> - used to harvest full records from the repository.</li>
<li><strong>ListSets</strong> - used to retrieve the set structure of the repository.</li>
<li><strong>ListMetadataFormats</strong> - lists available metadata formats that the repository can disseminate.</li>
<li><strong>GetRecord</strong> - used to retrieve an individual record from the repository.</li> 
</ul></p>
<p>Selective harvesting can be performed by the use of accompanying parameters. Available parameters are:</p>
<p><ul>
<li><strong>identifier</strong> - specifies a specific record identifier.</li>
<li><strong>metadataPrefix</strong> - specifies the metadata format that the records will be returned in.</li>
<li><strong>set</strong> - specifies the set that returned records must belong to.</li>
<li><strong>from</strong> - specifies that records returned must have been created/update/deleted on or after this date.</li>
<li><strong>until</strong> - specifies that records returned must have been created/update/deleted on or before this date.</li>
<li><strong>resumptionToken</strong> - a token previously provided by the server to resume a request where it last left off.</li>
</ul></p>  
<p>The verbs and parameters can be combined to issue requests to the service such as:</p>
<p><ul style="list-style: none;">
<li><code><a href="oai?verb=Identify">http://doidb.wdc-terra.org/igsnoaip/oai?verb=Identify</a></code> for a repository identification</li>
<li><code><a href="oai?verb=ListIdentifiers&metadataPrefix=oai_dc">http://doidb.wdc-terra.org/igsnoaip/oai?verb=ListIdentifiers&amp;metadataPrefix=oai_dc</a></code> to list all registered datasets</li>
<li><code><a href="oai?verb=ListRecords&from=2011-06-01T00:00:00Z&metadataPrefix=oai_dc">http://doidb.wdc-terra.org/igsnoaip/oai?verb=ListRecords&amp;from=2011-06-01T00:00:00Z&amp;metadataPrefix=oai_dc</a></code> to list new/updated records since 1st June 2011</li>
</ul></p>
<p>For more details on the protocol, its implementation, and uses please visit the <a href="http://www.openarchives.org/pmh/">OAI-PMH web site</a>.

<h2>Available Metadata Formats</h2>
<p>The DataCite OAI-PMH Data Provider is able to disseminate records in the following formats:</p>

<h3>OAI Dublin Core (oai_dc)</h3>
<p>As a minimum requirement for OAI-PMH compliance, metadata must be made available in the OAI Dublin Core format. For more information please see the <a href="http://www.openarchives.org/OAI/openarchivesprotocol.html#dublincore">OAI-PMH web site</a>.</p>


<h3>IGSN Direct (igsn)</h3>
<p>This metadata format contains only the original IGSN metadata without additions or alterations. Because there are multiple versions of IGSN metadata in the MDS, there is no one schema that they will all adhere to. Therefore the schema for this format does <strong><u>not</u></strong> exist and metadata will <strong><u>not</u></strong> validate against it. Please note that this format is <strong><u>not</u></strong> OAI-PMH version 2.0 compliant for the previously stated reasons.</p> 

<h2>Set Structure</h2>
<p>Each DataCite allocation agency and client datacentre is represented by a set in the repository. Therefore it is easy to harvest all available metadata for a particular datacentre or allocator. In addition each set also has a reference quality equivalent (.REFQUALITY). The reference quality set limits the metadata harvested to only those records that are deemed to be of reference quality.</p>     
<h2>Help</h2>
<p>If you have questions please ask ulbricht@gfz-potsdam.de
</p>
<h2>Source code / Acknowledgements</h2>
<p>This service is based on the tools developed by Datacite. They are available at <a href="https://github.com/datacite">GitHub</a>.</p>
</body>
</html>
