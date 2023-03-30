/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Costing%20Attachment%20Categories%20-%20Attachment%20Entities.sql $:
 * $Id: Manage Project Costing Attachment Categories - Attachment Entities.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT fndDocCategoryEO.CATEGORY_NAME RES_CATEGORY_NAME
,(SELECT ENTITY_NAME 
	FROM FND_DOCUMENT_ENTITIES_VL
	WHERE DOCUMENT_ENTITY_ID = fndDocCategoryEntiteEO.DOCUMENT_ENTITY_ID
	) RES_ENTITY_NAME
,fndDocCategoryEntiteEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndDocCategoryEntiteEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndDocCategoryEntiteEO.CREATED_BY RSC_CREATED_BY
,fndDocCategoryEntiteEO.CREATION_DATE RSC_CREATION_DATE
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
,FND_DOC_CATEGORIES_TO_ENTITIES fndDocCategoryEntiteEO
WHERE fndDocCategoryEO.MODULE_ID = modulesE0.MODULE_ID
AND modulesE0.USER_MODULE_NAME LIKE 'Project%'
AND fndDocCategoryEO.CATEGORY_ID = fndDocCategoryEntiteEO.CATEGORY_ID
ORDER BY 1,2