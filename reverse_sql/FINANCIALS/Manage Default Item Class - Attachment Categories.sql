/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Default%20Item%20Class%20-%20Attachment%20Categories.sql $:
 * $Id: Manage Default Item Class - Attachment Categories.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT ItemClassPEO.ITEM_CLASS_CODE RES_INTERNAL_NAME
,(SELECT USER_NAME
	FROM FND_DOCUMENT_CATEGORIES_VL
	WHERE CATEGORY_ID = ItemClassAttachmentCategoryE1.ATTACH_CATEGORY_ID
	) RES_ATTACHMENT_CATEGORY
,ItemClassPEO.ITEM_CLASS_NAME RES_ITEM_CLASS
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
WHERE ItemClassPEO.PARENT_ITEM_CLASS_ID NOT IN (SELECT ITEM_CLASS_ID FROM EGP_ITEM_CLASSES_VL)
AND ItemClassPEO.ITEM_CLASS_ID = ItemClassAttachmentCategoryE1.CLASSIFICATION_CODE
ORDER BY 1,2