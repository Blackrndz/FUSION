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
-- DFF_LOGIC_TO_APPLY=401##RES##INV_TRANSACTION_TYPES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
SELECT MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_NAME RES_TRANSACTION_SOURCE_NAME
,MtlTxnTypes.TRANSACTION_TYPE_NAME RES_TRANSACTION_TYPE_NAME
,MtlTxnTypes.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,MtlTxnTypes.ATTRIBUTE1
,MtlTxnTypes.ATTRIBUTE2
,MtlTxnTypes.ATTRIBUTE3
,MtlTxnTypes.ATTRIBUTE4
,MtlTxnTypes.ATTRIBUTE5
,MtlTxnTypes.ATTRIBUTE6
,MtlTxnTypes.ATTRIBUTE7
,MtlTxnTypes.ATTRIBUTE8
,MtlTxnTypes.ATTRIBUTE9
,MtlTxnTypes.ATTRIBUTE10
,MtlTxnTypes.ATTRIBUTE11
,MtlTxnTypes.ATTRIBUTE12
,MtlTxnTypes.ATTRIBUTE13
,MtlTxnTypes.ATTRIBUTE14
,MtlTxnTypes.ATTRIBUTE15
,MtlTxnTypes.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MtlTxnTypes.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MtlTxnTypes.CREATED_BY RSC_CREATED_BY
,MtlTxnTypes.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_TXN_SOURCE_TYPES_VL MtlTxnSourceTypes
,INV_TRANSACTION_TYPES_VL MtlTxnTypes
WHERE((MtlTxnSourceTypes.transaction_source_type_id NOT    IN(8,18)
AND(FUSION.inv_logistics_release_level.get_logistics_release_level < 10))
OR(FUSION.inv_logistics_release_level.get_logistics_release_level >= 10))
AND MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_ID            = MtlTxnTypes.TRANSACTION_SOURCE_TYPE_ID
AND(MtlTxnTypes.ATTRIBUTE_CATEGORY                         IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE1                                  IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE2                                  IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE3                                  IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE4                                  IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE5                                  IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE6                                  IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE7                                  IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE8                                  IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE9                                  IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE10                                 IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE11                                 IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE12                                 IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE13                                 IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE14                                 IS NOT NULL
OR MtlTxnTypes.ATTRIBUTE15                                 IS NOT NULL)
ORDER BY MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_NAME
,MtlTxnTypes.TRANSACTION_TYPE_NAME