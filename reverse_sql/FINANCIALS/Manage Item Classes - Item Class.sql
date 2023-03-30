/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=EGP_ITEM_CLASSES_VL
 
SELECT 
(SELECT ITEM_CLASS_NAME
	FROM EGP_ITEM_CLASSES_VL
	WHERE ITEM_CLASS_ID = ItemClassPEO.PARENT_ITEM_CLASS_ID
	) RES_PARENT_ITEM_CLASS 
,ItemClassPEO.ITEM_CLASS_NAME RES_ITEM_CLASS
,ItemClassPEO.ITEM_CLASS_CODE RES_INTERNAL_NAME
,ItemClassPEO.DESCRIPTION RES_DESCRIPTION
,DECODE(ItemClassPEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,(SELECT DESCRIPTION
	FROM EGP_ITEM_CLASSES_VL
	WHERE ITEM_CLASS_ID = ItemClassPEO.PARENT_ITEM_CLASS_ID
	) RES_PARENT_ITEM_CLASS_DESCRIPT 
,DECODE(ItemClassPEO.ITEM_CREATION_ALLOWED_FLAG,'Y','Yes','No') RES_ITEM_CREATION_ALLOWED
,DECODE(ItemClassPEO.DEFAULT_ITEM_CLASS_FLAG,'Y','Yes','No')  RES_DEFAULT_ITEM_CLASS
,DECODE(ItemClassPEO.PUBLIC_FLAG,'Y','Yes','No')  RES_PUBLIC
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
START WITH ItemClassPEO.PARENT_ITEM_CLASS_ID = -1
CONNECT BY NOCYCLE PRIOR ItemClassPEO.ITEM_CLASS_ID =  ItemClassPEO.PARENT_ITEM_CLASS_ID
ORDER SIBLINGS BY RES_PARENT_ITEM_CLASS,RES_ITEM_CLASS