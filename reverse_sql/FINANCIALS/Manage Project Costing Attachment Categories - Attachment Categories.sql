/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Costing%20Attachment%20Categories%20-%20Attachment%20Categories.sql $:
 * $Id: Manage Project Costing Attachment Categories - Attachment Categories.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT fndDocCategoryEO.CATEGORY_NAME RES_CATEGORY_NAME
,fndDocCategoryEO.USER_NAME RES_USER_NAME
,modulesE0.USER_MODULE_NAME RES_MODULE
,fndDocCategoryEO.DESCRIPTION RES_DESCRIPTION
,fndDocCategoryEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndDocCategoryEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndDocCategoryEO.CREATED_BY RSC_CREATED_BY
,fndDocCategoryEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DOCUMENT_CATEGORIES_VL fndDocCategoryEO
,FND_APPL_TAXONOMY_VL modulesE0
WHERE fndDocCategoryEO.MODULE_ID = modulesE0.MODULE_ID
AND modulesE0.USER_MODULE_NAME LIKE 'Project%'
ORDER BY fndDocCategoryEO.CATEGORY_NAME