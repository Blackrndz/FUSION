/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Data%20Access%20Sets%20-%20Access%20Set%20Assignments.sql $:
 * $Id: Manage Data Access Sets - Access Set Assignments.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT GlAccessSets.name AS RES_NAME
,(SELECT name
	FROM GL_LEDGERS
	WHERE LEDGER_ID = GlAccessSetNormAssign.LEDGER_ID
	) AS RES_LEDGER_OR_LEDGER_SET
,(SELECT meaning
	FROM gl_lookups
	WHERE lookup_type = 'LEDGERS'
	AND lookup_code   =
		(SELECT OBJECT_TYPE_CODE
		FROM GL_LEDGERS
		WHERE LEDGER_ID = GlAccessSetNormAssign.LEDGER_ID
		)
	) AS RES_TYPE
,NVL((SELECT MEANING
	FROM gl_lookups
	WHERE lookup_type = 'YES/NO'
	AND lookup_code   = GlAccessSetNormAssign.ALL_SEGMENT_VALUE_FLAG
	) ,'No')                                            AS RES_ALL_VALUES
,(CASE
	WHEN GlAccessSetNormAssign.ALL_SEGMENT_VALUE_FLAG = 'N' AND GlAccessSetNormAssign.TREE_CODE IS NOT NULL THEN
		'Parent Value'
	WHEN GlAccessSetNormAssign.ALL_SEGMENT_VALUE_FLAG = 'N' AND GlAccessSetNormAssign.TREE_CODE IS NULL THEN
		'Single Value'
	END) AS RES_SPECIFIC_VALUE
,GlAccessSetNormAssign.TREE_CODE                AS RES_TREE_CODE
,(SELECT tv.tree_version_name
	FROM fnd_tree_version_vl tv
	WHERE tv.tree_structure_code = 'GL_ACCT_FLEX'
	AND tv.tree_code             = GlAccessSetNormAssign.tree_code
	AND tv.tree_version_id       = GlAccessSetNormAssign.tree_version_id
	)                                   AS RES_TREE_VERSION_NAME
,GlAccessSetNormAssign.SEGMENT_VALUE AS RES_SEGMENT_VALUE
,(SELECT meaning
	FROM gl_lookups
	WHERE LOOKUP_TYPE = 'GL_DAS_ACCESS_PRIV_CODE'
	AND lookup_code   = GlAccessSetNormAssign.ACCESS_PRIVILEGE_CODE
	) AS RES_PRIVILEGE
,GlAccessSetNormAssign.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,GlAccessSetNormAssign.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,GlAccessSetNormAssign.CREATED_BY  RSC_CREATED_BY
,GlAccessSetNormAssign.CREATION_DATE  RSC_CREATION_DATE
,GlAccessSets.DEFAULT_LEDGER_ID RSC_LEDGER_ID
,GlAccessSets.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_ACCESS_SET_NORM_ASSIGN GlAccessSetNormAssign
,GL_ACCESS_SETS GlAccessSets
WHERE GlAccessSetNormAssign.ACCESS_SET_ID = GlAccessSets.ACCESS_SET_ID
and GLACCESSSETS.AUTOMATICALLY_CREATED_FLAG = 'N'
ORDER BY GlAccessSets.name