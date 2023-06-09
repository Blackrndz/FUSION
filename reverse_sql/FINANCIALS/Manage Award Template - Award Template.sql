/* ****************************************************************************
 * $Revision: 74208 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-06-03 19:08:12 +0700 (Wed, 03 Jun 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/branches/core/v2.2.3.0.B/reverse_sql/FINANCIALS/Manage%20AutoPost%20Criteria%20Sets%20-%20AutoPost%20Criteria.sql $:
 * $Id: Manage AutoPost Criteria Sets - AutoPost Criteria.sql 74208 2020-06-03 12:08:12Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=GMS_AWARD_TEMPLATES_VL
--RSC_PREREQUISITE_OBJECTS=GMS_AWARD_HEADERS_VL 
--RSC_PREREQUISITE_OBJECTS=GMS_AWARD_HEADERS_B 


WITH SPONSOR AS (SELECT partiesE0.PARTY_NAME
	,partiesE0.PARTY_NUMBER
	,sponsorsE0.SPONSOR_ID 
	FROM GMS_SPONSORS_VL sponsorsE0
	,HZ_PARTIES partiesE0
	WHERE sponsorsE0.PARTY_ID = partiesE0.PARTY_ID)


SELECT gmsAWARDTEMPE0.TEMPLATE_NAME RES_TEMPLATE_NAME
,gmsAWARDTEMPE0.TEMPLATE_NUMBER RES_TEMPLATE_NUMBER
,(SELECT NAME 
	FROM HR_ALL_ORGANIZATION_UNITS
    WHERE ORGANIZATION_ID = gmsAWARDTEMPE0.BUSINESS_UNIT_ID
	) RES_BUSINESS_UNIT
,(SELECT NAME
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = gmsAWARDTEMPE0.LEGAL_ENTITY_ID
	) RES_LEGAL_ENTITY
,gmsAWARDTEMPE0.CURRENCY_CODE RES_CURRENCY
,(SELECT NAME 
	FROM OKC_CONTRACT_TYPES_VL 
	WHERE CONTRACT_TYPE_ID = gmsAWARDTEMPE0.CONTRACT_TYPE_ID
	) RES_CONTRACT_TYPE
,(SELECT DISPLAY_NAME
	FROM PER_PERSON_NAMES_F
	WHERE NAME_TYPE = 'GLOBAL'
	AND PERSON_ID = gmsAWARDHEABE0.PRINCIPAL_INVESTIGATOR_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) RES_PRINCIPAL_INVESTIGATOR_NAM
,(SELECT PERSON_NUMBER 
	FROM PER_ALL_PEOPLE_F 
	WHERE PERSON_ID = gmsAWARDHEABE0.PRINCIPAL_INVESTIGATOR_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
	) RES_PRINCIPAL_INVESTIGATOR_NUM
,(SELECT PARTY_NAME 
	FROM SPONSOR 
	WHERE SPONSOR_ID = gmsAWARDHEADE0.SPONSOR_ID
	) RES_PRIMARY_SPONSOR
,DECODE(gmsAWARDTEMPE0.LOC_ENABLED_FLAG,'Y','Yes','No') RES_ENABLE_LETTER_OF_CREDIT_BI
,TO_CHAR(gmsAWARDTEMPE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(gmsAWARDTEMPE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,gmsAWARDTEMPE0.DESCRIPTION RES_DESCRIPTION
,(SELECT NAME 
	FROM HR_ALL_ORGANIZATION_UNITS
    WHERE ORGANIZATION_ID = gmsAWARDHEADE0.AWARD_OWNING_ORG_ID
	) RES_ORGANIZATION
,(SELECT INSTITUTION_NAME
    FROM GMS_INSTITUTIONS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND INSTITUTION_ID = gmsAWARDHEADE0.INSTITUTION_ID
    ) RES_INSTITUTION
,gmsAWARDHEADE0.SPONSOR_AWARD_NUMBER RES_SPONSOR_AWARD_NUMBER
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_GMS_AWARD_PURPOSE_CODE'
    AND LOOKUP_CODE = gmsAWARDHEADE0.AWARD_PURPOSE_CODE
    ) RES_PURPOSE
,gmsAWARDHEADE0.AWARD_TYPE RES_TYPE
,DECODE(gmsAWARDTEMPE0.DEFAULT_TEMPLATE_FLAG,'Y','Yes','No') RES_SET_AS_DEFAULT_AWARD_TEMPL
,DECODE(gmsAWARDTEMPE0.CONTRACT_APPROVAL_FLAG,'Y','Yes','No') RES_SUBMIT_CONTRACT_FOR_APPROV
,gmsAWARDTEMPE0.PROJECT_TEMPLATE_ID RES_PROJECT_TEMPLATE
,DECODE(gmsAWARDHEADE0.COI_INST_POLICY_COMPLIANT,'Y','Yes','No') RES_CONFLICT_OF_INTEREST_COMPL
,DECODE(gmsAWARDHEADE0.COI_REVIEW_COMPLETED,'Y','Yes','No') RES_CONFLICT_OF_INTEREST_COM_0
,TO_CHAR(gmsAWARDHEADE0.COI_APPROVAL_DATE,'DD-Mon-YYYY') RES_CONFLICT_OF_INTEREST_APPRO
,(SELECT PARTY_NAME 
	FROM SPONSOR 
	WHERE SPONSOR_ID = gmsAWARDHEADE0.FT_PRIMARY_SPONSOR
	) RES_FLOW_THROUGH_FUNDS_SPONSOR
,gmsAWARDHEADE0.FT_REF_AWARD_NAME RES_FLOW_THROUGH_FUNDS_REFEREN
,TO_CHAR(gmsAWARDHEADE0.FT_FROM_DATE,'DD-Mon-YYYY') RES_FLOW_THROUGH_FUNDS_START_D
,TO_CHAR(gmsAWARDHEADE0.FT_TO_DATE,'DD-Mon-YYYY') RES_FLOW_THROUGH_FUNDS_END_DAT
,gmsAWARDHEADE0.FT_AMOUNT RES_FLOW_THROUGH_FUNDS_AMOUNT
,DECODE(gmsAWARDHEADE0.FT_IS_FEDERAL,'Y','Yes','No') RES_FLOW_THROUGH_FUNDS_FUNDED_
,DECODE(gmsAWARDHEADE0.IS_INTELL_PROP_REPORTED,'Y','Yes','No') RES_INTELLECTUAL_PROPERTY_INTE
,gmsAWARDHEADE0.INTELL_PROP_DESC RES_INTELLECTUAL_PROPERTY_DESC
,(SELECT NAME 
	FROM HR_ALL_ORGANIZATION_UNITS
    WHERE ORGANIZATION_ID = gmsAWARDHEADE0.PREV_AWARD_BU
	) RES_PREVIOUS_AWARD_BUSINESS_UN
,(SELECT TEMPLATE_NAME 
	FROM GMS_AWARD_TEMPLATES_VL 
	WHERE AWARD_HEADER_ID = gmsAWARDHEADE0.PREV_AWARD_ID
	) RES_PREVIOUS_AWARD_PREVIOUS_AW
,DECODE(gmsAWARDHEADE0.PREV_AWARD_RENEWAL_INPRG,'Y','Yes','No') RES_PREVIOUS_AWARD_RENEWAL_IN_
,DECODE(gmsAWARDHEADE0.PREV_AWARD_ABR,'Y','Yes','No') RES_PREVIOUS_AWARD_ACCOMPLISHM
,(SELECT IND_SCH_NAME 
	FROM PJF_IND_RATE_SCH_TL  
	WHERE IND_RATE_SCH_ID = gmsAWARDHEADE0.IDC_SCHEDULE_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_BURDEN_SCHEDULE
,gmsAWARDHEADE0.COST_IND_SCH_FIXED_DATE RES_FIXED_DATE
,gmsAWARDHEADE0.EXPANDED_AUTH_FLAG RES_EXPANDED_AUTHORITY
,gmsAWARDTEMPE0.BUDGET_PERIOD_COUNT RES_NUMBER_OF_BUDGET_PERIODS
,gmsAWARDTEMPE0.BUDGET_PERIOD_FREQUENCY RES_PERIOD_FREQUENCY
,gmsAWARDTEMPE0.BUDGET_PERIOD_PREFIX RES_USER_DEFINED_PREFIX
,gmsAWARDTEMPE0.BUDGET_PERIOD_SEPERATOR RES_SEPARATOR
,gmsAWARDTEMPE0.BUDGET_PERIOD_FORMAT RES_FORMAT
,(CASE WHEN gmsAWARDTEMPE0.BUDGET_PERIOD_SEPERATOR LIKE 'None' THEN 
		TO_CHAR(SYSDATE,gmsAWARDTEMPE0.BUDGET_PERIOD_FORMAT)
	ELSE 
		gmsAWARDTEMPE0.BUDGET_PERIOD_SEPERATOR||TO_CHAR(SYSDATE,gmsAWARDTEMPE0.BUDGET_PERIOD_FORMAT) 
	END) RES_SAMPLE_NAME
,(CASE WHEN EXISTS(SELECT AWARD_ID FROM GMS_AWARD_FUNDING_SOURCES_B a,GMS_FUNDING_SOURCES_VL b WHERE gmsAWARDHEADE0.ID = a.AWARD_ID
					AND a.FUNDING_SOURCE_ID = b.FUNDING_SOURCE_ID AND b.TYPE NOT IN ('S') ) THEN
		'Yes'
	ELSE 
		'No' 
	END) RES_COST_SHARED_BY_INTERNAL_SO
,gmsAWARDTEMPE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,gmsAWARDTEMPE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,gmsAWARDTEMPE0.CREATED_BY RSC_CREATED_BY
,gmsAWARDTEMPE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GMS_AWARD_TEMPLATES_VL gmsAWARDTEMPE0
,GMS_AWARD_HEADERS_VL gmsAWARDHEADE0
,GMS_AWARD_HEADERS_B  gmsAWARDHEABE0
WHERE gmsAWARDTEMPE0.AWARD_HEADER_ID = gmsAWARDHEADE0.ID
AND gmsAWARDHEADE0.ID = gmsAWARDHEABE0.ID
ORDER BY gmsAWARDTEMPE0.TEMPLATE_NAME