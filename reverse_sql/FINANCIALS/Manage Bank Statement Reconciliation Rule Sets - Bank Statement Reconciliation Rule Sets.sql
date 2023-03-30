/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Bank%20Statement%20Reconciliation%20Rule%20Sets%20-%20Manage%20Bank%20Statement%20Reconciliation%20Rule%20Sets. $:
 * $Id: Manage Bank Statement Reconciliation Rule Sets - Manage Bank Statement Reconciliation Rule Sets.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT CeReconRulesets.RULESET_NAME RES_NAME
,CeReconRulesets.DESCRIPTION RES_DESCRIPTION
,CeReconRulesets.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,CeReconRulesets.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CeReconRulesets.CREATED_BY  RSC_CREATED_BY
,CeReconRulesets.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_RECON_RULESETS CeReconRulesets
ORDER BY CeReconRulesets.RULESET_NAME