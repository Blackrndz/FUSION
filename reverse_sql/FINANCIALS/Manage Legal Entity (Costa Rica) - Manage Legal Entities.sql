/* ****************************************************************************
* $Revision: 78399 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-04-29 15:46:30 +0700 (Fri, 29 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Legal%20Entity%20(Croatia)%20-%20Manage%20Legal%20Entities.sql $:
* $Id: Manage Legal Entity (Croatia) - Manage Legal Entities.sql 78399 2022-04-29 08:46:30Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT TerritoryPEO.TERRITORY_SHORT_NAME                 AS RES_COUNTRY
,XleEntityProfiles.NAME                                  AS RES_NAME
,XleEntityProfiles.LEGAL_ENTITY_IDENTIFIER               AS RES_LEGAL_ENTITY_IDENTIFIER
,TO_CHAR(XleEntityProfiles.EFFECTIVE_FROM,'DD-Mon-YYYY') AS RES_START_DATE
,TO_CHAR(XleEntityProfiles.EFFECTIVE_TO,'DD-Mon-YYYY')   AS RES_END_DATE
,NVL((SELECT meaning
	FROM fusion.XLE_LOOKUPS
	WHERE lookup_type = 'XLE_YES_NO'
	AND lookup_code   = XleEntityProfiles.PSU_FLAG
	),'No') AS RES_PAYROLL_STATUTORY_UNITFLAG
,NVL((SELECT meaning
	FROM fusion.XLE_LOOKUPS
	WHERE lookup_type = 'XLE_YES_NO'
	AND lookup_code   = XleEntityProfiles.LEGAL_EMPLOYER_FLAG
	),'No') AS RES_LEGAL_EMPLOYER
,(SELECT REGISTERED_NAME
	FROM fusion.XLE_REGISTRATIONS
	WHERE source_id = XleEntityProfiles.PARENT_PSU_ID
	AND identifying_flag = 'Y'
	) AS RES_PAYROLL_STATUTORY_UNIT_LEG
,(SELECT REGISTRATION_NUMBER
	FROM fusion.XLE_REGISTRATIONS
	WHERE source_id = XleEntityProfiles.PARENT_PSU_ID
	AND identifying_flag = 'Y'
	) AS RES_PAYROLL_STATUTORY_UNIT_REG
,(SELECT meaning
	FROM fusion.fnd_LOOKUPS
	WHERE lookup_type = 'JEES_EURO_COUNTRY_CODES'
	AND lookup_code  IN
		(SELECT country
		FROM fusion.XLE_LOCATIONS_V
		WHERE location_id IN
			(SELECT location_id
			FROM fusion.XLE_REGISTRATIONS
			WHERE source_id      = XleEntityProfiles.PARENT_PSU_ID
			AND identifying_flag = 'Y'
			)
		)
	)                                       AS RES_PAYROLL_STATUTORY_UNIT_COU
, XleJurisdictionsVl.name                AS RES_IDENTIFYING_JURISDICTION
,TRIM(REPLACE
		(REPLACE(hz_format_pub.format_address(p_location_id => LocationDPEO.LOCATION_ID, p_line_break => ','),UPPER(TerritoryPEO.TERRITORY_SHORT_NAME)||',','')
	,','||UPPER(TerritoryPEO.TERRITORY_SHORT_NAME),'')
	)  AS RES_LEGAL_ADDRESS
,XleRegistrations.PLACE_OF_REGISTRATION AS RES_PLACE_OF_REGISTRATION
,XleRegistrations.REGISTRATION_NUMBER   AS RES_CORPORATE_IDENTIFICATION_N
,(SELECT REGISTRATION_NUMBER
	FROM XLE_REGISTRATIONS
	WHERE SOURCE_TABLE = 'XLE_ETB_PROFILES'
	AND IDENTIFYING_FLAG = 'Y'
	AND SOURCE_ID     IN
		(SELECT ESTABLISHMENT_ID
		FROM XLE_ETB_PROFILES
		WHERE LEGAL_ENTITY_ID = xleentityprofiles.legal_entity_id
		AND GEOGRAPHY_ID      = xleentityprofiles.GEOGRAPHY_ID
		AND MAIN_ESTABLISHMENT_FLAG = 'Y'
		AND SYSDATE < NVL(MAIN_EFFECTIVE_TO,TO_DATE('31-12-4712','DD-MM-YYYY'))
		)
	) AS RES_TAX_REGISTRATION_NUMBER
,XleEntityProfiles.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,XleEntityProfiles.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,XleEntityProfiles.CREATED_BY RSC_CREATED_BY
,XleEntityProfiles.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,xleentityprofiles.legal_entity_id RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM fusion.HZ_GEOGRAPHIES GeographyPEO
,fusion.HZ_PARTIES PartyPEO
,fusion.HZ_PARTY_SITES PartySitePE0
,fusion.XLE_JURISDICTIONS_VL XleJurisdictionsVl
,fusion.XLE_REGISTRATIONS XleRegistrations
,fusion.XLE_ENTITY_PROFILES XleEntityProfiles
,fusion.FND_TERRITORIES_VL TerritoryPEO
,fusion.XLE_LOCATIONS_V LocationDPEO
WHERE xleentityprofiles.legal_entity_id = xleregistrations.source_id
AND xleregistrations.jurisdiction_id    = xlejurisdictionsvl.jurisdiction_id
AND xleregistrations.source_table       = 'XLE_ENTITY_PROFILES'
AND xleregistrations.identifying_flag   = 'Y'
AND XleEntityProfiles.PARTY_ID = PartySitePE0.PARTY_ID
AND PartySitePE0.LOCATION_ID = LocationDPEO.LOCATION_ID
AND PartySitePE0.OVERALL_PRIMARY_FLAG = 'Y'
AND territorypeo.territory_code         = locationdpeo.country
AND geographypeo.geography_id           = xlejurisdictionsvl.geography_id
AND geographypeo.geography_id           = xleentityprofiles.geography_id
AND partypeo.party_id                   = xleentityprofiles.party_id
AND geographypeo.geography_type         = 'COUNTRY'
AND TerritoryPEO.TERRITORY_CODE         = 'CR'
ORDER BY RES_NAME