/* ****************************************************************************
 * $Revision: 79172 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-08-09 15:27:23 +0700 (Tue, 09 Aug 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Mappings%20-%20Rollup%20Rules.sql $:
 * $Id: Manage Chart of Accounts Mappings - Rollup Rules.sql 79172 2022-08-09 08:27:23Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

 
select COAMAPPINGEO.name RES_NAME
,(
	(SELECT seg.NAME
	FROM FND_KF_SEGMENTS_VL seg
	,FND_KF_STR_INSTANCES_VL strInst
	WHERE seg.STRUCTURE_ID                 = strInst.STRUCTURE_ID
	AND seg.ENABLED_FLAG                   = 'Y'
	AND strInst.ENABLED_FLAG               = 'Y'
	AND strInst.APPLICATION_ID             = 101
	AND strInst.KEY_FLEXFIELD_CODE         = 'GL#'
	AND strInst.STRUCTURE_INSTANCE_NUMBER IN
		(SELECT TO_COA_ID
		FROM GL_COA_MAPPINGS
		WHERE COA_MAPPING_ID = CoaMapSegmentRuleEO.COA_MAPPING_ID
		)
	and SEG.COLUMN_NAME = COAMAPSEGMENTRULEEO.TO_SEG_COLUMN_NAME
	)) RES_TARGET_SEGMENT_NAME
,(
	(SELECT seg.SEGMENT_CODE
	FROM FND_KF_SEGMENTS_VL seg
	,FND_KF_STR_INSTANCES_VL strInst
	WHERE seg.STRUCTURE_ID                 = strInst.STRUCTURE_ID
	AND seg.ENABLED_FLAG                   = 'Y'
	AND strInst.ENABLED_FLAG               = 'Y'
	AND strInst.APPLICATION_ID             = 101
	AND strInst.KEY_FLEXFIELD_CODE         = 'GL#'
	AND strInst.STRUCTURE_INSTANCE_NUMBER IN
		(SELECT TO_COA_ID
		FROM GL_COA_MAPPINGS
		WHERE COA_MAPPING_ID = CoaMapSegmentRuleEO.COA_MAPPING_ID
		)
	and SEG.COLUMN_NAME = COAMAPSEGMENTRULEEO.TO_SEG_COLUMN_NAME
	)) RES_TARGET_SEGMENT_CODE
,COAMAPROLLUPRULEEO.TO_FLEX_VALUE RES_TARGET_VALUE
,(case when COAMAPROLLUPRULEEO.FROM_FLEX_VALUE_HIGH = COAMAPROLLUPRULEEO.FROM_FLEX_VALUE_LOW then
	'Equal to'
	   when COAMAPROLLUPRULEEO.FROM_FLEX_VALUE_HIGH != COAMAPROLLUPRULEEO.FROM_FLEX_VALUE_LOW then
	'Between'
	 else
	 'Is a Last Descendant of'
	 end ) RES_CONDITION
,COAMAPROLLUPRULEEO.FROM_FLEX_VALUE_LOW RES_FROM_VALUE 
,COAMAPROLLUPRULEEO.FROM_FLEX_VALUE_HIGH RES_TO_VALUE
,COAMAPROLLUPRULEEO.TREE_CODE RES_TREE_CODE
,(SELECT tv.tree_version_name
	FROM fnd_tree_version_vl tv
	WHERE tv.tree_structure_code = 'GL_ACCT_FLEX'
	AND tv.tree_code             = CoaMapRollupRuleEO.tree_code
	AND tv.tree_version_id       = CoaMapRollupRuleEO.tree_version_id
	)  RES_TREE_VERSION_NAME
	,node.tree_node RES_TREE_NODE
,COAMAPROLLUPRULEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,COAMAPROLLUPRULEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,COAMAPROLLUPRULEEO.CREATED_BY  RSC_CREATED_BY
,COAMAPROLLUPRULEEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, (SELECT DISTINCT LedgerE0.CHART_OF_ACCOUNTS_ID 
	FROM GL_LEDGER_RELATIONSHIPS GlRelation
	,GL_LEDGERS LedgerE0
	WHERE GlRelation.SL_COA_MAPPING_ID = CoaMappingEO.COA_MAPPING_ID
	AND GlRelation.PRIMARY_LEDGER_ID = LedgerE0.LEDGER_ID
	) RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
	
from GL_COA_MAP_SEGMENT_RULES COAMAPSEGMENTRULEEO
,GL_COA_MAPPINGS COAMAPPINGEO
,GL_COA_MAP_ROLLUP_RULES COAMAPROLLUPRULEEO
,FND_KF_STR_INSTANCES_VL KeyFlexfieldStructureInstanc1
,FND_KF_STR_INSTANCES_VL KeyFlexfieldStructureInstanc11
,	(SELECT DISTINCT DECODE(pk1_start_value,'GL_ACCT_FLEX',n.node_name,pk1_start_value) AS tree_node
	,DECODE(pk1_start_value,'GL_ACCT_FLEX',n.description,v.description)                 AS description
	,tree_code
	,tree_version_id
	FROM FND_TREE_NODE tn
	,FND_TS_DATA_SOURCE ds
	,FND_NODE_VL n
	, FND_VS_VALUES_VL v
	WHERE tn.tree_structure_code  = 'GL_ACCT_FLEX'
	AND tn.data_source_id         = ds.data_source_id
	AND ds.tree_structure_code    = tn.tree_structure_code
	AND ds.max_depth              = - 1
	AND n.tree_structure_code (+) = tn.tree_structure_code
	AND n.node_id (+)             = DECODE(pk1_start_value,'GL_ACCT_FLEX',pk2_start_value)	
	AND v.value(+)                = tn.pk1_start_value
	order by DECODE(PK1_START_VALUE,'GL_ACCT_FLEX',N.NODE_NAME,PK1_START_VALUE)
	) Node
where COAMAPPINGEO.COA_MAPPING_ID =  COAMAPSEGMENTRULEEO.COA_MAPPING_ID
and COAMAPSEGMENTRULEEO.SEGMENT_RULE_ID = COAMAPROLLUPRULEEO.SEGMENT_RULE_ID 
and COAMAPROLLUPRULEEO.TREE_CODE = Node.tree_code(+)
and (CoaMappingEO.TO_COA_ID                          = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER)
AND(CoaMappingEO.FROM_COA_ID                          = KeyFlexfieldStructureInstanc11.STRUCTURE_INSTANCE_NUMBER)
AND(KeyFlexfieldStructureInstanc1.APPLICATION_ID      = 101 AND KeyFlexfieldStructureInstanc1.KEY_FLEXFIELD_CODE  = 'GL#' AND KeyFlexfieldStructureInstanc1.ENABLED_FLAG        = 'Y')
AND(KeyFlexfieldStructureInstanc11.APPLICATION_ID     = 101 AND KeyFlexfieldStructureInstanc11.KEY_FLEXFIELD_CODE = 'GL#' AND KeyFlexfieldStructureInstanc11.ENABLED_FLAG       = 'Y')
order by CoaMappingEO.NAME,COAMAPROLLUPRULEEO.TO_FLEX_VALUE