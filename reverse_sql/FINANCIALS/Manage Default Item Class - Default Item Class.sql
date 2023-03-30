/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Default%20Item%20Class%20-%20Default%20Item%20Class.sql $:
 * $Id: Manage Default Item Class - Default Item Class.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT ItemClassPEO.ITEM_CLASS_NAME RES_ITEM_CLASS
,ItemClassPEO.ITEM_CLASS_CODE RES_INTERNAL_NAME
,ItemClassPEO.DESCRIPTION RES_DESCRIPTION
,DECODE(ItemClassPEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,ParentItemClassPEO.ITEM_CLASS_NAME RES_PARENT_ITEM
,ParentItemClassPEO.DESCRIPTION RES_PARENT_ITEM_CLASS_DESCRIPT
,DECODE(ItemClassPEO.ITEM_CREATION_ALLOWED_FLAG,'Y','Yes','No') RES_ITEM_CREATION_ALLOWED
,ItemClassPEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ItemClassPEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ItemClassPEO.CREATED_BY  RSC_CREATED_BY
,ItemClassPEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_CLASSES_VL ItemClassPEO
,EGP_ITEM_CLASSES_VL ParentItemClassPEO
WHERE ItemClassPEO.PARENT_ITEM_CLASS_ID NOT IN (SELECT ITEM_CLASS_ID FROM EGP_ITEM_CLASSES_VL)
AND ItemClassPEO.PARENT_ITEM_CLASS_ID = ParentItemClassPEO.ITEM_CLASS_ID(+)