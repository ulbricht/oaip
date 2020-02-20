<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>DOIDB OAI-PMH Data Provider Beta</title>
<link rel="stylesheet" type="text/css" href="main.css" />
</head>
<body>
<h1><!--<img src="https://mds.datacite.org/resources/images/dc-logo.gif">-->DOIDB OAI-PMH Data Provider</img> <small>Beta</small></h1> 
<h2>What is this service?</h2>
<p>This service exposes metadata stored in the GFZ DOIDB using the Open Archives Initiative Protocol for Metadata Harvesting (<a href="http://www.openarchives.org/pmh/">OAI-PMH</a>).</p>
<h2>Who can use this service?</h2>
<p>This service is open to everyone and is meant to be accessed by OAI-PMH compliant harvesters or any application that issues OAI-PMH requests. The service base address is <strong><code>http://doidb.wdc-terra.org/oaip/oai</code></strong> and the service identifier is available <a href="oai?verb=Identify">here</a>.</p>
<h2>What is OAI-PMH?</h2>
<p>In brief, <a href="http://www.openarchives.org/pmh/">OAI-PMH</a> provides a set of services that enables exposure and harvesting of repository metadata. The protocol is comprised of six verbs that specify the service being invoked, they are:</p>
<ul>
<li><strong>Identify</strong> - used to retrieve information about the repository.</li>
<li><strong>ListIdentifiers</strong> - used to retrieve record headers from the repository.</li>
<li><strong>ListRecords</strong> - used to harvest full records from the repository.</li>
<li><strong>ListSets</strong> - used to retrieve the set structure of the repository.</li>
<li><strong>ListMetadataFormats</strong> - lists available metadata formats that the repository can disseminate.</li>
<li><strong>GetRecord</strong> - used to retrieve an individual record from the repository.</li> 
</ul>
<p>Selective harvesting can be performed by the use of accompanying parameters. Available parameters are:</p>
<ul>
<li><strong>identifier</strong> - specifies a specific record identifier.</li>
<li><strong>metadataPrefix</strong> - specifies the metadata format that the records will be returned in.</li>
<li><strong>set</strong> - specifies the set that returned records must belong to.</li>
<li><strong>from</strong> - specifies that records returned must have been created/update/deleted on or after this date.</li>
<li><strong>until</strong> - specifies that records returned must have been created/update/deleted on or before this date.</li>
<li><strong>resumptionToken</strong> - a token previously provided by the server to resume a request where it last left off.</li>
</ul>
<p>The verbs and parameters can be combined to issue requests to the service such as:</p>
<p><ul style="list-style: none;">
<li><code><a href="oai?verb=Identify">http://doidb.wdc-terra.org/igsnaaoaip/oai?verb=Identify</a></code> for a repository identification</li>
<li><code><a href="oai?verb=ListIdentifiers&metadataPrefix=oai_dc">http://doidb.wdc-terra.org/igsnaaoaip/oai?verb=ListIdentifiers&amp;metadataPrefix=oai_dc</a></code> to list all registered datasets</li>
<li><code><a href="oai?verb=ListIdentifiers&metadataPrefix=igsndescription">http://doidb.wdc-terra.org/igsnaaoaip/oai?verb=ListIdentifiers&amp;metadataPrefix=igsndescription</a></code> to list all registered datasets that have a IGSN Description Schema record</li>
<li><code><a href="oai?verb=ListIdentifiers&metadataPrefix=igsngfz">http://doidb.wdc-terra.org/igsnaaoaip/oai?verb=ListIdentifiers&amp;metadataPrefix=igsngfz</a></code> to list all registered datasets that have a GFZ Description Schema record</li>
<li><code><a href="oai?verb=ListRecords&from=2011-06-01T00:00:00Z&metadataPrefix=oai_dc">http://doidb.wdc-terra.org/igsnaaoaip/oai?verb=ListRecords&amp;from=2011-06-01T00:00:00Z&amp;metadataPrefix=oai_dc</a></code> to list new/updated records since 1st June 2011</li>
</ul></p>
<p>For more details on the protocol, its implementation, and uses please visit the <a href="http://www.openarchives.org/pmh/">OAI-PMH web site</a>.
<h2>Available Metadata Formats</h2>
<p>The DataCite OAI-PMH Data Provider is able to disseminate records in the following formats:</p>
<h3>OAI Dublin Core (oai_dc)</h3>
<p>As a minimum requirement for OAI-PMH compliance, metadata must be made available in the OAI Dublin Core format. For more information please see the <a href="http://www.openarchives.org/OAI/openarchivesprotocol.html#dublincore">OAI-PMH web site</a>.</p>
<h3>OAI DataCite (oai_datacite)</h3>
<p>This metadata format has been specifically established for the dissemination of DataCite records using OAI-PMH. In addition to the original DataCite metadata, this format contains several other elements describing the version of the metadata, whether it is of reference quality, and the registering datacentre. For more information about this format and its schema please see the <a href="http://schema.datacite.org/oai/oai-1.0/">Datacite OAI schema web site</a>.</p>    
<h3>DataCite Direct (datacite)</h3>
<p>This metadata format contains only the original DataCite metadata without additions or alterations. Because there are multiple versions of DataCite metadata in the MDS, there is no one schema that they will all adhere to. Therefore the schema for this format does <strong><u>not</u></strong> exist and metadata will <strong><u>not</u></strong> validate against it. Please note that this format is <strong><u>not</u></strong> OAI-PMH version 2.0 compliant for the previously stated reasons.</p> 

<h3>DIF</h3>
<p>This metadata format contains geoscientific information. Further details can be found <a href="http://gcmd.nasa.gov/User/difguide/difman.html">here</a>.<p>

<h2>Set Structure</h2>
<p>Each DataCite allocation agency and client datacentre is represented by a set in the repository. Therefore it is easy to harvest all available metadata for a particular datacentre or allocator. In addition each set also has a reference quality equivalent (.REFQUALITY). The reference quality set limits the metadata harvested to only those records that are deemed to be of reference quality.</p>
<h3>Arbitrary Queries</h3>
<p>You can use custom solr search queries in your setspec. Therefore the solr query string must be base64url encoded, see <a href="https://tools.ietf.org/html/rfc4648#section-5">RFC 4648</a>, and appended to any normal setspec or the empty string separated by a tilde (<code>~</code>). There shall be <em>no</em> tailing padding character (<code>=</code>).</p>
<p>Example:</p>
<table>
<tr><td>solr query string</td><td><a href="http://doidb.wdc-terra.org/igsnsearch/public/ui?q=laser&amp;fq=resourceTypeGeneral:dataset"><code>q=laser&amp;fq=resourceTypeGeneral:dataset</code></a></td></tr>
<tr><td>base64url</td><td><code>cT1sYXNlciZmcT1yZXNvdXJjZVR5cGVHZW5lcmFsOmRhdGFzZXQK</code></td></tr>
<tr><td>set name</td><td>
<a href="oai?verb=ListRecords&amp;metadataPrefix=oai_datacite&set=~cT1sYXNlciZmcT1yZXNvdXJjZVR5cGVHZW5lcmFsOmRhdGFzZXQK"><code>~cT1sYXNlciZmcT1yZXNvdXJjZVR5cGVHZW5lcmFsOmRhdGFzZXQK</code></a><br/>
<a href="oai?verb=ListRecords&amp;metadataPrefix=oai_datacite&set=TIB~cT1sYXNlciZmcT1yZXNvdXJjZVR5cGVHZW5lcmFsOmRhdGFzZXQK"><code>TIB~cT1sYXNlciZmcT1yZXNvdXJjZVR5cGVHZW5lcmFsOmRhdGFzZXQK</code><br/>
<a href="oai?verb=ListRecords&amp;metadataPrefix=oai_datacite&set=TIB.GFZ~cT1sYXNlciZmcT1yZXNvdXJjZVR5cGVHZW5lcmFsOmRhdGFzZXQK"><code>TIB.GFZ~cT1sYXNlciZmcT1yZXNvdXJjZVR5cGVHZW5lcmFsOmRhdGFzZXQK</code><br/>
</a></td></tr>
</table>
<p>Currently the solr query params <code>q</code> and <code>fq</code> are supported. For list of field names see <a href="http://doidb.wdc-terra.org/igsnsearch/help.html">DOIDB Search Help</a>. At the bottom of the search results on <a href="http://doidb.wdc-terra.org/igsnsearch/public/ui">DOIDB Search</a> there is also a link to convert any custom query into a OAI-PMH request.</p>
<h2>Help</h2>
<p>If you have questions please ask ulbricht@gfz-potsdam.de
</p>
<h2>Source code / Acknowledgements</h2>
<p>This service is based on the tools published by Datacite at <a href="https://github.com/datacite">GitHub</a>. We published our modifications <a href="https://github.com/ulbricht">here</a>.</p>
</body>
</html>
