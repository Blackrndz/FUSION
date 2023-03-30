/* ****************************************************************************
* $Revision: 61485 $:
* $Author: chanatip.buabhom $:
* $Date: 2017-03-21 17:10:25 +0700 (Tue, 21 Mar 2017) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Expense%20Fields%20by%20Category%20-%20Airfare.sql $:
* $Id: Manage Expense Fields by Category - Airfare.sql 61485 2017-03-21 10:10:25Z chanatip.buabhom $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT EgpStructureTypesE0.DISPLAY_NAME RES_DISPLAY_NAME
,FndDocumentCategoriesE0.USER_NAME RES_SELECTED_ATTACHMENT_CATEGO
,EgpStAttachCategoryAssocE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,EgpStAttachCategoryAssocE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,EgpStAttachCategoryAssocE0.CREATED_BY RSC_CREATED_BY
,EgpStAttachCategoryAssocE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_STRUCTURE_TYPES_VL EgpStructureTypesE0
,EGP_ST_ATTACH_CATEGORY_ASSOC EgpStAttachCategoryAssocE0
,FND_DOCUMENT_CATEGORIES_VL FndDocumentCategoriesE0
WHERE EgpStructureTypesE0.STRUCTURE_TYPE_NAME = 'ITM_STR_TYP'
AND EgpStructureTypesE0.LANGUAGE = USERENV('LANG')
AND EgpStructureTypesE0.STRUCTURE_TYPE_ID = EgpStAttachCategoryAssocE0.STRUCTURE_TYPE_ID
AND EgpStAttachCategoryAssocE0.ATTACH_CATEGORY_ID = FndDocumentCategoriesE0.CATEGORY_ID
ORDER BY EgpStructureTypesE0.DISPLAY_NAME
,FndDocumentCategoriesE0.USER_NAME