/* ****************************************************************************
* $Revision: 59117 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-21 11:10:58 +0700 (Fri, 21 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Segment%20Labels.sql $:
* $Id: Manage Key Flexfields - Segment Labels.sql 59117 2016-10-21 04:10:58Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=FOS_EVENT_DEFINITIONS_TL
-- RSC_PREREQUISITE_OBJECTS=FOS_AGREEMENT_DEFINITION_VL
-- RSC_PREREQUISITE_OBJECTS=FOS_QUALIFIER_RULE_SET

SELECT FosAgreementDefinitionE0.AGREEMENT_NUMBER RES_NAME
,FosAgreementDefinitionE0.DESCRIPTION RES_DESCRIPTION
,(SELECT EVENT_TYPE_NAME
	FROM FOS_EVENT_DEFINITIONS_TL
	WHERE EVENT_DEFINITION_ID = FosAgreementDefinitionE0.DS_FWD_OWNS_CHANGE_EVENT_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_SUPPLIER_OWNERSHIP_CHANGE_
,FosAgreementDefinitionE0.PRIORITY RES_PRIORITY
,TO_CHAR(FosAgreementDefinitionE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(FosAgreementDefinitionE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(FosAgreementDefinitionE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'FOS_AGREEMENT_STATUS'
	AND LOOKUP_CODE = FosAgreementDefinitionE0.STATUS
	) RES_STATUS
,FosQualifierRuleSet.QUALIFIER_RULE_SET_NAME RES_FINANCIAL_ORCHESTRATION_QU
,FosQualifierRuleSet.DESCRIPTION RES_FINANCIAL_ORCHESTRATION__0
,'' RES_RULE_TEXT_PREVIEW
,FosAgreementDefinitionE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,FosAgreementDefinitionE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,FosAgreementDefinitionE0.CREATED_BY RSC_CREATED_BY
,FosAgreementDefinitionE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FOS_AGREEMENT_DEFINITION_VL FosAgreementDefinitionE0
,FOS_QUALIFIER_RULE_SET FosQualifierRuleSet
WHERE FosAgreementDefinitionE0.AGREEMENT_TYPE = 'DROP_SHIP'
AND FosAgreementDefinitionE0.QUALIFIER_RULE_SET_ID = FosQualifierRuleSet.QUALIFIER_RULE_SET_ID(+)
ORDER BY FosAgreementDefinitionE0.AGREEMENT_NUMBER