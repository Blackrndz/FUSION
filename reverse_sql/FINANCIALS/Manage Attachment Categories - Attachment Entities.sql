/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah Dusenmahamad $:
 * $Date: 2018-01-16 $:
 * $HeadURL:  $:
 * $Id: Manage Attachment Categories - Attachment Entities.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT 
  FndDocumentCategoriesEO.CATEGORY_NAME   RES_CATEGORY_NAME,
  FndDocumentEntitiesEO.ENTITY_NAME       RES_ENTITY_NAME,
  FndDocumentEntitiesEO.LAST_UPDATED_BY  		RSC_LAST_UPDATED_BY
,FndDocumentEntitiesEO.LAST_UPDATE_DATE  		RSC_LAST_UPDATE_DATE
,FndDocumentEntitiesEO.CREATED_BY  			RSC_CREATED_BY
,FndDocumentEntitiesEO.CREATION_DATE  		RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DOC_CATEGORIES_TO_ENTITIES FndDocCategoriesToEntitiesEO,
  FND_DOCUMENT_ENTITIES_VL FndDocumentEntitiesEO,
  FND_DOCUMENT_CATEGORIES_VL FndDocumentCategoriesEO
WHERE FndDocCategoriesToEntitiesEO.DOCUMENT_ENTITY_ID = FndDocumentEntitiesEO.DOCUMENT_ENTITY_ID
AND FndDocCategoriesToEntitiesEO.CATEGORY_ID          = FndDocumentCategoriesEO.CATEGORY_ID
Order by FndDocCategoriesToEntitiesEO.DOCUMENT_ENTITY_ID