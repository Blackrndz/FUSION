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
-- DFF_LOGIC_TO_APPLY=200##RES##AP_TERMS_B
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select PaymentTermHeaderEO.name RES_NAME
,PaymentTermHeaderEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,PaymentTermHeaderEO.ATTRIBUTE1
,PaymentTermHeaderEO.ATTRIBUTE2
,PaymentTermHeaderEO.ATTRIBUTE3
,PaymentTermHeaderEO.ATTRIBUTE4
,PaymentTermHeaderEO.ATTRIBUTE5
,PaymentTermHeaderEO.ATTRIBUTE6
,PaymentTermHeaderEO.ATTRIBUTE7
,PaymentTermHeaderEO.ATTRIBUTE8
,PaymentTermHeaderEO.ATTRIBUTE9
,PaymentTermHeaderEO.ATTRIBUTE10
,PaymentTermHeaderEO.ATTRIBUTE11
,PaymentTermHeaderEO.ATTRIBUTE12
,PaymentTermHeaderEO.ATTRIBUTE13
,PaymentTermHeaderEO.ATTRIBUTE14
,PaymentTermHeaderEO.ATTRIBUTE15
,PaymentTermHeaderEO.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,PaymentTermHeaderEO.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,PaymentTermHeaderEO.CREATED_BY  RSC_CREATED_BY
,PaymentTermHeaderEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM AP_TERMS_VL PaymentTermHeaderEO
where (PaymentTermHeaderEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
PaymentTermHeaderEO.ATTRIBUTE1 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE2 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE3 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE4 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE5 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE6 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE7 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE8 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE9 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE10 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE11 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE12 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE13 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE14 IS NOT NULL OR 
PaymentTermHeaderEO.ATTRIBUTE15 IS NOT NULL
)
ORDER BY PaymentTermHeaderEO.name