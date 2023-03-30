/* ****************************************************************************
 * $Revision: 78786 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-06-20 10:56:13 +0700 (Mon, 20 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Transaction%20Types%20-%20DFF.sql $:
 * $Id: Manage Transaction Types - Transaction Types - DFF.sql 78786 2022-06-20 03:56:13Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##RA_CUST_TRX_TYPES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select DISTINCT FND_SETID_SETS_VL.SET_NAME RES_TRANSACTION_TYPE_SET
,RaCustTrxTypesAll.NAME RES_NAME
,RaCustTrxTypesAll.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,RaCustTrxTypesAll.ATTRIBUTE1 
,RaCustTrxTypesAll.ATTRIBUTE2
,RaCustTrxTypesAll.ATTRIBUTE3
,RaCustTrxTypesAll.ATTRIBUTE4
,RaCustTrxTypesAll.ATTRIBUTE5
,RaCustTrxTypesAll.ATTRIBUTE6
,RaCustTrxTypesAll.ATTRIBUTE7
,RaCustTrxTypesAll.ATTRIBUTE8
,RaCustTrxTypesAll.ATTRIBUTE9
,RaCustTrxTypesAll.ATTRIBUTE10
,RaCustTrxTypesAll.ATTRIBUTE11
,RaCustTrxTypesAll.ATTRIBUTE12
,RaCustTrxTypesAll.ATTRIBUTE13
,RaCustTrxTypesAll.ATTRIBUTE14
,RaCustTrxTypesAll.ATTRIBUTE15
,RaCustTrxTypesAll.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,RaCustTrxTypesAll.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,RaCustTrxTypesAll.CREATED_BY  RSC_CREATED_BY
,RaCustTrxTypesAll.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,RaCustTrxTypesAll.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM FUSION.RA_CUST_TRX_TYPES_ALL RaCustTrxTypesAll
,FUSION.FND_SETID_SETS_VL 
WHERE (RaCustTrxTypesAll.ATTRIBUTE_CATEGORY IS NOT NULL OR
	RaCustTrxTypesAll.ATTRIBUTE1 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE2 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE3 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE4 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE5 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE6 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE7 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE8 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE9 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE10 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE11 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE12 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE13 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE14 IS NOT NULL OR 
	RaCustTrxTypesAll.ATTRIBUTE15 IS NOT NULL )
AND  FND_SETID_SETS_VL.SET_ID = RaCustTrxTypesAll.SET_ID 
order by RES_NAME