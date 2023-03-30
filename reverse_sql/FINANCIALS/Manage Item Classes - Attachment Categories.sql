/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT 
(SELECT ITEM_CLASS_NAME
	FROM EGP_ITEM_CLASSES_VL
	WHERE ITEM_CLASS_ID = ItemClassPEO.PARENT_ITEM_CLASS_ID
	) RES_PARENT_ITEM_CLASS 
,ItemClassPEO.ITEM_CLASS_NAME RES_ITEM_CLASS
,(SELECT USER_NAME
	FROM FND_DOCUMENT_CATEGORIES_VL
	WHERE CATEGORY_ID = ItemClassAttachmentCategoryE1.ATTACH_CATEGORY_ID
	) RES_ATTACHMENT_CATEGORY
,ItemClassPEO.ITEM_CLASS_NAME RES_ATTACHMENT_CATEGORY_ITEM_C
,TO_CHAR(ItemClassAttachmentCategoryE1.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ItemClassAttachmentCategoryE1.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,ItemClassAttachmentCategoryE1.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ItemClassAttachmentCategoryE1.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ItemClassAttachmentCategoryE1.CREATED_BY RSC_CREATED_BY
,ItemClassAttachmentCategoryE1.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_CLASSES_VL ItemClassPEO
,EGP_OBJTYPE_ATTACH_CATS ItemClassAttachmentCategoryE1
WHERE ItemClassPEO.ITEM_CLASS_ID = ItemClassAttachmentCategoryE1.CLASSIFICATION_CODE
CONNECT BY ItemClassPEO.PARENT_ITEM_CLASS_ID = ItemClassPEO.ITEM_CLASS_ID
ORDER SIBLINGS BY RES_PARENT_ITEM_CLASS,RES_ITEM_CLASS