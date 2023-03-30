/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Ledger%20Sets%20-%20Ledger%20Set%20Assignments.sql $:
 * $Id: Manage Ledger Sets - Ledger Set Assignments.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT QRSLT.LEGDER_SET RES_NAME
,QRSLT.NAME RES_LEDGER_OR_LEDGER_SET
,QRSLT.TYPE RES_TYPE
,QRSLT.DESCRIPTION RES_DESCRIPTION
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT LedgerSetEO.name legder_set
	, GlLedgerSetNormAssign.LEDGER_SET_ID
	, GlLedgerSetNormAssign.LEDGER_ID
	, LedgerSetEO.CHART_OF_ACCOUNTS_ID
	,(SELECT name
		FROM gl_ledgers
		WHERE ledger_id = GlLedgerSetNormAssign.LEDGER_ID
		) AS Name
	,(SELECT description
		FROM gl_ledgers
		WHERE ledger_id = GlLedgerSetNormAssign.LEDGER_ID
		) AS DESCRIPTION
	,(SELECT Meaning
		FROM gl_lookups lks
		,gl_ledgers ld
		WHERE ledger_id         = GlLedgerSetNormAssign.LEDGER_ID
		AND ld.object_type_code = lks.lookup_code
		AND lookup_type         = 'LEDGERS'
		) AS TYPE
	,(SELECT ld.object_type_code
		FROM gl_ledgers ld
		WHERE ld.ledger_id = GlLedgerSetNormAssign.LEDGER_ID
		) AS LOOKUPCODE
	,GLLEDGERSETNORMASSIGN.LAST_UPDATED_BY	
	,GLLEDGERSETNORMASSIGN.LAST_UPDATE_DATE	
	,GLLEDGERSETNORMASSIGN.CREATED_BY
	,GLLEDGERSETNORMASSIGN.CREATION_DATE
	FROM GL_LEDGERS LedgerSetEO
	, GL_LEDGER_SET_NORM_ASSIGN GLLEDGERSETNORMASSIGN
	WHERE LEDGERSETEO.LEDGER_ID            = GLLEDGERSETNORMASSIGN.LEDGER_SET_ID
	AND(GLLEDGERSETNORMASSIGN.STATUS_CODE IS NULL
	OR GLLEDGERSETNORMASSIGN.STATUS_CODE  != 'D')
	) QRSLT
,(select RSHIP.TARGET_LEDGER_ID, RSHIP.PRIMARY_LEDGER_ID from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'JOURNAL'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'ALC')) PGL
WHERE QRSLT.LEDGER_ID = PGL.TARGET_LEDGER_ID(+)
ORDER BY Name