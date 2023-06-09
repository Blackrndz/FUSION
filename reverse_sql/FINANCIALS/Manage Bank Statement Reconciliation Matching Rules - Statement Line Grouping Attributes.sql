/* ****************************************************************************
* $Revision: 58428 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Bank%20Statement%20Reconciliation%20Matching%20Rules%20-%20Manage%20Bank%20Statement%20Reconciliation%20Matchin $:
* $Id: Manage Bank Statement Reconciliation Matching Rules - Manage Bank Statement Reconciliation Matching Rules.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CE_RECON_MATCHING_RULES

SELECT MATCHING_RULE_NAME AS RES_NAME
,NVL( 
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%BANK_TRANSACTION_CODE%'
	),'No') AS RES_STATEMENT_LINE_GROUPING_AT
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%TRX_CODE_ID%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__0
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%VALUE_DATE_STRING%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__1
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%VALUE_DATE%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__2
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%STRUCTURED_PAYMENT_REFERENCE%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__3
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%TRX_TYPE%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__4
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%RECON_REFERENCE%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__5
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%ORIG_BANK_ACCOUNT_ID%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__6
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%MESSAGE_IDENTIFIER%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__7
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%CURRENCY_CODE%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__8
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%BOOKING_DATE%'
	),'No') AS RES_STATEMENT_LINE_GROUPING__9
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%PAYMENT_INFO_IDENTIFIER%'
	),'No') AS RES_STATEMENT_LINE_GROUPING_10

,CRMR.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CRMR.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CRMR.CREATED_BY RSC_CREATED_BY
,CRMR.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_RECON_MATCHING_RULES CRMR
ORDER BY RES_NAME