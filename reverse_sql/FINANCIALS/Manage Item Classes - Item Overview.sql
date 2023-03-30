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
,EgpItemClassEntity.SEQUENCE RES_SEQUENCE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGP_IC_ODA_UDA'
	AND LOOKUP_CODE = EgpItemClassEntity.ATTR_GROUP_TYPE
	) RES_ENTITY_TYPE
,(CASE
	WHEN EgpItemClassEntity.ATTR_GROUP_TYPE = 'ODA' THEN
		(SELECT DISTINCT ATTR_GROUP_DISP_NAME
			FROM EGP_ITEM_ATTRIBUTES_VL
			WHERE ATTR_GROUP_NAME = EgpItemClassEntity.ATTR_GROUP_NAME)
	WHEN EgpItemClassEntity.ATTR_GROUP_TYPE = 'UDA' THEN
		EgpItemClassEntity.ATTR_GROUP_NAME
	END) RES_ENTITY_GROUP
,ItemClassPEO.ITEM_CLASS_CODE RES_ITEM_OVERVIEW_ITEM_CLASS
,EgpItemClassEntity.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,EgpItemClassEntity.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,EgpItemClassEntity.CREATED_BY  RSC_CREATED_BY
,EgpItemClassEntity.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_CLASSES_VL ItemClassPEO
,EGP_ITEM_CLASS_ENTITY_GROUPS EgpItemClassEntity
WHERE ItemClassPEO.ITEM_CLASS_ID = EgpItemClassEntity.ITEM_CLASS_ID
CONNECT BY ItemClassPEO.PARENT_ITEM_CLASS_ID = ItemClassPEO.ITEM_CLASS_ID
ORDER SIBLINGS BY RES_PARENT_ITEM_CLASS,RES_ITEM_CLASS