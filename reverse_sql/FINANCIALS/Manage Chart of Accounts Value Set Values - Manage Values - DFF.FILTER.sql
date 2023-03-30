/* ****************************************************************************
 * $Revision: 53756 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-22 15:41:28 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 53756 2016-03-22 08:41:28Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=0##RES##FND_VS_VALUES_B
-- DFF_ATTRIBUTES=ATTRIBUTE,FLEX_VALUE_ATTRIBUTE,CUSTOM_VALUE_ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
select ValueSetEO.VALUE_SET_CODE RES_VALUE_SET_CODE
,ValueDeatilPE0.VALUE RES_VALUE
,ValueDeatilPE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,ValueDeatilPE0.ATTRIBUTE1
,ValueDeatilPE0.ATTRIBUTE2
,ValueDeatilPE0.ATTRIBUTE3
,ValueDeatilPE0.ATTRIBUTE4
,ValueDeatilPE0.ATTRIBUTE5
,ValueDeatilPE0.ATTRIBUTE6
,ValueDeatilPE0.ATTRIBUTE7
,ValueDeatilPE0.ATTRIBUTE8
,ValueDeatilPE0.ATTRIBUTE9
,ValueDeatilPE0.ATTRIBUTE10
,ValueDeatilPE0.ATTRIBUTE11
,ValueDeatilPE0.ATTRIBUTE12
,ValueDeatilPE0.ATTRIBUTE13
,ValueDeatilPE0.ATTRIBUTE14
,ValueDeatilPE0.ATTRIBUTE15
,ValueDeatilPE0.ATTRIBUTE16
,ValueDeatilPE0.ATTRIBUTE17
,ValueDeatilPE0.ATTRIBUTE18
,ValueDeatilPE0.ATTRIBUTE19
,ValueDeatilPE0.ATTRIBUTE20
,ValueDeatilPE0.ATTRIBUTE21
,ValueDeatilPE0.ATTRIBUTE22
,ValueDeatilPE0.ATTRIBUTE23
,ValueDeatilPE0.ATTRIBUTE24
,ValueDeatilPE0.ATTRIBUTE25
,ValueDeatilPE0.ATTRIBUTE26
,ValueDeatilPE0.ATTRIBUTE27
,ValueDeatilPE0.ATTRIBUTE28
,ValueDeatilPE0.ATTRIBUTE29
,ValueDeatilPE0.ATTRIBUTE30
,ValueDeatilPE0.ATTRIBUTE31
,ValueDeatilPE0.ATTRIBUTE32
,ValueDeatilPE0.ATTRIBUTE33
,ValueDeatilPE0.ATTRIBUTE34
,ValueDeatilPE0.ATTRIBUTE35
,ValueDeatilPE0.ATTRIBUTE36
,ValueDeatilPE0.ATTRIBUTE37
,ValueDeatilPE0.ATTRIBUTE38
,ValueDeatilPE0.ATTRIBUTE39
,ValueDeatilPE0.ATTRIBUTE40
,ValueDeatilPE0.ATTRIBUTE41
,ValueDeatilPE0.ATTRIBUTE42
,ValueDeatilPE0.ATTRIBUTE43
,ValueDeatilPE0.ATTRIBUTE44
,ValueDeatilPE0.ATTRIBUTE45
,ValueDeatilPE0.ATTRIBUTE46
,ValueDeatilPE0.ATTRIBUTE47
,ValueDeatilPE0.ATTRIBUTE48
,ValueDeatilPE0.ATTRIBUTE49
,ValueDeatilPE0.ATTRIBUTE50
,ValueDeatilPE0.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,ValueDeatilPE0.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,ValueDeatilPE0.CREATED_BY  RSC_CREATED_BY
,ValueDeatilPE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,COA.STRUCTURE_INSTANCE_NUMBER RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM FND_VS_VALUE_SETS ValueSetEO, 
    FND_APPL_TAXONOMY_VL ApplTaxonomyPEO, 
    FND_VS_VALUES_VL ValueDeatilPE0
,(SELECT StructureInstance.STRUCTURE_INSTANCE_NUMBER
	,KeyFlexfieldSegmentInstanceE1.VALUE_SET_ID
	FROM FND_KF_SEGMENT_INSTANCES KeyFlexfieldSegmentInstanceE1
	,FND_KF_STR_INSTANCES_VL StructureInstance
	WHERE KeyFlexfieldSegmentInstanceE1.STRUCTURE_INSTANCE_ID = StructureInstance.STRUCTURE_INSTANCE_ID
	) COA
where (ValueDeatilPE0.ATTRIBUTE1 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE2 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE3 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE4 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE5 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE6 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE7 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE8 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE9 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE10 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE11 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE12 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE13 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE14 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE15 IS NOT NULL OR
ValueDeatilPE0.ATTRIBUTE16 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE17 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE18 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE19 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE20 IS NOT NULL OR
ValueDeatilPE0.ATTRIBUTE21 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE22 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE23 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE24 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE25 IS NOT NULL OR
ValueDeatilPE0.ATTRIBUTE26 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE27 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE28 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE29 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE30 IS NOT NULL OR
ValueDeatilPE0.ATTRIBUTE31 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE32 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE33 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE34 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE35 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE36 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE37 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE38 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE39 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE40 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE41 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE42 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE43 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE44 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE45 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE46 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE47 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE48 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE49 IS NOT NULL OR 
ValueDeatilPE0.ATTRIBUTE50 IS NOT NULL 
)
 AND ValueSetEO.MODULE_ID = ApplTaxonomyPEO.MODULE_ID 
    AND (ValueSetEO.module_id in (select rf.child_module_id
                                  from FUSION.fnd_appl_taxonomy_rf rf
                                  inner join FUSION.fnd_appl_taxonomy t
                                  on rf.ancestor_module_id = t.module_id
                                  where t.module_type = 'APPLICATION' and t.module_key = 'GL'
                                  )) 
    And ValueSetEO.VALUE_SET_ID = ValueDeatilPE0.VALUE_SET_ID
AND COA.VALUE_SET_ID(+) = ValueSetEO.VALUE_SET_ID
ORDER BY RES_VALUE_SET_CODE
,RES_VALUE