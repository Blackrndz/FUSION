 /* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Customer%20Profile%20Classes%20-%20Profile%20Class%20-%20GDF.sql $:
 * $Id: Manage Receivables Customer Profile Classes - Profile Class - GDF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=7003##RES##JG_HZ_CUSTOMER_PROFILES
-- DFF_ATTRIBUTES=ATTRIBUTE,JGZZ_ATTRIBUTE,GLOBAL_ATTRIBUTE,GLOBAL_ATTRIBUTE_NUMBER,GLOBAL_ATTRIBUTE_DATE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select HzCustProfileClasses.NAME AS RES_PROFILE_CLASS_NAME
,HzCustProfileClasses.GLOBAL_ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,HzCustProfileClasses.JGZZ_ATTRIBUTE1
,HzCustProfileClasses.JGZZ_ATTRIBUTE2
,HzCustProfileClasses.JGZZ_ATTRIBUTE3
,HzCustProfileClasses.JGZZ_ATTRIBUTE4
,HzCustProfileClasses.JGZZ_ATTRIBUTE5
,HzCustProfileClasses.JGZZ_ATTRIBUTE6
,HzCustProfileClasses.JGZZ_ATTRIBUTE7
,HzCustProfileClasses.JGZZ_ATTRIBUTE8
,HzCustProfileClasses.JGZZ_ATTRIBUTE9
,HzCustProfileClasses.JGZZ_ATTRIBUTE10
,HzCustProfileClasses.JGZZ_ATTRIBUTE11
,HzCustProfileClasses.JGZZ_ATTRIBUTE12
,HzCustProfileClasses.JGZZ_ATTRIBUTE13
,HzCustProfileClasses.JGZZ_ATTRIBUTE14
,HzCustProfileClasses.JGZZ_ATTRIBUTE15
,HzCustProfileClasses.GLOBAL_ATTRIBUTE1
,HzCustProfileClasses.GLOBAL_ATTRIBUTE2
,HzCustProfileClasses.GLOBAL_ATTRIBUTE3
,HzCustProfileClasses.GLOBAL_ATTRIBUTE4
,HzCustProfileClasses.GLOBAL_ATTRIBUTE5
,HzCustProfileClasses.GLOBAL_ATTRIBUTE6
,HzCustProfileClasses.GLOBAL_ATTRIBUTE7
,HzCustProfileClasses.GLOBAL_ATTRIBUTE8
,HzCustProfileClasses.GLOBAL_ATTRIBUTE9
,HzCustProfileClasses.GLOBAL_ATTRIBUTE10
,HzCustProfileClasses.GLOBAL_ATTRIBUTE11
,HzCustProfileClasses.GLOBAL_ATTRIBUTE12
,HzCustProfileClasses.GLOBAL_ATTRIBUTE13
,HzCustProfileClasses.GLOBAL_ATTRIBUTE14
,HzCustProfileClasses.GLOBAL_ATTRIBUTE15
,HzCustProfileClasses.GLOBAL_ATTRIBUTE16
,HzCustProfileClasses.GLOBAL_ATTRIBUTE17
,HzCustProfileClasses.GLOBAL_ATTRIBUTE18
,HzCustProfileClasses.GLOBAL_ATTRIBUTE19
,HzCustProfileClasses.GLOBAL_ATTRIBUTE20
,HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER1
,HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER2
,HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER3
,HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER4
,HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER5
, TO_CHAR(HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE1, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE1
, TO_CHAR(HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE2, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE2
, TO_CHAR(HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE3, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE3
, TO_CHAR(HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE4, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE4
, TO_CHAR(HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE5, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE5
,HzCustProfileClasses.LAST_UPDATED_BY   RSC_LAST_UPDATED_BY
,HzCustProfileClasses.LAST_UPDATE_DATE   RSC_LAST_UPDATE_DATE
,HzCustProfileClasses.CREATED_BY  RSC_CREATED_BY
,HzCustProfileClasses.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM HZ_CUST_PROFILE_CLASSES HzCustProfileClasses
where (HzCustProfileClasses.GLOBAL_ATTRIBUTE_CATEGORY IS NOT NULL OR
HzCustProfileClasses.JGZZ_ATTRIBUTE1 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE2 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE3 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE4 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE5 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE6 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE7 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE8 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE9 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE10 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE11 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE12 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE13 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE14 IS NOT NULL OR 
HzCustProfileClasses.JGZZ_ATTRIBUTE15 IS NOT NULL OR
HzCustProfileClasses.GLOBAL_ATTRIBUTE1 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE2 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE3 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE4 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE5 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE6 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE7 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE8 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE9 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE10 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE11 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE12 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE13 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE14 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE15 IS NOT NULL OR
HzCustProfileClasses.GLOBAL_ATTRIBUTE16 IS NOT NULL OR
HzCustProfileClasses.GLOBAL_ATTRIBUTE17 IS NOT NULL OR
HzCustProfileClasses.GLOBAL_ATTRIBUTE18 IS NOT NULL OR
HzCustProfileClasses.GLOBAL_ATTRIBUTE19 IS NOT NULL OR
HzCustProfileClasses.GLOBAL_ATTRIBUTE20 IS NOT NULL OR
HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER1 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER2 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER3 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER4 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE_NUMBER5 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE1 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE2 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE3 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE4 IS NOT NULL OR 
HzCustProfileClasses.GLOBAL_ATTRIBUTE_DATE5 IS NOT NULL 
)
ORDER BY HzCustProfileClasses.NAME