/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Legal%20Jurisdictions%20-%20Manage%20Legal%20Jurisdictions.sql $:
 * $Id: Manage Legal Jurisdictions - Manage Legal Jurisdictions.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT XleJurisdictionsVl.NAME AS RES_NAME
,(CASE
	WHEN geographiesE0.GEOGRAPHY_TYPE = 'STATE' THEN
		geographiesE0.GEOGRAPHY_NAME
	WHEN geographiesE0.GEOGRAPHY_TYPE = 'COUNTRY' THEN
		(SELECT IDENTIFIER_VALUE
			FROM HZ_GEOGRAPHY_IDENTIFIERS
			WHERE IDENTIFIER_TYPE = 'NAME'
			AND GEO_DATA_PROVIDER = 'USER_ENTERED'
			AND PRIMARY_FLAG = 'Y'
			AND GEOGRAPHY_ID = geographiesE0.GEOGRAPHY_ID
			)
	ELSE
		geographiesE0.GEOGRAPHY_NAME
	END) RES_TERRITORY
,(SELECT MEANING
	FROM XLE_LOOKUPS
	WHERE LOOKUP_TYPE = 'LEGISLATIVE_CATEGORY'
	AND lookup_code   = XleJurisdictionsVl.LEGISLATIVE_CAT_CODE
	) AS RES_LEGISLATIVE_CATEGORY
,(SELECT MEANING
	FROM XLE_LOOKUPS
	WHERE LOOKUP_TYPE = 'XLE_YES_NO'
	AND lookup_code   = XleJurisdictionsVl.IDENTIFYING_FLAG
	)                                 AS RES_IDENTIFYING
,TO_CHAR(XleJurisdictionsVl.EFFECTIVE_FROM,'DD-Mon-YYYY')    AS RES_START_DATE
,TO_CHAR(XleJurisdictionsVl.EFFECTIVE_TO,'DD-Mon-YYYY') AS RES_END_DATE
,(SELECT MEANING
	FROM XLE_LOOKUPS
	WHERE LOOKUP_TYPE = 'XLE_REG_CODE'
	AND lookup_code   = XleJurisdictionsVl.REGISTRATION_CODE_LE
	) AS RES_LEGAL_ENTITY_REGISTRATION_
,(SELECT MEANING
	FROM XLE_LOOKUPS
	WHERE LOOKUP_TYPE = 'XLE_REG_CODE_EST'
	AND lookup_code   = XleJurisdictionsVl.REGISTRATION_CODE_ETB
	) AS RES_LEGAL_REPORTING_UNIT_REGIS
,XleJurisdictionsVl.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,XleJurisdictionsVl.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
  ,XleJurisdictionsVl.CREATED_BY  RSC_CREATED_BY
  ,XleJurisdictionsVl.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLE_JURISDICTIONS_VL XleJurisdictionsVl
,HZ_GEOGRAPHIES geographiesE0
WHERE XleJurisdictionsVl.GEOGRAPHY_ID = geographiesE0.GEOGRAPHY_ID
ORDER BY XleJurisdictionsVl.NAME