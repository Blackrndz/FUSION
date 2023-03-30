/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT CostOrgEO.COST_ORG_NAME RES_COST_ORGANIZATION
,CostBookPEO.COST_BOOK_CODE RES_COST_BOOK
,GlLedgers.NAME RES_LEDGER
,DECODE(CostOrgBookEO.PRIMARY_BOOK_FLAG,'Y','Yes','N','No') RES_PRIMARY_BOOK
,(SELECT USER_CONVERSION_TYPE
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = CostOrgBookEO.CONVERSION_TYPE
	) RES_CONVERSION_RATE_TYPE
,CostOrgBookEO.CURRENCY_CODE RES_CURRENCY
,GlCalendars.USER_PERIOD_SET_NAME RES_ACCOUNTING_CALENDAR
,TO_CHAR(CostOrgBookEO.FROM_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,CostOrgBookEO.FIRST_LEDGER_PERIOD_NAME RES_FIRST_OPENED_PERIOD
,CostOrgBookEO.OPEN_PERIODS_NUM RES_MAXIMUM_OPEN_PERIODS
,DECODE(CostOrgBookEO.CREATE_ACCOUNTING_FLAG,'Y','Yes','N','No') RES_CREATE_ACCOUNTING
,DECODE(Extract(YEAR FROM CostOrgBookEO.TO_DATE),'4712',NULL,TO_CHAR(CostOrgBookEO.TO_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,CostOrgBookEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CostOrgBookEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CostOrgBookEO.CREATED_BY RSC_CREATED_BY
,CostOrgBookEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CostOrgParametersEO.COST_ORG_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_ORG_PARAMETERS CostOrgParametersEO
,CST_COST_ORGS_V CostOrgEO
,CST_COST_ORG_BOOKS CostOrgBookEO
,CST_COST_BOOKS_VL CostBookPEO
,GL_LEDGERS GlLedgers
,GL_CALENDARS GlCalendars
WHERE CostOrgParametersEO.COST_ORG_ID       = CostOrgEO.COST_ORG_ID
AND SYSDATE BETWEEN CostOrgEO.EFFECTIVE_START_DATE AND CostOrgEO.EFFECTIVE_END_DATE
AND CostOrgParametersEO.COST_ORG_ID = CostOrgBookEO.COST_ORG_ID
AND((CostOrgBookEO.COST_BOOK_ID     = CostBookPEO.COST_BOOK_ID)
AND(CostOrgBookEO.LEDGER_ID         = GlLedgers.LEDGER_ID (+)))
AND(CostOrgBookEO.CALENDAR_ID       = GlCalendars.CALENDAR_ID)
ORDER BY CostOrgEO.COST_ORG_NAME
,CostBookPEO.COST_BOOK_CODE