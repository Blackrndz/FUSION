/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Units%20of%20Measure%20Profiles%20-%20Profile%20Values.sql $:
 * $Id: Manage Units of Measure Profiles - Profile Values.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EGP_SYSTEM_ITEMS_B
-- STRICTLY_BATCH_SEQ = RES_ITEM_NUMBER

SELECT /*+ PARALLEL(8) */ styleAttrE0.ATTRIBUTE_GROUP_CODE RES_ATTRIBUTE_GROUP_CODE
,styleAttrE0.ATTRIBUTE_CODE RES_ATTRIBUTE_CODE
,(SELECT VALUE_SET_CODE
	FROM FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = styleAttrE0.VALUE_SET_ID
	) RES_VALUE_SET_CODE
,'' RES_BATCH_ID
,'' RES_BATCH_NUMBER
,(SELECT DISTINCT ITEM_NUMBER
	FROM EGP_SYSTEM_ITEMS_B
	WHERE INVENTORY_ITEM_ID = styleAttrE0.INVENTORY_ITEM_ID
	) RES_ITEM_NUMBER
,'' RES_SOURCE_SYSTEM_CODE
,'' RES_SOURCE_SYSTEM_REFERENCE
,styleAttrE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,styleAttrE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,styleAttrE0.CREATED_BY  RSC_CREATED_BY
,styleAttrE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGO_STYLE_VARIANT_ATTR_VS styleAttrE0