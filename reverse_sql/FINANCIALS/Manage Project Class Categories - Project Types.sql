/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Class%20Categories%20-%20Project%20Types.sql $:
* $Id: Manage Project Class Categories - Project Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT pjfClassCategory.CLASS_CATEGORY							RES_NAME
,pjfProjectTypeEO.PROJECT_TYPE									RES_PROJECT_TYPE
,pjfProjectTypeEO.DESCRIPTION									RES_DESCRIPTION
,DECODE(pjfValidCategoryEO.MANDATORY_FLAG,'Y','Yes','No')		RES_ASSIGN_TO_ALL_PROJECTS
,pjfValidCategoryEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfValidCategoryEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfValidCategoryEO.CREATED_BY  RSC_CREATED_BY
,pjfValidCategoryEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_CLASS_CATEGORIES_VL pjfClassCategory
,PJF_VALID_CATEGORIES pjfValidCategoryEO
,PJF_PROJECT_TYPES_VL pjfProjectTypeEO
WHERE pjfClassCategory.CLASS_CATEGORY_ID = pjfValidCategoryEO.CLASS_CATEGORY_ID
AND pjfValidCategoryEO.OBJECT_TYPE_ID =  pjfProjectTypeEO.PROJECT_TYPE_ID
AND pjfProjectTypeEO.LANGUAGE = USERENV('LANG')
ORDER BY pjfClassCategory.CLASS_CATEGORY,pjfProjectTypeEO.PROJECT_TYPE	


