/* ****************************************************************************
 * $Revision: 68493 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-29 15:56:19 +0700 (Wed, 29 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Enable%20Automated%20Project%20Spaces%20-%20Profile%20Values.sql $:
 * $Id: Enable Automated Project Spaces - Profile Values.sql 68493 2018-08-29 08:56:19Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT resourceClassesE0.NAME RES_NAME
,(SELECT NAME 
	FROM PJO_SPREAD_CURVES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SPREAD_CURVE_ID = resourceClassDetailsE0.SPREAD_CURVE_ID
	) RES_SPREAD_CURVE
,(SELECT NAME
	FROM HR_ALL_ORGANIZATION_UNITS
	WHERE ORGANIZATION_ID = resourceClassDetailsE0.ITEM_MASTER_ID
	) RES_ITEM_MASTER
,(SELECT CATEGORY_SET_NAME
	FROM EGP_CATEGORY_SETS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND CATEGORY_SET_ID = resourceClassDetailsE0.ITEM_CATEGORY_SET_ID
	) RES_ITEM_CATEGORY_SET
,resourceClassDetailsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,resourceClassDetailsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,resourceClassDetailsE0.CREATED_BY  RSC_CREATED_BY
,resourceClassDetailsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_RESOURCE_CLASSES_VL resourceClassesE0
,PJF_PLAN_RES_DEFAULTS resourceClassDetailsE0
WHERE resourceClassesE0.RESOURCE_CLASS_ID = resourceClassDetailsE0.RESOURCE_CLASS_ID
ORDER BY resourceClassesE0.NAME