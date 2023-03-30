/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Common%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Common Lookups - Lookup Codes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT fndlookups.LOOKUP_TYPE RES_LOOKUP_TYPE
,fndlookups.LOOKUP_CODE RES_LOOKUP_CODE
,fndlookups.DISPLAY_SEQUENCE RES_DISPLAY_SEQUENCE
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = fndlookups.ENABLED_FLAG
	),'No') RES_ENABLED
,TO_CHAR(fndlookups.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(fndlookups.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,fndlookups.MEANING RES_MEANING
,fndlookups.DESCRIPTION RES_DESCRIPTION
,fndlookups.TAG RES_TAG
,fndlookups.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndlookups.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndlookups.CREATED_BY RSC_CREATED_BY
,fndlookups.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_VALUES_VL fndlookups
,FND_LOOKUP_TYPES_VL FndLookupType
WHERE fndlookups.VIEW_APPLICATION_ID = '3'
AND fndlookups.SET_ID                = 0
AND FndLookupType.LOOKUP_TYPE = fndlookups.LOOKUP_TYPE
ORDER BY fndlookups.LOOKUP_TYPE
,fndlookups.DISPLAY_SEQUENCE