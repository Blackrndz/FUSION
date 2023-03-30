/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT fcCodesE0.CLASSIFICATION_CODE RES_CODE
,fcCodesE0.CLASSIFICATION_NAME RES_NAME
,(SELECT TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_TL
	WHERE TERRITORY_CODE = fcCodesE0.COUNTRY_CODE
	AND LANGUAGE = USERENV('LANG')
	) RES_COUNTRY
,TO_CHAR(fcCodesE0.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(fcCodesE0.EFFECTIVE_TO,'DD-Mon-YYYY') RES_END_DATE
,fcCodesE0.CREATED_BY AS RSC_CREATED_BY
,fcCodesE0.CREATION_DATE AS RSC_CREATION_DATE
,fcCodesE0.LAST_UPDATED_BY AS RSC_LAST_UPDATED_BY
,fcCodesE0.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM ZX_FC_CODES_VL fcCodesE0
WHERE fcCodesE0.CLASSIFICATION_TYPE_CODE = 'PRODUCT_CATEGORY'
AND fcCodesE0.PARENT_CLASSIFICATION_ID IS NULL
ORDER BY fcCodesE0.CLASSIFICATION_CODE