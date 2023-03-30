/* ****************************************************************************
 * $Revision:  $:
 * $Author:  $:
 * $Date:  $:
 * $HeadURL: $:
 * $Id: $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=204##RES##XLE_LE_ADD_INFO
--  DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.


SELECT XleEntityProfiles.NAME AS RES_NAME
,XleEntityProfiles.LEGAL_ENTITY_IDENTIFIER AS RES_LEGAL_ENTITY_IDENTIFIER
,XleEntityProfiles.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,XleEntityProfiles.ATTRIBUTE1 
,XleEntityProfiles.ATTRIBUTE2
,XleEntityProfiles.ATTRIBUTE3
,XleEntityProfiles.ATTRIBUTE4
,XleEntityProfiles.ATTRIBUTE5
,XleEntityProfiles.ATTRIBUTE6 
,XleEntityProfiles.ATTRIBUTE7
,XleEntityProfiles.ATTRIBUTE8
,XleEntityProfiles.ATTRIBUTE9
,XleEntityProfiles.ATTRIBUTE10
,XleEntityProfiles.ATTRIBUTE11 
,XleEntityProfiles.ATTRIBUTE12
,XleEntityProfiles.ATTRIBUTE13
,XleEntityProfiles.ATTRIBUTE14
,XleEntityProfiles.ATTRIBUTE15
,XleEntityProfiles.ATTRIBUTE16 
,XleEntityProfiles.ATTRIBUTE17
,XleEntityProfiles.ATTRIBUTE18
,XleEntityProfiles.ATTRIBUTE19
,XleEntityProfiles.ATTRIBUTE20
,XleEntityProfiles.ATTRIBUTE_NUMBER1 
,XleEntityProfiles.ATTRIBUTE_NUMBER2
,XleEntityProfiles.ATTRIBUTE_NUMBER3
,XleEntityProfiles.ATTRIBUTE_NUMBER4
,XleEntityProfiles.ATTRIBUTE_NUMBER5
, TO_CHAR(XleEntityProfiles.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1
, TO_CHAR(XleEntityProfiles.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2
, TO_CHAR(XleEntityProfiles.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3
, TO_CHAR(XleEntityProfiles.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4
, TO_CHAR(XleEntityProfiles.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5
,XleEntityProfiles.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,XleEntityProfiles.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,XleEntityProfiles.CREATED_BY  RSC_CREATED_BY
,XleEntityProfiles.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,XleEntityProfiles.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
from HZ_GEOGRAPHIES GeographyPEO
, HZ_PARTIES PartyPEO
, XLE_JURISDICTIONS_VL XleJurisdictionsVl
, XLE_REGISTRATIONS XleRegistrations
, XLE_ENTITY_PROFILES XleEntityProfiles
, FND_TERRITORIES_VL TerritoryPEO
, XLE_LOCATIONS_V LocationDPEO
WHERE xleentityprofiles.legal_entity_id = xleregistrations.source_id
AND xleregistrations.jurisdiction_id    = xlejurisdictionsvl.jurisdiction_id
AND xleregistrations.source_table       = 'XLE_ENTITY_PROFILES'
AND xleregistrations.identifying_flag   = 'Y'
AND xleregistrations.location_id        = locationdpeo.location_id
AND territorypeo.territory_code         = locationdpeo.country
AND geographypeo.geography_id           = xlejurisdictionsvl.geography_id
AND geographypeo.geography_id           = xleentityprofiles.geography_id
AND partypeo.party_id                   = xleentityprofiles.party_id
AND geographypeo.geography_type         = 'COUNTRY'
AND TerritoryPEO.TERRITORY_CODE         = 'RS'
AND (XleEntityProfiles.ATTRIBUTE_CATEGORY IS NOT NULL OR
XleEntityProfiles.ATTRIBUTE1 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE2 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE3 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE4 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE5 IS NOT NULL OR
XleEntityProfiles.ATTRIBUTE6 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE7 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE8 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE9 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE10 IS NOT NULL OR
XleEntityProfiles.ATTRIBUTE11 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE12 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE13 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE14 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE15 IS NOT NULL OR
XleEntityProfiles.ATTRIBUTE16 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE17 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE18 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE19 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE20 IS NOT NULL OR
XleEntityProfiles.ATTRIBUTE_NUMBER1 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE_NUMBER2 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE_NUMBER3 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE_NUMBER4 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE_NUMBER5 IS NOT NULL OR
XleEntityProfiles.ATTRIBUTE_DATE1 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE_DATE2 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE_DATE3 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE_DATE4 IS NOT NULL OR 
XleEntityProfiles.ATTRIBUTE_DATE5 IS NOT NULL )
ORDER BY RES_NAME