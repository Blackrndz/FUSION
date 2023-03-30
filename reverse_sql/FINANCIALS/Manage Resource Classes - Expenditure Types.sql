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
	FROM HR_ALL_ORGANIZATION_UNITS
	WHERE ORGANIZATION_ID = resourceExpE0.PROJECT_UNIT_ID
	) RES_PROJECT_UNIT
,(SELECT EXPENDITURE_TYPE_NAME
	FROM PJF_EXP_TYPES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND EXPENDITURE_TYPE_ID = resourceExpE0.EXPENDITURE_TYPE_ID
	) RES_EXPENDITURE_TYPES
,resourceExpE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,resourceExpE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,resourceExpE0.CREATED_BY  RSC_CREATED_BY
,resourceExpE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,resourceExpE0.PROJECT_UNIT_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_RESOURCE_CLASSES_VL resourceClassesE0
,PJF_RES_CLASS_EXP_TYPES resourceExpE0
WHERE resourceClassesE0.RESOURCE_CLASS_ID = resourceExpE0.RESOURCE_CLASS_ID
ORDER BY resourceClassesE0.NAME,2