/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Bank%20Statement%20Reconciliation%20Rule%20Sets%20-%20Reconciliation%20Rules.sql $:
 * $Id: Manage Bank Statement Reconciliation Rule Sets - Reconciliation Rules.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
 SELECT CERECONRULESETS.RULESET_NAME RES_NAME
,BANKSTMTRECONRULESETITEMEO.MATCHING_RULE_ORDER RES_SEQUENCE
,BANKSTATEMENTRECONMATCHINGRU1.MATCHING_RULE_NAME  RES_MATCHING_RULE
,CELOOKUPPEO.MEANING RES_MATCHING_TYPE
,BANKSTMTRECONTOLERANCERULEEO.TOLERANCE_RULE_NAME  RES_TOLERANCE_RULE
,BankStmtReconRulesetItemEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,BankStmtReconRulesetItemEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,BankStmtReconRulesetItemEO.CREATED_BY  RSC_CREATED_BY
,BankStmtReconRulesetItemEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_RECON_RULESETS CeReconRulesets
,CE_RECON_RULESET_ITEMS BankStmtReconRulesetItemEO
,CE_RECON_TOLERANCE_RULES BankStmtReconToleranceRuleEO
,CE_RECON_MATCHING_RULES BankStatementReconMatchingRu1
,CE_LOOKUPS CELOOKUPPEO
WHERE CeReconRulesets.RECON_RULESET_ID  = BankStmtReconRulesetItemEO.RECON_RULESET_ID 
and BankStmtReconRulesetItemEO.RECON_TOLERANCE_RULE_ID = BankStmtReconToleranceRuleEO.RECON_TOLERANCE_RULE_ID(+)
AND BankStmtReconRulesetItemEO.RECON_MATCHING_RULE_ID    = BankStatementReconMatchingRu1.RECON_MATCHING_RULE_ID
AND BankStatementReconMatchingRu1.MATCH_TYPE             = CeLookupPEO.LOOKUP_CODE
AND CELOOKUPPEO.LOOKUP_TYPE                              = 'CE_RECON_MATCH_TYPE'
ORDER BY CERECONRULESETS.RULESET_NAME,BankStmtReconRulesetItemEO.MATCHING_RULE_ORDER ASC