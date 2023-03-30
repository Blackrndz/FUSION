 /* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Customer%20Profile%20Classes%20-%20Profile%20Class%20-%20DFF.sql $:
 * $Id: Manage Receivables Customer Profile Classes - Profile Class - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##AR_CUSTOMER_PROFILE_CLASSES_HZ
-- DFF_ATTRIBUTES=ATTRIBUTE,JGZZ_ATTRIBUTE,GLOBAL_ATTRIBUTE,GLOBAL_ATTRIBUTE_NUMBER,GLOBAL_ATTRIBUTE_DATE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select HzCustProfileClasses.NAME AS RES_PROFILE_CLASS_NAME
,HzCustProfileClasses.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,HzCustProfileClasses.ATTRIBUTE1
,HzCustProfileClasses.ATTRIBUTE2
,HzCustProfileClasses.ATTRIBUTE3
,HzCustProfileClasses.ATTRIBUTE4
,HzCustProfileClasses.ATTRIBUTE5
,HzCustProfileClasses.ATTRIBUTE6
,HzCustProfileClasses.ATTRIBUTE7
,HzCustProfileClasses.ATTRIBUTE8
,HzCustProfileClasses.ATTRIBUTE9
,HzCustProfileClasses.ATTRIBUTE10
,HzCustProfileClasses.ATTRIBUTE11
,HzCustProfileClasses.ATTRIBUTE12
,HzCustProfileClasses.ATTRIBUTE13
,HzCustProfileClasses.ATTRIBUTE14
,HzCustProfileClasses.ATTRIBUTE15
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
,HzCustProfileClasses.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,HzCustProfileClasses.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
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
where (HzCustProfileClasses.ATTRIBUTE_CATEGORY IS NOT NULL OR
HzCustProfileClasses.ATTRIBUTE1 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE2 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE3 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE4 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE5 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE6 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE7 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE8 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE9 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE10 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE11 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE12 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE13 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE14 IS NOT NULL OR 
HzCustProfileClasses.ATTRIBUTE15 IS NOT NULL OR
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
 
/*SELECT HzCustProfileClasses.NAME AS RES_PROFILE_CLASS_NAME
, DFF.FIELD_NAME  RES_FIELD_NAME
, DFF.FIELD_VALUE  RES_FIELD_VALUE   
,NULL Mapper
,HzCustProfileClasses.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,HzCustProfileClasses.last_update_date AS RSC_LAST_UPDATE_DATE
FROM HZ_CUST_PROFILE_CLASSES HzCustProfileClasses
,TABLE(FUSION_READONLY.##RES_PLSQL_PACKAGE_NAME##.GET_DFF(P_APPLICATION_ID => 222
														,P_DFF_CODE => 'AR_CUSTOMER_PROFILE_CLASSES_HZ'
													    ,P_BASE_TABLE => 'HZ_CUST_PROFILE_CLASSES'
														,P_PK_COLUMN_1 => 'PROFILE_CLASS_ID')) DFF

WHERE   DFF.FIELD_VALUE is not null
and  to_char(HzCustProfileClasses.PROFILE_CLASS_ID) = DFF.COL_1
AND (HzCustProfileClasses.last_updated_by ##LAST_UPDATED_BY_OPERATOR##(##USER_NAME_LIST##)
AND HzCustProfileClasses.last_update_date ##LAST_UPDATE_DATE_OPERATOR## to_date('##SEEDED_DATE##'))
ORDER BY HzCustProfileClasses.NAME*/