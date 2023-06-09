/* ****************************************************************************
 * $Revision: 61261 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-03-03 13:51:16 +0700 (Fri, 03 Mar 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Default%20Catalogs%20-%20Default%20Catalogs.sql $:
 * $Id: Manage Default Catalogs - Default Catalogs.sql 61261 2017-03-03 06:51:16Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10011##RES##EGP_CATEGORY_SETS_DFF
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
SELECT RES_FUNCTIONAL_AREA,
CatalogEO.CATEGORY_SET_NAME RES_CATALOG_NAME
,CatalogEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,CatalogEO.ATTRIBUTE1
,CatalogEO.ATTRIBUTE2
,CatalogEO.ATTRIBUTE3
,CatalogEO.ATTRIBUTE4
,CatalogEO.ATTRIBUTE5
,CatalogEO.ATTRIBUTE6
,CatalogEO.ATTRIBUTE7
,CatalogEO.ATTRIBUTE8
,CatalogEO.ATTRIBUTE9
,CatalogEO.ATTRIBUTE10
,CatalogEO.ATTRIBUTE11
,CatalogEO.ATTRIBUTE12
,CatalogEO.ATTRIBUTE13
,CatalogEO.ATTRIBUTE14
,CatalogEO.ATTRIBUTE15
,CatalogEO.ATTRIBUTE_NUMBER1
,CatalogEO.ATTRIBUTE_NUMBER2
,CatalogEO.ATTRIBUTE_NUMBER3
,CatalogEO.ATTRIBUTE_NUMBER4
,CatalogEO.ATTRIBUTE_NUMBER5
,CatalogEO.ATTRIBUTE_NUMBER6
,CatalogEO.ATTRIBUTE_NUMBER7
,CatalogEO.ATTRIBUTE_NUMBER8
,CatalogEO.ATTRIBUTE_NUMBER9
,CatalogEO.ATTRIBUTE_NUMBER10
,TO_CHAR(CatalogEO.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(CatalogEO.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(CatalogEO.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(CatalogEO.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(CatalogEO.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,CatalogEO.ATTRIBUTE_TIMESTAMP1
,CatalogEO.ATTRIBUTE_TIMESTAMP2
,CatalogEO.ATTRIBUTE_TIMESTAMP3
,CatalogEO.ATTRIBUTE_TIMESTAMP4
,CatalogEO.ATTRIBUTE_TIMESTAMP5
,RSC_LAST_UPDATED_BY
,RSC_LAST_UPDATE_DATE
,RSC_CREATED_BY
,RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM --EGP_DEFAULT_CATEGORY_SETS DefaultCatalogEO
EGP_CATEGORY_SETS_VL CatalogEO
,(SELECT RES_FUNCTIONAL_AREA 
,RES_CATALOG_NAME
,RES_CATALOG_CODE
,RES_DESCRIPTION
,RES_CONTROLLED_AT
,RES_DEFAULT_CATEGORY
,RES_START_DATE
,RES_END_DATE
,RES_ASSIGN_ITEMS_TO_LEAF_LEVEL
,RES_ENABLE_DUPLICATE_CATEGORY_
,RES_ALLOW_MULTIPLE_ITEM_CATEGO
,RES_ENABLE_DELETION_OF_ITEM_CA
,RES_ENABLE_HIERARCHY_FOR_CATAL
,RES_ENABLE_DATE_LEVEL_CONTROL_
,RES_DEFAULT_CATEGORY_REQUIRED
,RES_CATALOG_SET_ID
--,RES_CATEGORY_NAME
--,RES_CATEGORY_CODE
--,RES_DEFAULT_CATEGORY_DESCRIPTI
--,RES_DEFAULT_CATEGORY_START_DAT
--,RES_DEFAULT_CATEGORY_END_DATE
--,RES_RESTRICT_CATEGORY_TO_ITEM_
,RSC_LAST_UPDATED_BY
,RSC_LAST_UPDATE_DATE
,RSC_CREATED_BY
,RSC_CREATION_DATE
,RSC_LEDGER_ID
,RSC_CHART_OF_ACCOUNTS_ID
,RSC_BUSINESS_UNIT_ID
,RSC_LEGAL_ENTITY_ID
,RSC_ORGANIZATION_ID
,RSC_BUSINESS_GROUP_ID
,RSC_ENTERPRISE_ID
,RSC_COUNTRY_ID

FROM (SELECT  ROW_NUMBER() over (PARTITION BY QRSLT.CATEGORY_SET_NAME ORDER BY QRSLT.CATEGORY_SET_NAME ) AS COUNTMAX 
,QRSLT.MEANING RES_FUNCTIONAL_AREA
,QRSLT.CATEGORY_SET_NAME  RES_CATALOG_NAME
,QRSLT.CATALOG_CODE RES_CATALOG_CODE
,QRSLT.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGP_CATALOG_CONTROL_LEVEL'
	AND LOOKUP_CODE = QRSLT.CONTROL_LEVEL
	) RES_CONTROLLED_AT
,(SELECT CATEGORY_NAME
	FROM EGP_CATEGORIES_VL
	WHERE CATEGORY_ID = QRSLT.DEFAULT_CATEGORY_ID) RES_DEFAULT_CATEGORY
,TO_CHAR(QRSLT.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(QRSLT.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,'Yes' RES_ASSIGN_ITEMS_TO_LEAF_LEVEL
,'No' RES_ENABLE_DUPLICATE_CATEGORY_
,DECODE(QRSLT.MULT_ITEM_CAT_ASSIGN_FLAG,'Y','Yes','N','No') RES_ALLOW_MULTIPLE_ITEM_CATEGO
,'No' RES_ENABLE_DELETION_OF_ITEM_CA
,DECODE(QRSLT.HIERARCHY_ENABLED,'Y','Yes','N','No') RES_ENABLE_HIERARCHY_FOR_CATAL
,'No' RES_ENABLE_DATE_LEVEL_CONTROL_
,'No' RES_DEFAULT_CATEGORY_REQUIRED
,EgpCategoriesE0.CATEGORY_NAME RES_CATEGORY_NAME
,EgpCategoriesE0.CATEGORY_CODE RES_CATEGORY_CODE
,EgpCategoriesE0.DESCRIPTION RES_DEFAULT_CATEGORY_DESCRIPTI
,TO_CHAR(EgpCategoriesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_DEFAULT_CATEGORY_START_DAT
,TO_CHAR(EgpCategoriesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_DEFAULT_CATEGORY_END_DATE
,DECODE(EgpCategoriesE0.SUPPLIER_ENABLED_FLAG,'Y','Yes','N','No') RES_RESTRICT_CATEGORY_TO_ITEM_
,QRSLT.CATEGORY_SET_ID1 RES_CATALOG_SET_ID
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
,DefaultCatalogEO.LAST_UPDATED_BY  
,DefaultCatalogEO.LAST_UPDATE_DATE 
,DefaultCatalogEO.CREATED_BY  
,DefaultCatalogEO.CREATION_DATE 
/*,CatalogEO.LAST_UPDATED_BY  
,CatalogEO.LAST_UPDATE_DATE 
,CatalogEO.CREATED_BY  
,CatalogEO.CREATION_DATE */
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

order by  QRSLT.MEANING
,(CASE
	WHEN QRSLT.DEFAULT_CATEGORY_ID = EgpCategorySetValidCatsE0.CATEGORY_ID THEN 
		1
	ELSE
		2
	END )
,EgpCategoriesE0.CATEGORY_NAME)
WHERE COUNTMAX = 1) QRSLT
--,FND_LOOKUPS LookupPEO
WHERE --((DefaultCatalogEO.CATEGORY_SET_ID = CatalogEO.CATEGORY_SET_ID(+)))
CatalogEO.CATEGORY_SET_ID = QRSLT.RES_CATALOG_SET_ID
--AND LookupPEO.lookup_code               = DefaultCatalogEO.functional_area_id
--AND LOOKUPPEO.LOOKUP_TYPE               = 'EGP_CATALOG_FUNCTIONAL_AREAS'
AND (CatalogEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR CatalogEO.ATTRIBUTE1            IS NOT NULL
OR CatalogEO.ATTRIBUTE2            IS NOT NULL
OR CatalogEO.ATTRIBUTE3            IS NOT NULL
OR CatalogEO.ATTRIBUTE4            IS NOT NULL
OR CatalogEO.ATTRIBUTE5            IS NOT NULL
OR CatalogEO.ATTRIBUTE6            IS NOT NULL
OR CatalogEO.ATTRIBUTE7            IS NOT NULL
OR CatalogEO.ATTRIBUTE8            IS NOT NULL
OR CatalogEO.ATTRIBUTE9            IS NOT NULL
OR CatalogEO.ATTRIBUTE10           IS NOT NULL
OR CatalogEO.ATTRIBUTE11           IS NOT NULL
OR CatalogEO.ATTRIBUTE12           IS NOT NULL
OR CatalogEO.ATTRIBUTE13           IS NOT NULL
OR CatalogEO.ATTRIBUTE14           IS NOT NULL
OR CatalogEO.ATTRIBUTE15           IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER1            IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER2            IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER3            IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER4            IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER5            IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER6            IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER7            IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER8            IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER9            IS NOT NULL
OR CatalogEO.ATTRIBUTE_NUMBER10            IS NOT NULL
OR CatalogEO.ATTRIBUTE_DATE1            IS NOT NULL
OR CatalogEO.ATTRIBUTE_DATE2            IS NOT NULL
OR CatalogEO.ATTRIBUTE_DATE3            IS NOT NULL
OR CatalogEO.ATTRIBUTE_DATE4            IS NOT NULL
OR CatalogEO.ATTRIBUTE_DATE5            IS NOT NULL
OR CatalogEO.ATTRIBUTE_TIMESTAMP1            IS NOT NULL
OR CatalogEO.ATTRIBUTE_TIMESTAMP2            IS NOT NULL
OR CatalogEO.ATTRIBUTE_TIMESTAMP3            IS NOT NULL
OR CatalogEO.ATTRIBUTE_TIMESTAMP4            IS NOT NULL
OR CatalogEO.ATTRIBUTE_TIMESTAMP5            IS NOT NULL)