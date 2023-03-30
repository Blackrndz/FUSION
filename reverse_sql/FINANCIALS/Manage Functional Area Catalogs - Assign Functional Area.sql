/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Functional%20Area%20Catalogs%20-%20Assign%20Functional%20Area.sql $:
 * $Id: Manage Functional Area Catalogs - Assign Functional Area.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT  DISTINCT QRSLT.CATEGORY_SET_NAME  RES_CATALOG_NAME
,QRSLT.MEANING RES_FUNCTIONAL_AREA


,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from (
SELECT 	DefaultCatalogEO.FUNCTIONAL_AREA_ID
,DefaultCatalogEO.CATEGORY_SET_ID
,CatalogEO.CATEGORY_SET_ID AS CATEGORY_SET_ID1
,CatalogEO.CATEGORY_SET_NAME
,CatalogEO.CATALOG_CODE
,CatalogEO.DESCRIPTION
,CatalogEO.CONTROL_LEVEL
,CatalogEO.DEFAULT_CATEGORY_ID
,CatalogEO.START_DATE
,CatalogEO.END_DATE
,CatalogEO.MULT_ITEM_CAT_ASSIGN_FLAG
,CatalogEO.HIERARCHY_ENABLED
,DefaultCatalogEO.JOB_DEFINITION_NAME
,DefaultCatalogEO.JOB_DEFINITION_PACKAGE
,DefaultCatalogEO.CATEGORY_SET_ID AS CATEGORY_SET_ID2
,DefaultCatalogEO.OBJECT_VERSION_NUMBER
,LookupPEO.MEANING
,LookupPEO.LOOKUP_TYPE
,LOOKUPPEO.LOOKUP_CODE
/*,DefaultCatalogEO.LAST_UPDATED_BY  
,DefaultCatalogEO.LAST_UPDATE_DATE 
,DefaultCatalogEO.CREATED_BY  
,DefaultCatalogEO.CREATION_DATE */
,CatalogEO.LAST_UPDATED_BY  
,CatalogEO.LAST_UPDATE_DATE 
,CatalogEO.CREATED_BY  
,CatalogEO.CREATION_DATE 
FROM EGP_DEFAULT_CATEGORY_SETS DefaultCatalogEO
,EGP_CATEGORY_SETS_VL CatalogEO
,FND_LOOKUPS LookupPEO
WHERE((DefaultCatalogEO.CATEGORY_SET_ID = CatalogEO.CATEGORY_SET_ID(+)))
AND LookupPEO.lookup_code               = DefaultCatalogEO.functional_area_id
AND LOOKUPPEO.LOOKUP_TYPE               = 'EGP_CATALOG_FUNCTIONAL_AREAS'
) QRSLT
,EGP_CATEGORY_SET_VALID_CATS EgpCategorySetValidCatsE0
,EGP_CATEGORIES_VL EgpCategoriesE0
WHERE QRSLT.CATEGORY_SET_ID = EgpCategorySetValidCatsE0.CATEGORY_SET_ID
AND EgpCategorySetValidCatsE0.CATEGORY_ID = EgpCategoriesE0.CATEGORY_ID
