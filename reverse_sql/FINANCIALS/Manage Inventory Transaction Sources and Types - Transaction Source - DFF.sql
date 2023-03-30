/* ****************************************************************************
 * $Revision: 55675 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-12-23  $:
 * $HeadURL:$:
 * $Id: Manage Contact Lookups - Lookup Codes - DFF.sql$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=401##RES##INV_TXN_SOURCE_TYPES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
SELECT MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_NAME RES_NAME
,MtlTxnSourceTypes.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,MtlTxnSourceTypes.ATTRIBUTE1 
,MtlTxnSourceTypes.ATTRIBUTE2
,MtlTxnSourceTypes.ATTRIBUTE3
,MtlTxnSourceTypes.ATTRIBUTE4
,MtlTxnSourceTypes.ATTRIBUTE5
,MtlTxnSourceTypes.ATTRIBUTE6
,MtlTxnSourceTypes.ATTRIBUTE7
,MtlTxnSourceTypes.ATTRIBUTE8
,MtlTxnSourceTypes.ATTRIBUTE9
,MtlTxnSourceTypes.ATTRIBUTE10
,MtlTxnSourceTypes.ATTRIBUTE11
,MtlTxnSourceTypes.ATTRIBUTE12
,MtlTxnSourceTypes.ATTRIBUTE13
,MtlTxnSourceTypes.ATTRIBUTE14
,MtlTxnSourceTypes.ATTRIBUTE15
,MtlTxnSourceTypes.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MtlTxnSourceTypes.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MtlTxnSourceTypes.CREATED_BY RSC_CREATED_BY
,MtlTxnSourceTypes.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_TXN_SOURCE_TYPES_VL MtlTxnSourceTypes
WHERE((transaction_source_type_id NOT                      IN(8,18)
AND(FUSION.inv_logistics_release_level.get_logistics_release_level < 10))
OR(FUSION.inv_logistics_release_level.get_logistics_release_level >= 10))
AND (MtlTxnSourceTypes.ATTRIBUTE_CATEGORY IS NOT NULL OR
MtlTxnSourceTypes.ATTRIBUTE1 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE2 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE3 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE4 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE5 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE6 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE7 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE8 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE9 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE10 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE11 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE12 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE13 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE14 IS NOT NULL OR 
MtlTxnSourceTypes.ATTRIBUTE15 IS NOT NULL)
ORDER BY MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_NAME