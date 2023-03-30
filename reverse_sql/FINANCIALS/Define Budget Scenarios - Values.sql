/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Define%20Budget%20Scenarios%20-%20Values.sql $:
 * $Id: Define Budget Scenarios - Values.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT fndVSVauleSetEO.VALUE_SET_CODE 	RES_VALUE_SET_CODE
,fndVSVauleVLEO.VALUE					RES_VALUE
,fndVSVauleVLEO.DESCRIPTION 			RES_DESCRIPTION
,DECODE(fndVSVauleVLEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,TO_CHAR(fndVSVauleVLEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(fndVSVauleVLEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,fndVSVauleVLEO.SORT_ORDER			  	RES_SORT_ORDER
,fndVSVauleVLEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndVSVauleVLEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndVSVauleVLEO.CREATED_BY RSC_CREATED_BY
,fndVSVauleVLEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_VS_VALUE_SETS fndVSVauleSetEO
,FND_VS_VALUES_VL  fndVSVauleVLEO
WHERE fndVSVauleSetEO.VALUE_SET_CODE = 'Accounting Scenario'
AND fndVSVauleSetEO.VALUE_SET_CODE = fndVSVauleVLEO.ATTRIBUTE_CATEGORY
ORDER BY fndVSVauleSetEO.VALUE_SET_CODE , fndVSVauleVLEO.VALUE

