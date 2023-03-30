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
,EgpItemAttributesVl.ATTR_GROUP_DISP_NAME RES_ATTRIBUTE_GROUP
,EgpIcItemAttr.ATTR_GROUP_INTERNAL_NAME RES_ATTRIBUTE_GROUP_INTERNAL_N
,EgpItemAttributesVl.ATTR_DISP_NAME RES_ATTRIBUTE
,EgpIcItemAttr.ATTR_INTERNAL_NAME RES_ATTRIBUTE_INTERNAL_NAME
,'' RES_DATA_TYPE -- Not found in Internal instance
,'' RES_UOM -- Not found in Internal instance
,ItemClassPEO.ITEM_CLASS_CODE RES_DATA_QUALITY_ITEM_CLASS
,'' RES_INHERITED -- Not found in Internal instance
,DECODE(EgpIcItemAttr.MATCHING,'Y','Yes','No') RES_MATCHING
,EgpIcItemAttr.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,EgpIcItemAttr.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,EgpIcItemAttr.CREATED_BY  RSC_CREATED_BY
,EgpIcItemAttr.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_CLASSES_VL ItemClassPEO
,EGP_IC_ITEM_ATTRIBUTES EgpIcItemAttr
,EGP_ITEM_ATTRIBUTES_VL EgpItemAttributesVl
WHERE ItemClassPEO.ITEM_CLASS_ID = EgpIcItemAttr.ITEM_CLASS_ID
AND EgpIcItemAttr.ATTR_GROUP_INTERNAL_NAME = EgpItemAttributesVl.ATTR_GROUP_NAME
AND EgpIcItemAttr.ATTR_INTERNAL_NAME = EgpItemAttributesVl.ATTR_NAME
CONNECT BY ItemClassPEO.PARENT_ITEM_CLASS_ID = ItemClassPEO.ITEM_CLASS_ID