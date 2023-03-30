/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT CATEGORY_SET_NAME
	FROM EGP_CATEGORY_SETS_TL
	WHERE CATEGORY_SET_ID = fcTypesE0.OWNER_ID_NUM
	AND LANGUAGE = USERENV('LANG')
	) RES_INVENTORY_CATEGORY_SET
,COUNT(1) RES_NUMBER_OF_LEVELS
,fcTypesE0.CLASSIFICATION_TYPE_GROUP_CODE RES_FISCAL_CLASSIFICATION_TYPE
,MAX(fcTypesE0.CREATED_BY) AS RSC_CREATED_BY
,MAX(fcTypesE0.CREATION_DATE) AS RSC_CREATION_DATE
,MAX(fcTypesE0.LAST_UPDATED_BY) AS RSC_LAST_UPDATED_BY
,MAX(fcTypesE0.LAST_UPDATE_DATE) AS RSC_LAST_UPDATE_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  
FROM ZX_FC_TYPES_VL fcTypesE0
WHERE fcTypesE0.CLASSIFICATION_TYPE_GROUP_CODE IS NOT NULL
GROUP BY fcTypesE0.CLASSIFICATION_TYPE_GROUP_CODE
,fcTypesE0.OWNER_ID_NUM
ORDER BY fcTypesE0.CLASSIFICATION_TYPE_GROUP_CODE