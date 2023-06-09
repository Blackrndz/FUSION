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
	AND TRX_GROUPBY LIKE '%JOURNAL_LINE_DESCRIPTION%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUPIN
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%PAYMENT_FILE_REFERENCE%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_0
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%PAYMENT_PROCESS_REQUEST_NAME%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_1
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%PAYMENT_INSTRUCTION_ID%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_2
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%LOGICAL_GROUP_REFERENCE%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_3
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%STRUCTURED_PAYMENT_REFERENCE%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_4
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%PAYMENT_SERVER_ORDER_NUMBER%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_5
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%UNIQUE_REMITTANCE_IDENTIFIER%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_6
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%RECEIPT_CLASS_NAME%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_7
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%RECON_MATCH_DATE%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_8
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%RECON_MATCH_REFERENCE%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROUP_9
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%RECON_MATCH_TYPE%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_10
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%TRANSACTION_SOURCE%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_11
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%TRX_CURRENCY_CODE%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_12
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND TRX_GROUPBY LIKE '%TRX_DATE%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_13
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%RECEIPT_BATCH_NAME%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_14
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%PAY_RECEIPT_METHOD%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_15
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%ORA_GL_JOURNAL%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_16
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%ORA_GL_BATCH%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_17
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%CPARTY_NAME%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_18
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%CPARTY_BANK_ACCOUNT_ID%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_19
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%BUSINESS_UNIT_ID%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_20
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%BANK_DEPOSIT_NUMBER%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_21
,NVL(
	(SELECT 'Yes'
	FROM CE_RECON_MATCHING_RULES
	WHERE RECON_MATCHING_RULE_ID = CRMR.RECON_MATCHING_RULE_ID
	AND STMT_GROUPBY LIKE '%BATCH_NAME%'
	),'No') AS RES_SYSTEM_TRANSACTION_GROU_22
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