/* ****************************************************************************
 * $Revision:  $:
 * $Author:  $:
 * $Date:  $:
 * $HeadURL:  $:
 * $Id:  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##AR_RECEIPT_METHODS
-- DFF_ATTRIBUTES=ATTRIBUTE,GLOBAL_ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select ArReceiptClasses.NAME AS RES_NAME
,ARM.name AS RES_RECEIPT_METHODS_NAME
,ARM.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,ARM.ATTRIBUTE1
,ARM.ATTRIBUTE2
,ARM.ATTRIBUTE3
,ARM.ATTRIBUTE4
,ARM.ATTRIBUTE5
,ARM.ATTRIBUTE6
,ARM.ATTRIBUTE7
,ARM.ATTRIBUTE8
,ARM.ATTRIBUTE9
,ARM.ATTRIBUTE10
,ARM.ATTRIBUTE11
,ARM.ATTRIBUTE12
,ARM.ATTRIBUTE13
,ARM.ATTRIBUTE14
,ARM.ATTRIBUTE15
,ARM.GLOBAL_ATTRIBUTE1
,ARM.GLOBAL_ATTRIBUTE2
,ARM.GLOBAL_ATTRIBUTE3
,ARM.GLOBAL_ATTRIBUTE4
,ARM.GLOBAL_ATTRIBUTE5
,ARM.GLOBAL_ATTRIBUTE6
,ARM.GLOBAL_ATTRIBUTE7
,ARM.GLOBAL_ATTRIBUTE8
,ARM.GLOBAL_ATTRIBUTE9
,ARM.GLOBAL_ATTRIBUTE10
,ARM.GLOBAL_ATTRIBUTE11
,ARM.GLOBAL_ATTRIBUTE12
,ARM.GLOBAL_ATTRIBUTE13
,ARM.GLOBAL_ATTRIBUTE14
,ARM.GLOBAL_ATTRIBUTE15
,ARM.GLOBAL_ATTRIBUTE16
,ARM.GLOBAL_ATTRIBUTE17
,ARM.GLOBAL_ATTRIBUTE18
,ARM.GLOBAL_ATTRIBUTE19
,ARM.GLOBAL_ATTRIBUTE20
,ARM.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,ARM.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,ARM.CREATED_BY  RSC_CREATED_BY
,ARM.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM FUSION.AR_RECEIPT_CLASSES ArReceiptClasses
,AR_RECEIPT_METHODS ARM
where (ARM.ATTRIBUTE_CATEGORY IS NOT NULL OR
ARM.ATTRIBUTE1 IS NOT NULL OR 
ARM.ATTRIBUTE2 IS NOT NULL OR 
ARM.ATTRIBUTE3 IS NOT NULL OR 
ARM.ATTRIBUTE4 IS NOT NULL OR 
ARM.ATTRIBUTE5 IS NOT NULL OR 
ARM.ATTRIBUTE6 IS NOT NULL OR 
ARM.ATTRIBUTE7 IS NOT NULL OR 
ARM.ATTRIBUTE8 IS NOT NULL OR 
ARM.ATTRIBUTE9 IS NOT NULL OR 
ARM.ATTRIBUTE10 IS NOT NULL OR 
ARM.ATTRIBUTE11 IS NOT NULL OR 
ARM.ATTRIBUTE12 IS NOT NULL OR 
ARM.ATTRIBUTE13 IS NOT NULL OR 
ARM.ATTRIBUTE14 IS NOT NULL OR 
ARM.ATTRIBUTE15 IS NOT NULL OR
ARM.GLOBAL_ATTRIBUTE1 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE2 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE3 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE4 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE5 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE6 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE7 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE8 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE9 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE10 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE11 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE12 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE13 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE14 IS NOT NULL OR 
ARM.GLOBAL_ATTRIBUTE15 IS NOT NULL OR
ARM.GLOBAL_ATTRIBUTE16 IS NOT NULL OR
ARM.GLOBAL_ATTRIBUTE17 IS NOT NULL OR
ARM.GLOBAL_ATTRIBUTE18 IS NOT NULL OR
ARM.GLOBAL_ATTRIBUTE19 IS NOT NULL OR
ARM.GLOBAL_ATTRIBUTE20 IS NOT NULL
)
AND ARM.RECEIPT_CLASS_ID                           = ArReceiptClasses.RECEIPT_CLASS_ID
ORDER BY RES_NAME
 
/*SELECT ArReceiptClasses.NAME AS RES_NAME
, ARM.name AS RES_RECEIPT_METHODS_NAME
, DFF.FIELD_NAME AS RES_FIELD_NAME
, DFF.FIELD_VALUE AS RES_FIELD_VALUE
,NULL MAPPER 
,ARM.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,ARM.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
FROM FUSION.AR_RECEIPT_CLASSES ArReceiptClasses
,AR_RECEIPT_METHODS ARM
, TABLE(FUSION_READONLY.##RES_PLSQL_PACKAGE_NAME##.GET_DFF(P_APPLICATION_ID => 222
														  ,P_DFF_CODE => 'AR_RECEIPT_METHODS'
														  ,P_BASE_TABLE => 'AR_RECEIPT_METHODS'
														  ,P_PK_COLUMN_1 => 'RECEIPT_METHOD_ID'																	  
	)) DFF
WHERE DFF.FIELD_VALUE                     IS NOT NULL
AND ARM.RECEIPT_CLASS_ID                           = ArReceiptClasses.RECEIPT_CLASS_ID
AND  ARM.RECEIPT_METHOD_ID = TO_NUMBER(DFF.COL_1)
and (ARM.last_updated_by ##LAST_UPDATED_BY_OPERATOR## (##USER_NAME_LIST##) AND ARM.last_update_date ##LAST_UPDATE_DATE_OPERATOR##  to_date('##SEEDED_DATE##'))
ORDER BY RES_NAME*/