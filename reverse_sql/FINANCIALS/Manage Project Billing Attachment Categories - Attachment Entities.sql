/* ****************************************************************************
* $Revision: 55270 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-05-17 15:48:14 +0700 (Tue, 17 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Attachment%20Categories%20-%20Attachment%20Entities.sql $:
* $Id: Manage Applications Core Attachment Categories - Attachment Entities.sql 55270 2016-05-17 08:48:14Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT FndDocumentCategoriesVlEO.CATEGORY_NAME RES_CATEGORY_NAME
,(SELECT USER_ENTITY_NAME 
	FROM FND_DOCUMENT_ENTITIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND DOCUMENT_ENTITY_ID = FndDocCategoriesToEntitiesEO.DOCUMENT_ENTITY_ID
	) RES_ENTITY_NAME
,FndDocCategoriesToEntitiesEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,FndDocCategoriesToEntitiesEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,FndDocCategoriesToEntitiesEO.CREATED_BY RSC_CREATED_BY
,FndDocCategoriesToEntitiesEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DOCUMENT_CATEGORIES_VL FndDocumentCategoriesVlEO
,FND_APPL_TAXONOMY_VL modulesE0
,FND_DOC_CATEGORIES_TO_ENTITIES FndDocCategoriesToEntitiesEO
WHERE FndDocumentCategoriesVlEO.MODULE_ID = modulesE0.MODULE_ID
AND modulesE0.USER_MODULE_NAME LIKE 'Project%'
AND FndDocumentCategoriesVlEO.CATEGORY_ID = FndDocCategoriesToEntitiesEO.CATEGORY_ID
ORDER BY RES_CATEGORY_NAME