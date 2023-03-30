/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20Order%20By.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - Order By.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT
	(SELECT name
	FROM RA_LINE_ORDERING_RULES
	WHERE ORDERING_RULE_ID = RaLineOrderBys.ORDERING_RULE_ID
	)                                AS RES_NAME
,RaLineOrderBys.ORDER_BY_SEQUENCE AS RES_SEQUENCE
,(SELECT COLUMN_NAME
	FROM RA_LINE_ORDER_BY_COLUMNS
	WHERE COLUMN_ID = RaLineOrderBys.COLUMN_ID
	) AS RES_TRANSACTION_ATTRIBUTE
,(SELECT MEANING
	FROM AR_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORDER_BY_TYPE'
	AND lookup_code   = RaLineOrderBys.ORDER_BY_TYPE
	) AS RES_TYPE
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM RA_LINE_ORDER_BYS RaLineOrderBys
ORDER BY RES_NAME