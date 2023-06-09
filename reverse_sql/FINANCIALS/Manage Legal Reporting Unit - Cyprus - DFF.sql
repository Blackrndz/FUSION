/* ****************************************************************************
 * $Revision: 78754 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-15 11:17:10 +0700 (Wed, 15 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Legal%20Reporting%20Unit%20-%20Cyprus%20-%20DFF.sql $:
 * $Id: Manage Legal Reporting Unit - Cyprus - DFF.sql 78754 2022-06-15 04:17:10Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10024##RES##HZ_PARTY_SITES
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ADDR_ELEMENT_ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT QRSLT.NAME RES_LEGAL_ENTITY
,(SELECT LEGAL_ENTITY_IDENTIFIER
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = QRSLT.LEGAL_ENTITY_ID
	) RES_LEGAL_ENTITY_IDENTIFIER
,QRSLT.GEOGRAPHY_NAME RES_TERRITORY
,QRSLT.REGISTERED_NAME RES_LEGAL_REPORTING_UNIT_NAME
,QRSLT.REGISTRATION_NUMBER RES_LEGAL_REPORTING_UNIT_REGIS
,hz_format_pub.format_address(p_location_id => partySitesE0.LOCATION_ID, p_line_break => ',') RES_ADDRESS
,partySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER

,partySitesE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,partySitesE0.ATTRIBUTE1
,partySitesE0.ATTRIBUTE2
,partySitesE0.ATTRIBUTE3
,partySitesE0.ATTRIBUTE4
,partySitesE0.ATTRIBUTE5
,partySitesE0.ATTRIBUTE6
,partySitesE0.ATTRIBUTE7
,partySitesE0.ATTRIBUTE8
,partySitesE0.ATTRIBUTE9
,partySitesE0.ATTRIBUTE10
,partySitesE0.ATTRIBUTE11
,partySitesE0.ATTRIBUTE12
,partySitesE0.ATTRIBUTE13
,partySitesE0.ATTRIBUTE14
,partySitesE0.ATTRIBUTE15
,partySitesE0.ATTRIBUTE16
,partySitesE0.ATTRIBUTE17
,partySitesE0.ATTRIBUTE18
,partySitesE0.ATTRIBUTE19
,partySitesE0.ATTRIBUTE20
,partySitesE0.ATTRIBUTE21
,partySitesE0.ATTRIBUTE22
,partySitesE0.ATTRIBUTE23
,partySitesE0.ATTRIBUTE24
,partySitesE0.ATTRIBUTE25
,partySitesE0.ATTRIBUTE26
,partySitesE0.ATTRIBUTE27
,partySitesE0.ATTRIBUTE28
,partySitesE0.ATTRIBUTE29
,partySitesE0.ATTRIBUTE30
,partySitesE0.ATTRIBUTE_NUMBER1
,partySitesE0.ATTRIBUTE_NUMBER2
,partySitesE0.ATTRIBUTE_NUMBER3
,partySitesE0.ATTRIBUTE_NUMBER4
,partySitesE0.ATTRIBUTE_NUMBER5
,partySitesE0.ATTRIBUTE_NUMBER6
,partySitesE0.ATTRIBUTE_NUMBER7
,partySitesE0.ATTRIBUTE_NUMBER8
,partySitesE0.ATTRIBUTE_NUMBER9
,partySitesE0.ATTRIBUTE_NUMBER10
,partySitesE0.ATTRIBUTE_NUMBER11
,partySitesE0.ATTRIBUTE_NUMBER12
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE6,'DD-Mon-YYYY') ATTRIBUTE_DATE6
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE7,'DD-Mon-YYYY') ATTRIBUTE_DATE7
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE8,'DD-Mon-YYYY') ATTRIBUTE_DATE8
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE9,'DD-Mon-YYYY') ATTRIBUTE_DATE9
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE10,'DD-Mon-YYYY') ATTRIBUTE_DATE10
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE11,'DD-Mon-YYYY') ATTRIBUTE_DATE11
,TO_CHAR(partySitesE0.ATTRIBUTE_DATE12,'DD-Mon-YYYY') ATTRIBUTE_DATE12

,partySitesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,partySitesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,partySitesE0.CREATED_BY RSC_CREATED_BY
,partySitesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
FROM
	(SELECT XleEtbProfiles.PARTY_ID
	,XleEtbProfiles.LEGAL_ENTITY_ID
	,XleEtbProfiles.ENTERPRISE_ID
	,(SELECT NAME
		FROM XLE_ENTITY_PROFILES
		WHERE LEGAL_ENTITY_ID = XleEtbProfiles.LEGAL_ENTITY_ID
		) NAME
	,XleEtbProfiles.MAIN_ESTABLISHMENT_FLAG
	,XleEtbProfiles.MAIN_EFFECTIVE_FROM
	,XleEtbProfiles.MAIN_EFFECTIVE_TO
	,XleEtbProfiles.EFFECTIVE_FROM
	,XleEtbProfiles.EFFECTIVE_TO
	,XleEtbProfiles.LAST_UPDATED_BY
	,XleEtbProfiles.CREATION_DATE
	,XleEtbProfiles.LAST_UPDATE_DATE
	,XleEtbProfiles.CREATED_BY
	,XleEtbProfiles.ACTIVITY_CODE
	,XleEtbProfiles.SUB_ACTIVITY_CODE
	,XleEtbProfiles.TYPE_OF_COMPANY
	,RegistrationEO.REGISTERED_NAME
	,RegistrationEO.REGISTRATION_NUMBER
	,hz_format_pub.format_address(p_location_id => RegistrationEO.LOCATION_ID, p_line_break => ',') FORMATTED_ADDRESS
	,GeographyPEO.GEOGRAPHY_NAME
	,GeographyPEO.GEOGRAPHY_TYPE
	,GeographyPEO.GEOGRAPHY_ID
	,Jurisdictions.JURISDICTION_ID
	FROM XLE_ETB_PROFILES XleEtbProfiles
	,XLE_REGISTRATIONS RegistrationEO
	,HZ_GEOGRAPHIES GeographyPEO
	,XLE_JURISDICTIONS_VL Jurisdictions
	WHERE((XleEtbProfiles.ESTABLISHMENT_ID = RegistrationEO.SOURCE_ID(+)
	AND REGISTRATIONEO.IDENTIFYING_FLAG(+) = 'Y'))
	AND(XLEETBPROFILES.GEOGRAPHY_ID = GEOGRAPHYPEO.GEOGRAPHY_ID)
	AND XLEETBPROFILES.GEOGRAPHY_ID = Jurisdictions.GEOGRAPHY_ID
	AND RegistrationEO.JURISDICTION_ID = Jurisdictions.JURISDICTION_ID
	) QRSLT
,HZ_PARTY_SITES partySitesE0
,HZ_LOCATIONS locationsE0
WHERE QRSLT.PARTY_ID = partySitesE0.PARTY_ID
AND partySitesE0.STATUS = 'A'
AND partySitesE0.LOCATION_ID = locationsE0.LOCATION_ID
AND locationsE0.COUNTRY =  'CY'
and (partySitesE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
partySitesE0.ATTRIBUTE1 IS NOT NULL OR 
partySitesE0.ATTRIBUTE2 IS NOT NULL OR 
partySitesE0.ATTRIBUTE3 IS NOT NULL OR 
partySitesE0.ATTRIBUTE4 IS NOT NULL OR 
partySitesE0.ATTRIBUTE5 IS NOT NULL OR 
partySitesE0.ATTRIBUTE6 IS NOT NULL OR 
partySitesE0.ATTRIBUTE7 IS NOT NULL OR 
partySitesE0.ATTRIBUTE8 IS NOT NULL OR 
partySitesE0.ATTRIBUTE9 IS NOT NULL OR 
partySitesE0.ATTRIBUTE10 IS NOT NULL OR 
partySitesE0.ATTRIBUTE11 IS NOT NULL OR 
partySitesE0.ATTRIBUTE12 IS NOT NULL OR 
partySitesE0.ATTRIBUTE13 IS NOT NULL OR 
partySitesE0.ATTRIBUTE14 IS NOT NULL OR 
partySitesE0.ATTRIBUTE15 IS NOT NULL OR
partySitesE0.ATTRIBUTE16 IS NOT NULL OR 
partySitesE0.ATTRIBUTE17 IS NOT NULL OR 
partySitesE0.ATTRIBUTE18 IS NOT NULL OR 
partySitesE0.ATTRIBUTE19 IS NOT NULL OR 
partySitesE0.ATTRIBUTE20 IS NOT NULL OR
partySitesE0.ATTRIBUTE21 IS NOT NULL OR 
partySitesE0.ATTRIBUTE22 IS NOT NULL OR 
partySitesE0.ATTRIBUTE23 IS NOT NULL OR 
partySitesE0.ATTRIBUTE24 IS NOT NULL OR 
partySitesE0.ATTRIBUTE25 IS NOT NULL OR
partySitesE0.ATTRIBUTE26 IS NOT NULL OR 
partySitesE0.ATTRIBUTE27 IS NOT NULL OR 
partySitesE0.ATTRIBUTE28 IS NOT NULL OR 
partySitesE0.ATTRIBUTE29 IS NOT NULL OR 
partySitesE0.ATTRIBUTE30 IS NOT NULL OR
partySitesE0.ATTRIBUTE_NUMBER1 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER2 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER3 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER4 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER5 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER6 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER7 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER8 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER9 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER10 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER11 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_NUMBER12 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_DATE1 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_DATE2 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_DATE3 IS NOT NULL OR
partySitesE0.ATTRIBUTE_DATE4 IS NOT NULL OR
partySitesE0.ATTRIBUTE_DATE5 IS NOT NULL OR
partySitesE0.ATTRIBUTE_DATE6 IS NOT NULL OR
partySitesE0.ATTRIBUTE_DATE7 IS NOT NULL OR
partySitesE0.ATTRIBUTE_DATE8 IS NOT NULL OR
partySitesE0.ATTRIBUTE_DATE9 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_DATE10 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_DATE11 IS NOT NULL OR 
partySitesE0.ATTRIBUTE_DATE12 IS NOT NULL 
)

ORDER BY QRSLT.NAME
,DECODE(partySitesE0.IDENTIFYING_ADDRESS_FLAG,'Y',1,2)
,hz_format_pub.format_address(p_location_id => partySitesE0.LOCATION_ID, p_line_break => ',')  