/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Legal%20Jurisdictions%20-%20Legal%20Functions.sql $:
 * $Id: Manage Legal Jurisdictions - Legal Functions.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT XleJurisdictionsVl.name AS RES_NAME
,(SELECT meaning
	FROM XLE_LOOKUPS
	WHERE LOOKUP_TYPE = 'XLE_LE_FUNCTION'
	AND lookup_code   = XleJurFunctions.FUNCTION_CODE
	) AS RES_LEGAL_FUNCTION
,XleJurFunctions.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,XleJurFunctions.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
  ,XleJurFunctions.CREATED_BY  RSC_CREATED_BY
  ,XleJurFunctions.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,XleJurFunctions.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLE_JUR_FUNCTIONS XleJurFunctions
,XLE_JURISDICTIONS_VL XleJurisdictionsVl
WHERE XleJurFunctions.JURISDICTION_ID = XleJurisdictionsVl.JURISDICTION_ID
ORDER BY RES_NAME

