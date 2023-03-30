/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT ItemStatusEO.INVENTORY_ITEM_STATUS_CODE RES_CODE
,ItemAttributePEO.ATTR_GROUP_DISP_NAME RES_ATTRIBUTE_GROUP
,ItemAttributePEO.ATTR_DISP_NAME RES_ATTRIBUTE
,LookupPEO2.MEANING RES_ATTRIBUTE_VALUE
,LookupPEO.MEANING RES_USAGE
,LookupPEO1.MEANING RES_CONTROLLED_AT
,StatusAttributeValueEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,StatusAttributeValueEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,StatusAttributeValueEO.CREATED_BY RSC_CREATED_BY
,StatusAttributeValueEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_STATUS_VL ItemStatusEO
,EGP_STATUS_ATTRIBUTE_VALUES StatusAttributeValueEO
,EGP_ITEM_ATTRIBUTES_VL ItemAttributePEO
,FND_LOOKUPS LookupPEO
,FND_LOOKUPS LookupPEO1
,FND_LOOKUPS LookupPEO2
WHERE ItemStatusEO.INVENTORY_ITEM_STATUS_CODE = StatusAttributeValueEO.INVENTORY_ITEM_STATUS_CODE
AND StatusAttributeValueEO.ATTRIBUTE_NAME     = ItemAttributePEO.ATTR_NAME
AND(ItemAttributePEO.CONTROL_LEVEL            = 'M'
OR ItemAttributePEO.CONTROL_LEVEL             = 'C')
AND(LookupPEO.LOOKUP_CODE                     = StatusAttributeValueEO.STATUS_CONTROL_CODE
AND LookupPEO.LOOKUP_TYPE                     = 'EGP_STATUS_CONTROL_CODES')
AND(LookupPEO1.LOOKUP_CODE                    = ItemAttributePEO.CONTROL_LEVEL
AND LookupPEO1.LOOKUP_TYPE                    = 'EGP_ORG_CONTROL_CODES')
AND(LookupPEO2.LOOKUP_CODE                    = StatusAttributeValueEO.ATTRIBUTE_VALUE
AND LookupPEO2.LOOKUP_TYPE                    = 'EGP_COMMON_YES_NO_CHAR')
ORDER BY StatusAttributeValueEO.INVENTORY_ITEM_STATUS_CODE
,ItemAttributePEO.ATTR_GROUP_DISP_NAME
,ItemAttributePEO.ATTR_DISP_NAME