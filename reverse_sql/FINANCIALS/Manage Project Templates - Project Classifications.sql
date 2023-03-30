/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Project%20Classifications.sql $:
* $Id: Manage Project Templates - Project Classifications.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(SELECT CLASS_CATEGORY
	FROM PJF_CLASS_CATEGORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND CLASS_CATEGORY_ID = projClassesE0.CLASS_CATEGORY_ID
	) RES_CLASS_CATEGORY
,(SELECT CLASS_CODE
	FROM PJF_CLASS_CODES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND CLASS_CODE_ID = projClassesE0.CLASS_CODE_ID
	) RES_CLASS_CODE
,projClassesE0.CODE_PERCENTAGE RES_PERCENT
,projClassesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,projClassesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,projClassesE0.CREATED_BY  RSC_CREATED_BY
,projClassesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJF_PROJECT_CLASSES projClassesE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = projClassesE0.PROJECT_ID
ORDER BY projTemplatesE0.NAME,2