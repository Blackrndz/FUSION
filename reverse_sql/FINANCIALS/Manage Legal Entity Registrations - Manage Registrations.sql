/* ****************************************************************************
 * $Revision: 78545 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-05-20 12:22:41 +0700 (Fri, 20 May 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Legal%20Entity%20Registrations%20-%20Manage%20Registrations.sql $:
 * $Id: Manage Legal Entity Registrations - Manage Registrations.sql 78545 2022-05-20 05:22:41Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT NAME
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = XleRegistrations.SOURCE_ID
	) AS RES_LEGAL_ENTITY
,(SELECT LEGAL_ENTITY_IDENTIFIER
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = XleRegistrations.SOURCE_ID
	) AS RES_LEGAL_ENTITY_IDENTIFIER
,(SELECT name
	FROM XLE_JURISDICTIONS_VL
	WHERE JURISDICTION_ID = XleRegistrations.JURISDICTION_ID
	) AS RES_JURISDICTION
,(SELECT GEOGRAPHY_NAME
	FROM HZ_GEOGRAPHIES HzGeographiesE0
	,XLE_JURISDICTIONS_VL XleJuridictionsE0
	WHERE HzGeographiesE0.GEOGRAPHY_ID = XleJuridictionsE0.GEOGRAPHY_ID
	AND XleJuridictionsE0.JURISDICTION_ID = XleRegistrations.JURISDICTION_ID
	) AS RES_TERRITORY
/*,HZ_FORMAT_PUB.format_address(XleRegistrations.LOCATION_ID) AS RES_REGISTERED_ADDRESS */
,TRIM(REPLACE
		(REPLACE(HZ_FORMAT_PUB.format_address(p_location_id => XleRegistrations.LOCATION_ID, p_line_break => ','),UPPER(TerritoryPEO.TERRITORY_SHORT_NAME)||',','')
	,','||UPPER(TerritoryPEO.TERRITORY_SHORT_NAME),'')
	) AS RES_REGISTERED_ADDRESS
,XleRegistrations.REGISTERED_NAME                                            AS RES_REGISTERED_NAME
,XleRegistrations.ALTERNATE_REGISTERED_NAME                                  AS RES_ALTERNATE_NAME
,(SELECT MEANING 
	FROM FND_LOOKUPS 
	WHERE LOOKUP_TYPE = 'XLE_REG_CODE' 
	AND lookup_code = (SELECT REGISTRATION_CODE_LE
								FROM XLE_JURISDICTIONS_VL
								WHERE JURISDICTION_ID = XleRegistrations.JURISDICTION_ID)  
  ) AS RES_REGISTRATION_CODE
,XleRegistrations.REGISTRATION_NUMBER                                        AS RES_REGISTRATION_NUMBER
,decode(XleRegistrations.IDENTIFYING_FLAG,'Y','Yes','No') RES_IDENTIFYING
,XleRegistrations.PLACE_OF_REGISTRATION AS RES_PLACE_OF_REGISTRATION
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = XleRegistrations.ISSUING_AUTHORITY_ID
	) AS RES_ISSUING_LEGAL_AUTHORITY
,(SELECT ADDRESS1||','||CITY||','||(SELECT UPPER(GEOGRAPHY_NAME) FROM HZ_GEOGRAPHIES WHERE GEOGRAPHY_CODE = COUNTRY AND GEOGRAPHY_TYPE = 'COUNTRY')
	FROM HZ_PARTIES
	WHERE IDEN_ADDR_PARTY_SITE_ID = XleRegistrations.ISSUING_AUTHORITY_SITE_ID
	)              AS RES_ISSUING_LEGAL_AUTHORITY_AD
,TO_CHAR(XleRegistrations.EFFECTIVE_FROM,'DD-Mon-YYYY') AS RES_START_DATE
,TO_CHAR(XleRegistrations.EFFECTIVE_TO,'DD-Mon-YYYY')   AS RES_END_DATE
,XleRegistrations.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,XleRegistrations.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,XleRegistrations.CREATED_BY  RSC_CREATED_BY
,XleRegistrations.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,XleRegistrations.SOURCE_ID RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLE_REGISTRATIONS XleRegistrations
,fusion.XLE_LOCATIONS_V LocationDPEO
,fusion.FND_TERRITORIES_VL TerritoryPEO
WHERE XleRegistrations.SOURCE_TABLE = 'XLE_ENTITY_PROFILES'
AND XleRegistrations.LOCATION_ID = LocationDPEO.LOCATION_ID
AND territorypeo.territory_code = locationdpeo.country
ORDER BY XleRegistrations.REGISTERED_NAME