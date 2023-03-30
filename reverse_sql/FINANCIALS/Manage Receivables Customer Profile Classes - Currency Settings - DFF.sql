 /* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Customer%20Profile%20Classes%20-%20Currency%20Settings%20-%20DFF.sql $:
 * $Id: Manage Receivables Customer Profile Classes - Currency Settings - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##AR_CUSTOMER_PROFILE_CLASSES_HZ
-- DFF_ATTRIBUTES=ATTRIBUTE,JGZZ_ATTRIBUTE,GLOBAL_ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select HzCustProfileClasses.NAME AS RES_PROFILE_CLASS_NAME
,(HzCustProfClassAmts.CURRENCY_CODE|| ' - ' ||CurrencyPEO.NAME) AS RES_CURRENCY
,HzCustProfClassAmts.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,HzCustProfClassAmts.ATTRIBUTE1
,HzCustProfClassAmts.ATTRIBUTE2
,HzCustProfClassAmts.ATTRIBUTE3
,HzCustProfClassAmts.ATTRIBUTE4
,HzCustProfClassAmts.ATTRIBUTE5
,HzCustProfClassAmts.ATTRIBUTE6
,HzCustProfClassAmts.ATTRIBUTE7
,HzCustProfClassAmts.ATTRIBUTE8
,HzCustProfClassAmts.ATTRIBUTE9
,HzCustProfClassAmts.ATTRIBUTE10
,HzCustProfClassAmts.ATTRIBUTE11
,HzCustProfClassAmts.ATTRIBUTE12
,HzCustProfClassAmts.ATTRIBUTE13
,HzCustProfClassAmts.ATTRIBUTE14
,HzCustProfClassAmts.ATTRIBUTE15
,HzCustProfClassAmts.JGZZ_ATTRIBUTE1
,HzCustProfClassAmts.JGZZ_ATTRIBUTE2
,HzCustProfClassAmts.JGZZ_ATTRIBUTE3
,HzCustProfClassAmts.JGZZ_ATTRIBUTE4
,HzCustProfClassAmts.JGZZ_ATTRIBUTE5
,HzCustProfClassAmts.JGZZ_ATTRIBUTE6
,HzCustProfClassAmts.JGZZ_ATTRIBUTE7
,HzCustProfClassAmts.JGZZ_ATTRIBUTE8
,HzCustProfClassAmts.JGZZ_ATTRIBUTE9
,HzCustProfClassAmts.JGZZ_ATTRIBUTE10
,HzCustProfClassAmts.JGZZ_ATTRIBUTE11
,HzCustProfClassAmts.JGZZ_ATTRIBUTE12
,HzCustProfClassAmts.JGZZ_ATTRIBUTE13
,HzCustProfClassAmts.JGZZ_ATTRIBUTE14
,HzCustProfClassAmts.JGZZ_ATTRIBUTE15
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE1
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE2
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE3
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE4
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE5
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE6
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE7
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE8
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE9
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE10
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE11
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE12
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE13
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE14
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE15
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE16
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE17
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE18
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE19
,HzCustProfClassAmts.GLOBAL_ATTRIBUTE20
,HzCustProfClassAmts.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,HzCustProfClassAmts.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,HzCustProfClassAmts.CREATED_BY  RSC_CREATED_BY
,HzCustProfClassAmts.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 

FROM HZ_CUST_PROF_CLASS_AMTS HzCustProfClassAmts
,FND_CURRENCIES_VL CurrencyPEO
,HZ_CUST_PROFILE_CLASSES HzCustProfileClasses
where (HzCustProfClassAmts.ATTRIBUTE_CATEGORY IS NOT NULL OR
HzCustProfClassAmts.ATTRIBUTE1 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE2 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE3 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE4 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE5 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE6 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE7 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE8 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE9 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE10 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE11 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE12 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE13 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE14 IS NOT NULL OR 
HzCustProfClassAmts.ATTRIBUTE15 IS NOT NULL OR
HzCustProfClassAmts.JGZZ_ATTRIBUTE1 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE2 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE3 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE4 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE5 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE6 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE7 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE8 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE9 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE10 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE11 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE12 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE13 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE14 IS NOT NULL OR 
HzCustProfClassAmts.JGZZ_ATTRIBUTE15 IS NOT NULL OR
HzCustProfClassAmts.GLOBAL_ATTRIBUTE1 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE2 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE3 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE4 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE5 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE6 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE7 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE8 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE9 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE10 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE11 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE12 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE13 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE14 IS NOT NULL OR 
HzCustProfClassAmts.GLOBAL_ATTRIBUTE15 IS NOT NULL OR
HzCustProfClassAmts.GLOBAL_ATTRIBUTE16 IS NOT NULL OR
HzCustProfClassAmts.GLOBAL_ATTRIBUTE17 IS NOT NULL OR
HzCustProfClassAmts.GLOBAL_ATTRIBUTE18 IS NOT NULL OR
HzCustProfClassAmts.GLOBAL_ATTRIBUTE19 IS NOT NULL OR
HzCustProfClassAmts.GLOBAL_ATTRIBUTE20 IS NOT NULL 
) and HzCustProfClassAmts.CURRENCY_CODE  = CurrencyPEO.CURRENCY_CODE
AND HzCustProfClassAmts.PROFILE_CLASS_ID = HzCustProfileClasses.PROFILE_CLASS_ID
ORDER BY HzCustProfileClasses.NAME
 
/*SELECT HzCustProfileClasses.NAME AS RES_PROFILE_CLASS_NAME
,(HzCustProfClassAmts.CURRENCY_CODE|| ' - ' ||CurrencyPEO.NAME) AS RES_CURRENCY
, DFF.FIELD_NAME  RES_FIELD_NAME
, DFF.FIELD_VALUE  RES_FIELD_VALUE   
,NULL Mapper
,HzCustProfClassAmts.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,HzCustProfClassAmts.last_update_date AS RSC_LAST_UPDATE_DATE
FROM HZ_CUST_PROF_CLASS_AMTS HzCustProfClassAmts
,FND_CURRENCIES_VL CurrencyPEO
,HZ_CUST_PROFILE_CLASSES HzCustProfileClasses
,TABLE(FUSION_READONLY.##RES_PLSQL_PACKAGE_NAME##.GET_DFF(P_APPLICATION_ID => 222
														,P_DFF_CODE => 'AR_CUST_PROF_CLASS_AMOUNTS_HZ'
													    ,P_BASE_TABLE => 'HZ_CUST_PROF_CLASS_AMTS'
														,P_PK_COLUMN_1 => 'PROFILE_CLASS_AMOUNT_ID')) DFF
WHERE DFF.FIELD_VALUE is not null
and  to_char(HzCustProfClassAmts.PROFILE_CLASS_AMOUNT_ID) = DFF.COL_1
and HzCustProfClassAmts.CURRENCY_CODE  = CurrencyPEO.CURRENCY_CODE
AND HzCustProfClassAmts.PROFILE_CLASS_ID = HzCustProfileClasses.PROFILE_CLASS_ID
AND(HzCustProfClassAmts.last_updated_by ##LAST_UPDATED_BY_OPERATOR##(##USER_NAME_LIST##)
AND HzCustProfClassAmts.last_update_date ##LAST_UPDATE_DATE_OPERATOR## to_date('##SEEDED_DATE##'))
ORDER BY HzCustProfileClasses.NAME*/
