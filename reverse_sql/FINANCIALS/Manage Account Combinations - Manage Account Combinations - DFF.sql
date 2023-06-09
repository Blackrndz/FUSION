/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Account%20Combinations%20-%20Manage%20Account%20Combinations%20-%20DFF.sql $:
 * $Id: Manage Account Combinations - Manage Account Combinations - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_CODE_COMBINATIONS
-- DFF_ATTRIBUTES=ATTRIBUTE,SEGMENT_ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields. 

select (select name 
        from FND_KF_STR_INSTANCES_VL 
		where STRUCTURE_INSTANCE_NUMBER = CodeCombinationEO.CHART_OF_ACCOUNTS_ID) RES_CHART_OF_ACCOUNTS
,CodeCombinationEO.SEGMENT1 RES_ACCOUNT_NAME1
,CodeCombinationEO.SEGMENT2 RES_ACCOUNT_NAME2
,CodeCombinationEO.SEGMENT3 RES_ACCOUNT_NAME3
,CodeCombinationEO.SEGMENT4 RES_ACCOUNT_NAME4
,CodeCombinationEO.SEGMENT5 RES_ACCOUNT_NAME5
,CodeCombinationEO.SEGMENT6 RES_ACCOUNT_NAME6
,CodeCombinationEO.SEGMENT7 RES_ACCOUNT_NAME7
,CodeCombinationEO.SEGMENT8 RES_ACCOUNT_NAME8
,CodeCombinationEO.SEGMENT9 RES_ACCOUNT_NAME9
,CodeCombinationEO.SEGMENT10 RES_ACCOUNT_NAME10
,CodeCombinationEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,CodeCombinationEO.ATTRIBUTE1
,CodeCombinationEO.ATTRIBUTE2
,CodeCombinationEO.ATTRIBUTE3
,CodeCombinationEO.ATTRIBUTE4
,CodeCombinationEO.ATTRIBUTE5
,CodeCombinationEO.ATTRIBUTE6
,CodeCombinationEO.ATTRIBUTE7
,CodeCombinationEO.ATTRIBUTE8
,CodeCombinationEO.ATTRIBUTE9
,CodeCombinationEO.ATTRIBUTE10
,CodeCombinationEO.SEGMENT_ATTRIBUTE1
,CodeCombinationEO.SEGMENT_ATTRIBUTE2
,CodeCombinationEO.SEGMENT_ATTRIBUTE3
,CodeCombinationEO.SEGMENT_ATTRIBUTE4
,CodeCombinationEO.SEGMENT_ATTRIBUTE5
,CodeCombinationEO.SEGMENT_ATTRIBUTE6
,CodeCombinationEO.SEGMENT_ATTRIBUTE7
,CodeCombinationEO.SEGMENT_ATTRIBUTE8
,CodeCombinationEO.SEGMENT_ATTRIBUTE9
,CodeCombinationEO.SEGMENT_ATTRIBUTE10
,CodeCombinationEO.SEGMENT_ATTRIBUTE11
,CodeCombinationEO.SEGMENT_ATTRIBUTE12
,CodeCombinationEO.SEGMENT_ATTRIBUTE13
,CodeCombinationEO.SEGMENT_ATTRIBUTE14
,CodeCombinationEO.SEGMENT_ATTRIBUTE15
,CodeCombinationEO.SEGMENT_ATTRIBUTE16
,CodeCombinationEO.SEGMENT_ATTRIBUTE17
,CodeCombinationEO.SEGMENT_ATTRIBUTE18
,CodeCombinationEO.SEGMENT_ATTRIBUTE19
,CodeCombinationEO.SEGMENT_ATTRIBUTE20
,CodeCombinationEO.SEGMENT_ATTRIBUTE21
,CodeCombinationEO.SEGMENT_ATTRIBUTE22
,CodeCombinationEO.SEGMENT_ATTRIBUTE23
,CodeCombinationEO.SEGMENT_ATTRIBUTE24
,CodeCombinationEO.SEGMENT_ATTRIBUTE25
,CodeCombinationEO.SEGMENT_ATTRIBUTE26
,CodeCombinationEO.SEGMENT_ATTRIBUTE27
,CodeCombinationEO.SEGMENT_ATTRIBUTE28
,CodeCombinationEO.SEGMENT_ATTRIBUTE29
,CodeCombinationEO.SEGMENT_ATTRIBUTE30
,CodeCombinationEO.SEGMENT_ATTRIBUTE31
,CodeCombinationEO.SEGMENT_ATTRIBUTE32
,CodeCombinationEO.SEGMENT_ATTRIBUTE33
,CodeCombinationEO.SEGMENT_ATTRIBUTE34
,CodeCombinationEO.SEGMENT_ATTRIBUTE35
,CodeCombinationEO.SEGMENT_ATTRIBUTE36
,CodeCombinationEO.SEGMENT_ATTRIBUTE37
,CodeCombinationEO.SEGMENT_ATTRIBUTE38
,CodeCombinationEO.SEGMENT_ATTRIBUTE39
,CodeCombinationEO.SEGMENT_ATTRIBUTE40
,CodeCombinationEO.SEGMENT_ATTRIBUTE41
,CodeCombinationEO.SEGMENT_ATTRIBUTE42
,CodeCombinationEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CodeCombinationEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CodeCombinationEO.CREATED_BY  RSC_CREATED_BY
,CodeCombinationEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM GL_CODE_COMBINATIONS CodeCombinationEO
where (CodeCombinationEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
CodeCombinationEO.ATTRIBUTE1 IS NOT NULL OR 
CodeCombinationEO.ATTRIBUTE2 IS NOT NULL OR 
CodeCombinationEO.ATTRIBUTE3 IS NOT NULL OR 
CodeCombinationEO.ATTRIBUTE4 IS NOT NULL OR 
CodeCombinationEO.ATTRIBUTE5 IS NOT NULL OR 
CodeCombinationEO.ATTRIBUTE6 IS NOT NULL OR 
CodeCombinationEO.ATTRIBUTE7 IS NOT NULL OR 
CodeCombinationEO.ATTRIBUTE8 IS NOT NULL OR 
CodeCombinationEO.ATTRIBUTE9 IS NOT NULL OR 
CodeCombinationEO.ATTRIBUTE10 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE1 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE2 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE3 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE4 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE5 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE6 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE7 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE8 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE9 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE10 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE11 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE12 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE13 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE14 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE15 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE16 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE17 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE18 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE19 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE20 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE21 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE22 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE23 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE24 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE25 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE26 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE27 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE28 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE29 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE30 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE31 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE32 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE33 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE34 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE35 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE36 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE37 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE38 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE39 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE40 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE41 IS NOT NULL OR 
CodeCombinationEO.SEGMENT_ATTRIBUTE42 IS NOT NULL 
)
ORDER BY RES_CHART_OF_ACCOUNTS