/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Ledger%20Sets%20-%20Manage%20Ledger%20Sets.sql $:
 * $Id: Manage Ledger Sets - Manage Ledger Sets.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

/*Note! This SQL can be duplicate due to the Ledger ID that required to filter in RapidExtract are come from child table.
If it occurred, please use Rapid configurator to clean the data.*/ 
 
 
SELECT distinct QRSLT.NAME RES_NAME
,QRSLT.DESCRIPTION RES_DESCRIPTION
,QRSLT.COA_NAME RES_CHART_OF_ACCOUNTS
,QRSLT.USER_PERIOD_SET_NAME RES_ACCOUNTING_CALENDAR
,QRSLT.DEFAULT_LEDGER_NAME RES_DEFAULT_LEDGER
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,QRSLT.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	( SELECT DISTINCT LedgerSetEO.NAME
	,LedgerSetEO.DESCRIPTION
	,(SELECT NAME
		FROM FND_KF_STR_INSTANCES_VL
		WHERE APPLICATION_ID          = 101
		AND KEY_FLEXFIELD_CODE        = 'GL#'
		AND STRUCTURE_INSTANCE_NUMBER = LedgerSetEO.CHART_OF_ACCOUNTS_ID
		) AS COA_NAME
	,GlCalendars.USER_PERIOD_SET_NAME
	,LedgerSetEO.PERIOD_SET_NAME
	,LedgerSetEO.ACCOUNTED_PERIOD_TYPE
	,LedgerSetEO.CHART_OF_ACCOUNTS_ID
	,GlAccessSets.ACCESS_SET_ID
	,GlAccessSets.DEFAULT_LEDGER_ID
	,GlCalendars.CALENDAR_ID
	,LedgerSetEO.LEDGER_ID
	,GlCalendars.PERIOD_SET_ID
	,GlCalendars.PERIOD_TYPE_ID
	,(SELECT NAME
		FROM GL_LEDGERS
		WHERE LEDGER_ID = GlAccesssets.DEFAULT_LEDGER_ID
		) AS DEFAULT_LEDGER_NAME
	,(SELECT cal.calendar_id
		FROM gl_calendars cal
		WHERE cal.period_set_name = LedgerSetEO.period_set_name
		AND cal.period_type       = LedgerSetEO.accounted_period_type
		) AS ACCTCALENDARID
	,LedgerSetEO.LAST_UPDATED_BY	
	,LedgerSetEO.LAST_UPDATE_DATE	
	,LedgerSetEO.CREATED_BY	
	,LedgerSetEO.CREATION_DATE
	,GLLEDGERSETNORMASSIGN.PRIMARY_LEDGER_ID
	FROM GL_LEDGERS LedgerSetEO
	,GL_ACCESS_SETS GlAccessSets
	,GL_CALENDARS GLCALENDARS
	,(SELECT GLLEDGERSETNORMASSIGN.LEDGER_SET_ID
		,PGL.PRIMARY_LEDGER_ID
		FROM GL_LEDGER_SET_NORM_ASSIGN GLLEDGERSETNORMASSIGN
		,(SELECT RSHIP.TARGET_LEDGER_ID, RSHIP.PRIMARY_LEDGER_ID from GL_LEDGER_RELATIONSHIPS RSHIP
			WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
			AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
			OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
			AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
			WHERE GlLedgerSetNormAssign.LEDGER_ID = PGL.TARGET_LEDGER_ID
			) GLLEDGERSETNORMASSIGN
	WHERE((LedgerSetEO.IMPLICIT_ACCESS_SET_ID = GlAccessSets.ACCESS_SET_ID)
	AND((LedgerSetEO.PERIOD_SET_NAME          = GlCalendars.PERIOD_SET_NAME)
	AND(LedgerSetEO.ACCOUNTED_PERIOD_TYPE     = GlCalendars.PERIOD_TYPE)))
	AND(LEDGERSETEO.OBJECT_TYPE_CODE          = 'S')
	AND LEDGERSETEO.LEDGER_ID                 = GLLEDGERSETNORMASSIGN.LEDGER_SET_ID(+)
	) QRSLT
order by QRSLT.NAME