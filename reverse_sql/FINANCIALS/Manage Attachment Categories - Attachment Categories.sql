/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah Dusenmahamad $:
 * $Date: 2018-01-16 $:
 * $HeadURL:  $:
 * $Id: Manage Attachment Categories - Attachment Categories.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT  FndDocumentCategoriesEO.CATEGORY_NAME       					RES_CATEGORY_NAME,
  FndDocumentCategoriesEO.USER_NAME                                   	RES_USER_NAME,
  ApplTaxonomyPEO.USER_MODULE_NAME                                      RES_MODULE,
  FndDocumentCategoriesEO.DESCRIPTION                                   RES_DESCRIPTION,
 FndDocumentCategoriesEO.LAST_UPDATED_BY  		RSC_LAST_UPDATED_BY
,FndDocumentCategoriesEO.LAST_UPDATE_DATE  		RSC_LAST_UPDATE_DATE
,FndDocumentCategoriesEO.CREATED_BY  			RSC_CREATED_BY
,FndDocumentCategoriesEO.CREATION_DATE  		RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DOCUMENT_CATEGORIES_VL FndDocumentCategoriesEO,
  FND_APPLICATION_VL ApplicationPEO,
  FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
WHERE FndDocumentCategoriesEO.APPLICATION_ID = ApplicationPEO.APPLICATION_ID
AND FndDocumentCategoriesEO.MODULE_ID        = ApplTaxonomyPEO.MODULE_ID
Order by FndDocumentCategoriesEO.CATEGORY_NAME
 