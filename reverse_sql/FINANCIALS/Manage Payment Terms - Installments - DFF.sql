/* ****************************************************************************
 * $Revision: 52194 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-01-27 10:34:05 +0700 (Wed, 27 Jan 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Terms%20-%20Installments.sql $:
 * $Id: Manage Payment Terms - Installments.sql 52194 2016-01-27 03:34:05Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=200##RES##AP_TERMS_LINES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select PaymentTermHeaderEO.name RES_NAME
,(Detail.SEQUENCE_NUM-1) AS RES_SEQUENCE
,Detail.due_percent AS RES_DUE
,due_amount  RES_AMOUNT_DUE
,Detail.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,Detail.ATTRIBUTE1
,Detail.ATTRIBUTE2
,Detail.ATTRIBUTE3
,Detail.ATTRIBUTE4
,Detail.ATTRIBUTE5
,Detail.ATTRIBUTE6
,Detail.ATTRIBUTE7
,Detail.ATTRIBUTE8
,Detail.ATTRIBUTE9
,Detail.ATTRIBUTE10
,Detail.ATTRIBUTE11
,Detail.ATTRIBUTE12
,Detail.ATTRIBUTE13
,Detail.ATTRIBUTE14
,Detail.ATTRIBUTE15
,Detail.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  RSC_CREATED_BY
,Detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM AP_TERMS_LINES Detail
, AP_TERMS_VL PaymentTermHeaderEO
where (Detail.ATTRIBUTE_CATEGORY IS NOT NULL OR
Detail.ATTRIBUTE1 IS NOT NULL OR 
Detail.ATTRIBUTE2 IS NOT NULL OR 
Detail.ATTRIBUTE3 IS NOT NULL OR 
Detail.ATTRIBUTE4 IS NOT NULL OR 
Detail.ATTRIBUTE5 IS NOT NULL OR 
Detail.ATTRIBUTE6 IS NOT NULL OR 
Detail.ATTRIBUTE7 IS NOT NULL OR 
Detail.ATTRIBUTE8 IS NOT NULL OR 
Detail.ATTRIBUTE9 IS NOT NULL OR 
Detail.ATTRIBUTE10 IS NOT NULL OR 
Detail.ATTRIBUTE11 IS NOT NULL OR 
Detail.ATTRIBUTE12 IS NOT NULL OR 
Detail.ATTRIBUTE13 IS NOT NULL OR 
Detail.ATTRIBUTE14 IS NOT NULL OR 
Detail.ATTRIBUTE15 IS NOT NULL
) and PaymentTermHeaderEO.term_id = Detail.term_id
ORDER BY PaymentTermHeaderEO.name
,Detail.SEQUENCE_NUM