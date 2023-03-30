/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Extended%20Lookup%20Codes%20-%20Lookup%20Types.sql $:
 * $Id: Manage Extended Lookup Codes - Lookup Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT fndLOOKUPTYPEO.MEANING RES_LOOKUP_TYPE
,hcmEXTENDEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hcmEXTENDEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hcmEXTENDEO.CREATED_BY RSC_CREATED_BY
,hcmEXTENDEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT LOOKUP_TYPE,LAST_UPDATED_BY,LAST_UPDATE_DATE,CREATED_BY,CREATION_DATE,ROW_NUMBER() OVER(PARTITION BY LOOKUP_TYPE ORDER BY LOOKUP_TYPE) AS ROW_NUMBER FROM HCM_EXTENDED_LOOKUP_CODES_VL) hcmEXTENDEO
,FND_LOOKUP_TYPES_VL fndLOOKUPTYPEO
WHERE hcmEXTENDEO.LOOKUP_TYPE = fndLOOKUPTYPEO.LOOKUP_TYPE
AND ROW_NUMBER = 1
ORDER BY RES_LOOKUP_TYPE