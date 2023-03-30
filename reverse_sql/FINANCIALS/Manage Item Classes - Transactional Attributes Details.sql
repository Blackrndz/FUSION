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
,TransAttrEO.DISPLAY_NAME RES_NAME
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGP_TRANS_ATTR_DOMAINS'
	AND LOOKUP_CODE = TransAttrMetaDataEO.TRANS_ATTR_DOMAIN_ID
	) RES_APPLICATION_SCOPE
,TO_CHAR(TransAttrMetaDataEO.START_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_START_DATE
,TO_CHAR(TransAttrMetaDataEO.END_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_END_DATE
,(SELECt MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGP_TRANS_ATTR_DATA_TYPES'
	AND LOOKUP_CODE = TransAttrEO.DATA_TYPE_CODE
	) RES_DATA_TYPE
,(SELECT value_set_code
		FROM fnd_vs_value_sets
		WHERE value_set_id = TransAttrMetaDataEO.value_set_id
		) RES_VALUE_SET
,TransAttrMetaDataEO.DEFAULT_VALUE_ID RES_DEFAULT_VALUE
,(SELECT UNIT_OF_MEASURE
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = TransAttrEO.UOM_CODE
	) RES_UOM
,DECODE(TransAttrMetaDataEO.INACTIVE_FLAG,'Y','Yes','No') RES_INACTIVE
,DECODE(TransAttrMetaDataEO.REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRED
,DECODE(TransAttrMetaDataEO.READONLY_FLAG,'Y','Yes','No') RES_READ_ONLY
,DECODE(TransAttrMetaDataEO.HIDDEN_FLAG,'Y','Yes','No') RES_HIDDEN
,TransAttrEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,TransAttrEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,TransAttrEO.CREATED_BY  RSC_CREATED_BY
,TransAttrEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_CLASSES_VL ItemClassPEO
,EGP_TRANS_ATTRS_METADATA TransAttrMetaDataEO
,EGP_TRANS_ATTRS_VL TransAttrEO
WHERE ItemClassPEO.ITEM_CLASS_ID = TransAttrMetaDataEO.PK1_VALUE
AND TransAttrMetaDataEO.TRANS_ATTR_ID = TransAttrEO.TRANS_ATTR_ID
CONNECT BY ItemClassPEO.PARENT_ITEM_CLASS_ID = ItemClassPEO.ITEM_CLASS_ID
ORDER SIBLINGS BY RES_PARENT_ITEM_CLASS
,RES_ITEM_CLASS
,RES_NAME
,TransAttrMetaDataEO.TRANS_ATTR_DOMAIN_ID
,TransAttrMetaDataEO.START_DATE